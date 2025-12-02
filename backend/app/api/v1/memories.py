"""Memories endpoints"""
from typing import Optional
from fastapi import APIRouter, Depends, HTTPException, status, Query
from sqlalchemy.ext.asyncio import AsyncSession

from app.db.session import get_db
from app.api.deps import get_current_user
from app.models.user import User
from app.schemas.memory import Memory, MemoryCreate, MemoryUpdate, MemoryList
from app.services.memory_service import MemoryService
from app.core.exceptions import NotFoundError
import math

router = APIRouter()


@router.get("", response_model=MemoryList)
async def get_memories(
    category_id: Optional[str] = Query(None, description="Filter by category ID"),
    page: int = Query(1, ge=1, description="Page number"),
    size: int = Query(20, ge=1, le=100, description="Page size"),
    db: AsyncSession = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    """Get list of memories with pagination"""
    skip = (page - 1) * size
    
    memories, total = await MemoryService.get_memories(
        db,
        user_id=str(current_user.id),
        category_id=category_id,
        skip=skip,
        limit=size,
    )
    
    pages = math.ceil(total / size) if total > 0 else 0
    
    return {
        "items": memories,
        "total": total,
        "page": page,
        "size": size,
        "pages": pages,
    }


@router.post("", response_model=Memory, status_code=status.HTTP_201_CREATED)
async def create_memory(
    memory_data: MemoryCreate,
    db: AsyncSession = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    """Create new memory"""
    try:
        memory = await MemoryService.create_memory(
            db,
            user_id=str(current_user.id),
            memory_data=memory_data,
        )
        
        # Trigger background AI processing
        from app.tasks.ai_tasks import process_memory_full
        process_memory_full.delay(str(memory.id))
        
        return memory
    except NotFoundError as e:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail=str(e),
        )


@router.get("/{memory_id}", response_model=Memory)
async def get_memory(
    memory_id: str,
    db: AsyncSession = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    """Get memory details"""
    try:
        memory = await MemoryService.get_memory_by_id(
            db,
            memory_id=memory_id,
            user_id=str(current_user.id),
        )
        return memory
    except NotFoundError:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Memory not found",
        )


@router.put("/{memory_id}", response_model=Memory)
async def update_memory(
    memory_id: str,
    memory_data: MemoryUpdate,
    db: AsyncSession = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    """Update memory"""
    try:
        memory = await MemoryService.update_memory(
            db,
            memory_id=memory_id,
            user_id=str(current_user.id),
            memory_data=memory_data,
        )
        return memory
    except NotFoundError as e:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail=str(e),
        )


@router.delete("/{memory_id}", status_code=status.HTTP_204_NO_CONTENT)
async def delete_memory(
    memory_id: str,
    db: AsyncSession = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    """Delete memory"""
    try:
        await MemoryService.delete_memory(
            db,
            memory_id=memory_id,
            user_id=str(current_user.id),
        )
    except NotFoundError:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Memory not found",
        )
