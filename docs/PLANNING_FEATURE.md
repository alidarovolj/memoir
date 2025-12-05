# 📅 Planning & Tasks Feature - Архитектура

## 🎯 Концепция

**Memoir = Воспоминания + Планирование**
- **Memories** (прошлое) - что уже произошло, опыт
- **Tasks** (будущее) - что нужно сделать, планы
- **AI Bridge** - умная связь между прошлым и будущим

---

## 📊 Структура базы данных

### Таблица `tasks`

```sql
CREATE TABLE tasks (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    
    -- Basic info
    title VARCHAR(500) NOT NULL,
    description TEXT,
    
    -- Timing
    due_date TIMESTAMP,
    completed_at TIMESTAMP,
    
    -- Status
    status VARCHAR(20) DEFAULT 'pending', -- pending, in_progress, completed, cancelled
    priority VARCHAR(20) DEFAULT 'medium', -- low, medium, high, urgent
    
    -- Time scope
    time_scope VARCHAR(20) DEFAULT 'daily', -- daily, weekly, monthly, long_term
    
    -- Relations
    category_id UUID REFERENCES categories(id),
    related_memory_id UUID REFERENCES memories(id), -- Связь с воспоминанием
    
    -- AI
    ai_suggested BOOLEAN DEFAULT false, -- Предложено ли AI
    ai_confidence FLOAT,
    tags TEXT[],
    
    -- Metadata
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

CREATE INDEX idx_tasks_user_id ON tasks(user_id);
CREATE INDEX idx_tasks_status ON tasks(status);
CREATE INDEX idx_tasks_time_scope ON tasks(time_scope);
CREATE INDEX idx_tasks_due_date ON tasks(due_date);
```

---

## 🏗️ Backend структура

### Models

```python
# app/models/task.py

class TaskStatus(str, enum.Enum):
    pending = "pending"
    in_progress = "in_progress"
    completed = "completed"
    cancelled = "cancelled"

class TaskPriority(str, enum.Enum):
    low = "low"
    medium = "medium"
    high = "high"
    urgent = "urgent"

class TimeScope(str, enum.Enum):
    daily = "daily"
    weekly = "weekly"
    monthly = "monthly"
    long_term = "long_term"

class Task(Base):
    __tablename__ = "tasks"
    
    id = Column(UUID, primary_key=True, default=uuid.uuid4)
    user_id = Column(UUID, ForeignKey("users.id"), nullable=False)
    
    title = Column(String(500), nullable=False)
    description = Column(Text)
    
    due_date = Column(DateTime)
    completed_at = Column(DateTime)
    
    status = Column(SQLEnum(TaskStatus), default=TaskStatus.pending)
    priority = Column(SQLEnum(TaskPriority), default=TaskPriority.medium)
    time_scope = Column(SQLEnum(TimeScope), default=TimeScope.daily)
    
    category_id = Column(UUID, ForeignKey("categories.id"))
    related_memory_id = Column(UUID, ForeignKey("memories.id"))
    
    ai_suggested = Column(Boolean, default=False)
    ai_confidence = Column(Float)
    tags = Column(ARRAY(String))
    
    created_at = Column(DateTime, default=datetime.utcnow)
    updated_at = Column(DateTime, onupdate=datetime.utcnow)
    
    # Relationships
    user = relationship("User", back_populates="tasks")
    category = relationship("Category")
    related_memory = relationship("Memory")
```

### API Endpoints

```python
# app/api/v1/tasks.py

@router.get("/tasks")
async def get_tasks(
    status: Optional[TaskStatus] = None,
    time_scope: Optional[TimeScope] = None,
    date: Optional[str] = None,  # YYYY-MM-DD для дневных задач
):
    """Получить список задач с фильтрами"""
    pass

@router.post("/tasks")
async def create_task(task_data: TaskCreate):
    """Создать новую задачу"""
    pass

@router.put("/tasks/{task_id}")
async def update_task(task_id: str, task_data: TaskUpdate):
    """Обновить задачу"""
    pass

@router.post("/tasks/{task_id}/complete")
async def complete_task(task_id: str):
    """Отметить задачу выполненной
    
    При выполнении:
    1. Меняем status на completed
    2. Ставим completed_at
    3. AI может предложить создать Memory
    """
    pass

@router.post("/tasks/{task_id}/convert-to-memory")
async def convert_task_to_memory(task_id: str):
    """Конвертировать задачу в воспоминание
    
    Например: "Посмотреть Начало" → "Посмотрел Начало"
    """
    pass

@router.post("/memories/{memory_id}/suggest-tasks")
async def suggest_tasks_from_memory(memory_id: str):
    """AI предлагает задачи на основе воспоминания
    
    Примеры:
    - "Посмотрел Начало" → "Посмотреть Интерстеллар" (похожий фильм)
    - "Прочитал 1984" → "Прочитать Animal Farm" (тот же автор)
    - "Побывал в ресторане X" → "Попробовать ресторан Y" (похожая кухня)
    """
    pass
```

### AI Service для задач

```python
# app/services/task_ai_service.py

class TaskAIService:
    
    async def suggest_tasks_from_memory(
        self,
        memory: Memory,
    ) -> List[Dict[str, Any]]:
        """
        Предложить задачи на основе воспоминания
        
        Промпт для GPT:
        "Пользователь сохранил воспоминание: {memory}
        Предложи 2-3 релевантные задачи, которые он может захотеть сделать.
        
        Если это фильм - предложи похожие фильмы
        Если это книга - другие книги автора или жанра
        Если это место - похожие места
        Если это идея - действия для реализации
        "
        """
        pass
    
    async def suggest_memory_from_task(
        self,
        task: Task,
    ) -> Optional[str]:
        """
        При создании задачи предложить связанное воспоминание
        
        Например:
        - Задача "Посмотреть Начало" → Есть похожие фильмы в воспоминаниях?
        """
        pass
    
    async def auto_categorize_task(
        self,
        task_text: str,
    ) -> Dict[str, Any]:
        """
        Автоматическая категоризация задачи
        
        Определяет:
        - category (movies, books, etc)
        - time_scope (daily, weekly, monthly, long_term)
        - priority (low, medium, high, urgent)
        - suggested_due_date
        """
        pass
```

---

## 📱 Flutter структура

### Domain Layer

```dart
// lib/features/tasks/domain/entities/task.dart

enum TaskStatus {
  pending,
  inProgress,
  completed,
  cancelled,
}

enum TaskPriority {
  low,
  medium,
  high,
  urgent,
}

enum TimeScope {
  daily,
  weekly,
  monthly,
  longTerm,
}

class Task {
  final String id;
  final String userId;
  final String title;
  final String? description;
  final DateTime? dueDate;
  final DateTime? completedAt;
  final TaskStatus status;
  final TaskPriority priority;
  final TimeScope timeScope;
  final String? categoryId;
  final String? categoryName;
  final String? relatedMemoryId;
  final bool aiSuggested;
  final double? aiConfidence;
  final List<String> tags;
  final DateTime createdAt;
  final DateTime updatedAt;
}
```

### UI Pages

```dart
// Основные страницы:

1. TasksOverviewPage - Обзор всех задач
   - Вкладки: Сегодня / Неделя / Месяц / Долгосрочные
   - Фильтры по статусу
   - AI suggestions badge

2. DailyPlannerPage - Дневное планирование
   - Календарь
   - Задачи на день
   - Completed tasks
   - Quick add

3. WeeklyPlannerPage - Недельное планирование
   - 7 дней
   - Drag & drop между днями
   
4. CreateTaskPage - Создание задачи
   - Поля: title, description, due_date, priority, time_scope
   - AI suggestions
   - Link to memory (опционально)

5. TaskDetailPage - Детали задачи
   - Все поля
   - Связанное воспоминание (если есть)
   - Convert to memory (при завершении)
```

### AI Integration в UI

```dart
// При создании воспоминания:

class CreateMemoryPage extends StatelessWidget {
  
  Future<void> _onMemorySaved(Memory memory) async {
    // 1. Сохраняем воспоминание
    await memoryService.createMemory(memory);
    
    // 2. Запрашиваем AI suggestions для задач
    final suggestions = await taskService.getSuggestedTasks(memory.id);
    
    // 3. Показываем modal с предложениями
    if (suggestions.isNotEmpty) {
      _showTaskSuggestionsModal(suggestions);
    }
  }
  
  void _showTaskSuggestionsModal(List<TaskSuggestion> suggestions) {
    showModalBottomSheet(
      context: context,
      builder: (context) => TaskSuggestionsModal(
        suggestions: suggestions,
        onTaskSelected: (suggestion) {
          // Создаем задачу из предложения
          _createTaskFromSuggestion(suggestion);
        },
      ),
    );
  }
}
```

---

## 🤖 AI Промпты

### 1. Suggest Tasks from Memory

```python
system_prompt = """Ты — AI-ассистент для приложения Personal Memory & Planning.
Пользователь сохранил воспоминание. Твоя задача: предложить 2-3 релевантные задачи.

Правила:
- Фильмы → похожие фильмы, сериалы
- Книги → другие книги автора или жанра
- Места → похожие места, рестораны
- Идеи → конкретные шаги для реализации
- Продукты → похожие продукты или где купить

Верни JSON:
{
  "suggestions": [
    {
      "title": "Посмотреть Интерстеллар",
      "description": "Похожий научно-фантастический фильм от Кристофера Нолана",
      "time_scope": "weekly",
      "priority": "medium",
      "confidence": 0.95
    }
  ]
}
"""
```

### 2. Categorize Task

```python
system_prompt = """Проанализируй задачу и определи:
1. Категорию (movies, books, places, ideas, recipes, products, other)
2. Временной масштаб (daily, weekly, monthly, long_term)
3. Приоритет (low, medium, high, urgent)
4. Рекомендуемую дату выполнения

Верни JSON:
{
  "category": "movies",
  "time_scope": "weekly",
  "priority": "medium",
  "suggested_due_date": "2025-12-10",
  "reasoning": "Просмотр фильма обычно планируется на неделю"
}
"""
```

---

## 🎨 UI/UX Концепция

### Navigation

```
Bottom Navigation Bar:
┌─────────────────────────────────────┐
│  📚 Memories  │  📅 Planning  │  🔍  │
└─────────────────────────────────────┘
```

### Planning Tab Structure

```
Planning Page
├── Today (дневные задачи)
│   ├── Morning tasks
│   ├── Afternoon tasks
│   └── Evening tasks
│
├── This Week (недельные)
│   ├── Mon │ Tue │ Wed │ Thu │ Fri │ Sat │ Sun
│   └── Drag & drop между днями
│
├── This Month (месячные)
│   ├── Календарь
│   └── Задачи на месяц
│
└── Long-term (долгосрочные)
    ├── Goals
    └── Projects
```

---

## 🔄 Workflow Examples

### Example 1: Memory → Task

```
1. Пользователь: "Посмотрел фильм Начало"
2. Сохраняется Memory с category=movies
3. AI анализирует и предлагает:
   ✨ "Посмотреть Интерстеллар" (time_scope=weekly)
   ✨ "Посмотреть Престиж" (time_scope=weekly)
4. Пользователь выбирает одну → создается Task
```

### Example 2: Task → Memory

```
1. Пользователь создает задачу: "Посмотреть 1984"
2. Выполняет задачу (complete)
3. Система предлагает:
   "Создать воспоминание о прочтении?"
4. Автоматически создается Memory: "Прочитал 1984"
5. AI обрабатывает и добавляет теги, категорию
```

### Example 3: Обычные дела

```
1. "Купить молоко" → Task (daily, high priority)
2. "Позвонить маме" → Task (daily, medium)
3. "Сделать презентацию" → Task (weekly, urgent)
```

---

## 📊 Приоритизация разработки

### ✅ РЕАЛИЗОВАНО:

#### Core Features
- ✅ Stories Feature (создание, просмотр, группировка, автопрогресс)
- ✅ Smart Content Search (TMDB, Google Books, AI Intent Detection)
- ✅ Banner Carousel (автопролистывание, индикаторы)
- ✅ SMS Authentication (SMS Traffic)
- ✅ Google Sign In (Firebase)
- ✅ Memory Cards с изображениями и backdrop
- ✅ AI Classification (GPT-4o-mini)
- ✅ Vector Search (pgvector)

#### Planning Feature - Phase 1 & 2 (ЗАВЕРШЕНО) ✅

**Backend:**
- ✅ Task модель с полями:
  - id, user_id, title, description
  - due_date, scheduled_time (HH:MM формат)
  - completed_at, status, priority, time_scope
  - category_id, related_memory_id
  - ai_suggested, ai_confidence, tags
- ✅ CRUD API endpoints (/api/v1/tasks)
- ✅ Миграция БД с добавлением scheduled_time
- ✅ TaskService для бизнес-логики
- ✅ TaskAIService endpoints (готовы для AI интеграции)

**Flutter:**
- ✅ Task Models (freezed + json_serializable)
- ✅ Remote DataSource с Dio
- ✅ Repository pattern
- ✅ Tasks Page с вкладками:
  - ✅ **Kanban Board** (3 колонки: Запланировано, В работе, Выполнено)
  - ✅ **Daily Timeline** (временные слоты: Утро, День, Вечер)
  - ✅ **Monthly View** (календарь на месяц)
- ✅ Create Task Page с полями:
  - ✅ Title и description
  - ✅ Priority selector (low, medium, high, urgent)
  - ✅ Due date picker (календарь)
  - ✅ Time scope (daily, weekly, monthly, long_term)
  - ✅ Scheduled time picker
- ✅ Task Card с цветовыми индикаторами
- ✅ Drag & Drop:
  - ✅ Между колонками Kanban
  - ✅ Между временными слотами Timeline
- ✅ CRUD операции:
  - ✅ Создание задач
  - ✅ Завершение задач (status → completed)
  - ✅ Удаление задач
- ✅ Интеграция с Bottom Navigation
- ✅ Счетчики задач по статусам
- ✅ Pull-to-refresh
- ✅ Empty states

### 🚧 ТЕКУЩИЙ ФОКУС: AI Integration (Phase 3)

### Phase 3: AI Integration (3-5 дней) ⏳ В РАБОТЕ
- ⏳ **Suggest tasks from memories:**
  - Backend endpoint готов
  - Нужно: UI modal при создании воспоминания
  - AI промпт для анализа воспоминаний
  
- ⏳ **Auto-categorize tasks:**
  - Backend endpoint готов
  - Нужно: Автоопределение категории при создании
  
- ⏳ **Task → Memory conversion:**
  - Нужно: Endpoint для конвертации
  - Нужно: UI flow при завершении задачи
  
- ⏳ **Smart due date suggestions:**
  - Нужно: AI анализ для оптимального времени

### Phase 4: Advanced Features (опционально) 🔮
- ⏳ Recurring tasks (повторяющиеся задачи)
- ⏳ Subtasks (подзадачи)
- ⏳ Time tracking (отслеживание времени)
- ⏳ Productivity analytics (статистика)
- ⏳ Task templates (шаблоны задач)
- ⏳ Smart reminders (умные напоминания)

---

## 💡 Дополнительные идеи

### Gamification
- Streaks (серии выполненных задач)
- Points за completion
- Achievements

### Smart Reminders
- AI определяет оптимальное время напоминания
- Context-aware (на основе локации, времени дня)

### Templates
- Утренняя рутина
- Вечерняя рутина
- Workout routine
- Study plan

### Collaboration
- Shared tasks
- Family planning

---

## 🚀 Next Steps

1. **Обновить ROADMAP.md** с Planning feature
2. **Создать миграцию** для таблицы tasks
3. **Реализовать базовый CRUD** для задач
4. **UI для дневного планера**
5. **AI integration** для suggestions

**Готовы начать?** 🎯

