"""Business logic for Task operations"""
from typing import List, Optional, Dict, Any
from datetime import datetime
from uuid import UUID
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select, and_, or_
from sqlalchemy.orm import joinedload

from app.models.task import Task, TaskStatus, TaskPriority, TimeScope
from app.models.memory import Memory, SourceType
from app.schemas.task import TaskCreate, TaskUpdate, TaskToMemoryConversion


class TaskService:
    """Service for task operations"""

    @staticmethod
    async def get_tasks(
        db: AsyncSession,
        user_id: UUID,
        status: Optional[TaskStatus] = None,
        time_scope: Optional[TimeScope] = None,
        priority: Optional[TaskPriority] = None,
        category_id: Optional[UUID] = None,
        skip: int = 0,
        limit: int = 50,
    ) -> tuple[List[Task], int]:
        """Get user's tasks with filters"""
        # Build query
        query = select(Task).where(Task.user_id == user_id)

        # Apply filters
        if status:
            query = query.where(Task.status == status)
        if time_scope:
            query = query.where(Task.time_scope == time_scope)
        if priority:
            query = query.where(Task.priority == priority)
        if category_id:
            query = query.where(Task.category_id == category_id)

        # Order by: urgent first, then by due_date, then by created_at
        query = query.order_by(
            Task.priority.desc(),
            Task.due_date.asc().nulls_last(),
            Task.created_at.desc()
        )

        # Get total count
        count_query = select(Task).where(Task.user_id == user_id)
        if status:
            count_query = count_query.where(Task.status == status)
        if time_scope:
            count_query = count_query.where(Task.time_scope == time_scope)
        if priority:
            count_query = count_query.where(Task.priority == priority)
        if category_id:
            count_query = count_query.where(Task.category_id == category_id)

        count_result = await db.execute(count_query)
        total = len(count_result.scalars().all())

        # Apply pagination
        query = query.offset(skip).limit(limit)

        # Execute
        result = await db.execute(query.options(joinedload(Task.category)))
        tasks = result.scalars().all()

        return tasks, total

    @staticmethod
    async def get_task_by_id(
        db: AsyncSession,
        task_id: UUID,
        user_id: UUID,
    ) -> Optional[Task]:
        """Get task by ID"""
        result = await db.execute(
            select(Task)
            .where(and_(Task.id == task_id, Task.user_id == user_id))
            .options(joinedload(Task.category), joinedload(Task.related_memory))
        )
        return result.scalar_one_or_none()

    @staticmethod
    async def create_task(
        db: AsyncSession,
        user_id: UUID,
        task_data: TaskCreate,
    ) -> Task:
        """Create a new task"""
        task = Task(
            user_id=user_id,
            title=task_data.title,
            description=task_data.description,
            due_date=task_data.due_date,
            scheduled_time=task_data.scheduled_time,
            status=task_data.status,
            priority=task_data.priority,
            time_scope=task_data.time_scope,
            category_id=task_data.category_id,
            related_memory_id=task_data.related_memory_id,
            tags=task_data.tags,
        )

        db.add(task)
        await db.commit()
        await db.refresh(task)

        return task

    @staticmethod
    async def update_task(
        db: AsyncSession,
        task_id: UUID,
        user_id: UUID,
        task_data: TaskUpdate,
    ) -> Optional[Task]:
        """Update a task"""
        task = await TaskService.get_task_by_id(db, task_id, user_id)
        if not task:
            return None

        # Update fields
        update_data = task_data.model_dump(exclude_unset=True)
        for field, value in update_data.items():
            setattr(task, field, value)

        task.updated_at = datetime.utcnow()
        await db.commit()
        await db.refresh(task)

        return task

    @staticmethod
    async def complete_task(
        db: AsyncSession,
        task_id: UUID,
        user_id: UUID,
    ) -> Optional[Task]:
        """Mark task as completed"""
        task = await TaskService.get_task_by_id(db, task_id, user_id)
        if not task:
            return None

        task.status = TaskStatus.completed
        task.completed_at = datetime.utcnow()
        task.updated_at = datetime.utcnow()

        await db.commit()
        await db.refresh(task)

        return task

    @staticmethod
    async def delete_task(
        db: AsyncSession,
        task_id: UUID,
        user_id: UUID,
    ) -> bool:
        """Delete a task"""
        task = await TaskService.get_task_by_id(db, task_id, user_id)
        if not task:
            return False

        await db.delete(task)
        await db.commit()

        return True

    @staticmethod
    async def get_tasks_by_date_range(
        db: AsyncSession,
        user_id: UUID,
        start_date: datetime,
        end_date: datetime,
    ) -> List[Task]:
        """Get tasks within a date range"""
        result = await db.execute(
            select(Task)
            .where(
                and_(
                    Task.user_id == user_id,
                    Task.due_date >= start_date,
                    Task.due_date <= end_date,
                )
            )
            .options(joinedload(Task.category))
            .order_by(Task.due_date.asc())
        )
        return result.scalars().all()

    @staticmethod
    async def convert_to_memory(
        db: AsyncSession,
        task_id: UUID,
        user_id: UUID,
        conversion_data: TaskToMemoryConversion,
    ) -> Optional[Memory]:
        """
        Convert a completed task to a memory
        
        Steps:
        1. Get task and verify it's completed
        2. Generate memory title (convert future tense to past)
        3. Create memory with task data + additional notes
        4. Link memory to task
        5. AI will process memory in background (classification, embeddings)
        
        Examples:
        - "Посмотреть Начало" → "Посмотрел Начало"
        - "Прочитать 1984" → "Прочитал 1984"
        - "Купить молоко" → "Купил молоко"
        """
        # Get task
        task = await TaskService.get_task_by_id(db, task_id, user_id)
        if not task:
            return None
        
        # Verify task is completed
        if task.status != TaskStatus.completed:
            return None
        
        # Generate memory title (simple past tense conversion)
        memory_title = TaskService._convert_to_past_tense(task.title)
        
        # Build memory content
        memory_content = task.description or ""
        
        # Add additional content from conversion_data
        if conversion_data.content:
            if memory_content:
                memory_content += f"\n\n{conversion_data.content}"
            else:
                memory_content = conversion_data.content
        
        # Add notes if provided
        if conversion_data.notes:
            memory_content += f"\n\n📝 Заметки: {conversion_data.notes}"
        
        # Add rating if provided
        if conversion_data.rating is not None:
            memory_content += f"\n\n⭐ Оценка: {conversion_data.rating}/10"
        
        # If no content at all, use task title
        if not memory_content:
            memory_content = f"Выполнено: {memory_title}"
        
        # Build memory metadata
        memory_metadata = {}
        if conversion_data.rating:
            memory_metadata['rating'] = conversion_data.rating
        if task.completed_at:
            memory_metadata['completed_at'] = task.completed_at.isoformat()
        
        # Create memory
        memory = Memory(
            user_id=user_id,
            category_id=task.category_id,
            related_task_id=task.id,
            title=memory_title,
            content=memory_content,
            source_type=SourceType.text,
            image_url=conversion_data.image_url,
            backdrop_url=conversion_data.backdrop_url,
            memory_metadata=memory_metadata,
        )
        
        db.add(memory)
        await db.commit()
        await db.refresh(memory)
        
        # Note: AI processing (classification, embeddings) will be handled by
        # background tasks or celery workers in production
        
        return memory
    
    @staticmethod
    def _convert_to_past_tense(title: str) -> str:
        """
        Simple conversion from future/imperative to past tense (Russian)
        This is a basic implementation - can be improved with NLP
        """
        # Common patterns for Russian verbs
        replacements = {
            'Посмотреть': 'Посмотрел',
            'Прочитать': 'Прочитал',
            'Купить': 'Купил',
            'Сходить': 'Сходил',
            'Посетить': 'Посетил',
            'Написать': 'Написал',
            'Сделать': 'Сделал',
            'Позвонить': 'Позвонил',
            'Встретиться': 'Встретился',
            'Приготовить': 'Приготовил',
            'Убрать': 'Убрал',
            'Помыть': 'Помыл',
            'Почистить': 'Почистил',
            'Отправить': 'Отправил',
            'Забрать': 'Забрал',
            'посмотреть': 'посмотрел',
            'прочитать': 'прочитал',
            'купить': 'купил',
            'сходить': 'сходил',
            'посетить': 'посетил',
            'написать': 'написал',
            'сделать': 'сделал',
            'позвонить': 'позвонил',
            'встретиться': 'встретился',
            'приготовить': 'приготовил',
            'убрать': 'убрал',
            'помыть': 'помыл',
            'почистить': 'почистил',
            'отправить': 'отправил',
            'забрать': 'забрал',
        }
        
        result = title
        for future, past in replacements.items():
            result = result.replace(future, past)
        
        return result

