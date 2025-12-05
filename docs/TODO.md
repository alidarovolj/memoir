# 📋 TODO List - Memoir Project

Актуальный список задач для разработки. Обновлено: 5 декабря 2025

---

## 🔥 HIGH PRIORITY (Следующий спринт)

### 1. AI-Powered Task Suggestions 🤖

#### Backend (1-2 дня)
- [ ] **Endpoint: POST /api/v1/memories/{memory_id}/suggest-tasks**
  ```python
  # backend/app/api/v1/task_ai.py
  @router.post("/memories/{memory_id}/suggest-tasks")
  async def suggest_tasks_from_memory(
      memory_id: str,
      db: AsyncSession = Depends(get_db),
      current_user: User = Depends(get_current_user),
  ) -> List[TaskSuggestion]:
      """AI предлагает задачи на основе воспоминания"""
      pass
  ```

- [ ] **Метод TaskAIService.suggest_tasks_from_memory()**
  ```python
  # backend/app/services/task_ai_service.py
  async def suggest_tasks_from_memory(
      self,
      memory: Memory,
      limit: int = 3
  ) -> List[Dict[str, Any]]:
      """
      Промпт для GPT:
      - Если фильм → предложить похожие фильмы
      - Если книга → другие книги автора/жанра
      - Если место → похожие места
      - Если идея → конкретные действия
      
      Возвращает: [
        {
          "title": "Посмотреть Интерстеллар",
          "description": "Похожий научно-фантастический фильм",
          "time_scope": "weekly",
          "priority": "medium",
          "confidence": 0.95
        }
      ]
      """
      pass
  ```

#### Frontend (1 день)
- [ ] **Modal окно с AI suggestions**
  ```dart
  // lib/features/memories/presentation/widgets/task_suggestions_modal.dart
  class TaskSuggestionsModal extends StatelessWidget {
    final List<TaskSuggestion> suggestions;
    final Function(TaskSuggestion) onTaskSelected;
    
    // UI: список карточек с AI suggestions
    // Кнопка "Создать задачу" для каждого предложения
  }
  ```

- [ ] **Интеграция в CreateMemoryPage**
  ```dart
  // Показывать modal после создания воспоминания
  Future<void> _onMemorySaved(Memory memory) async {
    await memoryService.createMemory(memory);
    
    // Запросить AI suggestions
    final suggestions = await taskService.getSuggestedTasks(memory.id);
    
    if (suggestions.isNotEmpty) {
      _showTaskSuggestionsModal(suggestions);
    }
  }
  ```

- [ ] **Badge с количеством AI suggestions**
  ```dart
  // На Memory Card показывать badge если есть AI suggestions
  // "💡 3 suggested tasks"
  ```

---

### 2. Task → Memory Conversion 🔄

#### Backend (1 день)
- [ ] **Endpoint: POST /api/v1/tasks/{task_id}/convert-to-memory**
  ```python
  @router.post("/tasks/{task_id}/convert-to-memory")
  async def convert_task_to_memory(
      task_id: str,
      conversion_data: TaskToMemoryConversion,
      db: AsyncSession = Depends(get_db),
      current_user: User = Depends(get_current_user),
  ) -> Memory:
      """
      Конвертирует выполненную задачу в воспоминание
      
      Логика:
      1. Проверить что task.status == completed
      2. Создать Memory на основе Task
      3. Связать Memory с Task (related_task_id)
      4. AI обрабатывает новое воспоминание
      
      Примеры:
      - "Посмотреть Начало" → "Посмотрел Начало"
      - "Прочитать 1984" → "Прочитал 1984"
      """
      pass
  ```

- [ ] **Schema TaskToMemoryConversion**
  ```python
  class TaskToMemoryConversion(BaseModel):
      content: Optional[str] = None  # Дополнительный контент
      rating: Optional[float] = None  # Оценка (для фильмов/книг)
      notes: Optional[str] = None     # Заметки
  ```

#### Frontend (1 день)
- [ ] **Диалог при завершении задачи**
  ```dart
  // lib/features/tasks/presentation/widgets/complete_task_dialog.dart
  Future<void> _showCompleteTaskDialog(Task task) async {
    // Опции:
    // 1. [✓] Просто завершить
    // 2. [✓] Завершить + создать воспоминание
    //    - TextField для доп. контента
    //    - Rating stars (если фильм/книга)
  }
  ```

- [ ] **Auto-suggest conversion для категорий**
  ```dart
  // Если task.category в [movies, books, places]
  // → автоматически предлагать создать воспоминание
  ```

---

### 3. Smart Task Scheduling ⏰

#### Backend (1 день)
- [ ] **Метод TaskAIService.suggest_due_date()**
  ```python
  async def suggest_due_date(
      self,
      task_title: str,
      task_description: str,
  ) -> Dict[str, Any]:
      """
      AI определяет оптимальную дату и время
      
      Логика:
      - "Купить молоко" → today, high priority
      - "Посмотреть фильм" → this week, medium
      - "Прочитать книгу" → this month, low
      
      Возвращает:
      {
        "due_date": "2025-12-07",
        "scheduled_time": "20:00",
        "time_scope": "daily",
        "priority": "high",
        "reasoning": "..."
      }
      """
      pass
  ```

#### Frontend (1 день)
- [ ] **Auto-suggest в CreateTaskPage**
  ```dart
  // При вводе title/description
  // Показывать AI suggestions для:
  // - due_date
  // - scheduled_time
  // - priority
  // - time_scope
  
  // UI: карточка "AI предлагает: завтра в 14:00, высокий приоритет"
  // Кнопка "Применить" для быстрого заполнения
  ```

---

## 🟡 MEDIUM PRIORITY (Следующие 2-3 недели)

### 4. Recurring Tasks (Повторяющиеся задачи)

#### Backend (2-3 дня)
- [ ] **Добавить поля в Task модель**
  ```python
  is_recurring = Column(Boolean, default=False)
  recurrence_rule = Column(String)  # RRULE format (RFC 5545)
  parent_task_id = Column(UUID, ForeignKey("tasks.id"))  # Для экземпляров
  ```

- [ ] **RecurrenceRule enum**
  ```python
  class RecurrenceRule(str, enum.Enum):
      daily = "FREQ=DAILY"
      weekly = "FREQ=WEEKLY"
      monthly = "FREQ=MONTHLY"
      weekdays = "FREQ=WEEKLY;BYDAY=MO,TU,WE,TH,FR"
      custom = "custom"
  ```

- [ ] **Celery task: generate_recurring_instances**
  ```python
  @celery_app.task
  def generate_recurring_instances():
      """
      Запускается каждый день в 00:00
      Создает экземпляры recurring tasks на следующие 7 дней
      """
      pass
  ```

#### Frontend (2 дня)
- [ ] **UI для настройки повторений**
  ```dart
  // В CreateTaskPage:
  // - Toggle "Повторяющаяся задача"
  // - Dropdown: Ежедневно / Еженедельно / По будням / Кастомная
  // - Для weekly: выбор дней недели
  ```

- [ ] **Визуальная индикация recurring tasks**
  ```dart
  // Badge "🔁" на TaskCard
  // В деталях показывать "Повторяется: каждый день"
  ```

---

### 5. Subtasks (Подзадачи)

#### Backend (1-2 дня)
- [ ] **Таблица subtasks**
  ```sql
  CREATE TABLE subtasks (
      id UUID PRIMARY KEY,
      parent_task_id UUID REFERENCES tasks(id),
      title VARCHAR(500),
      completed BOOLEAN DEFAULT false,
      position INTEGER,  -- для сортировки
      created_at TIMESTAMP,
      updated_at TIMESTAMP
  );
  ```

- [ ] **CRUD endpoints для subtasks**
  ```python
  POST   /api/v1/tasks/{task_id}/subtasks
  GET    /api/v1/tasks/{task_id}/subtasks
  PUT    /api/v1/subtasks/{subtask_id}
  DELETE /api/v1/subtasks/{subtask_id}
  ```

#### Frontend (2 дня)
- [ ] **SubtasksList widget**
  ```dart
  // В TaskDetailPage
  // Список checkbox items
  // Кнопка "+ Добавить подзадачу"
  ```

- [ ] **Progress indicator**
  ```dart
  // На TaskCard: "3/5 выполнено"
  // Progress bar
  ```

---

### 6. Push Notifications 🔔

#### Backend (2 дня)
- [ ] **Firebase Cloud Messaging setup**
  ```python
  # backend/app/services/notification_service.py
  class NotificationService:
      async def send_task_reminder(task: Task, user: User):
          """Отправить напоминание о задаче"""
          pass
      
      async def send_task_due_soon(task: Task, user: User):
          """Задача скоро истекает"""
          pass
  ```

- [ ] **Celery task: check_task_reminders**
  ```python
  @celery_app.task
  def check_task_reminders():
      """
      Запускается каждый час
      Проверяет задачи с due_date в ближайшие 1-24 часа
      """
      pass
  ```

- [ ] **User preferences для notifications**
  ```python
  class UserNotificationSettings(Base):
      user_id = Column(UUID, ForeignKey("users.id"))
      fcm_token = Column(String)
      task_reminders_enabled = Column(Boolean)
      reminder_time = Column(Integer)  # за сколько часов до due_date
  ```

#### Frontend (2-3 дня)
- [ ] **FCM setup (Firebase Cloud Messaging)**
  ```dart
  // lib/core/services/notification_service.dart
  class NotificationService {
    Future<void> initialize();
    Future<void> requestPermission();
    Future<String?> getToken();
    void handleMessage(RemoteMessage message);
  }
  ```

- [ ] **Settings page для notifications**
  ```dart
  // Переключатели:
  // - Включить напоминания
  // - Напоминать за N часов до due_date
  // - Ежедневное напоминание в HH:MM
  ```

- [ ] **Local notifications для due dates**
  ```dart
  // flutter_local_notifications
  // Планировать local notification за день до due_date
  ```

---

## 🟢 LOW PRIORITY (Будущие версии)

### 7. Task Templates (Шаблоны)
- [ ] Backend: таблица task_templates
- [ ] Предустановленные шаблоны (Утренняя рутина, Workout)
- [ ] UI для создания своих шаблонов
- [ ] Быстрое создание задач из шаблона

### 8. Time Tracking (Отслеживание времени)
- [ ] Поле time_spent в Task
- [ ] Timer widget для активных задач
- [ ] История времени
- [ ] Статистика по времени

### 9. Task Attachments (Вложения)
- [ ] Загрузка файлов к задачам
- [ ] Изображения, PDF, документы
- [ ] Preview в TaskDetailPage

### 10. Collaborative Tasks (Совместные задачи)
- [ ] Таблица task_assignees
- [ ] Sharing tasks с другими пользователями
- [ ] Comments на задачи
- [ ] Activity log

### 11. Productivity Analytics 📊
- [ ] Dashboard со статистикой
- [ ] Completed tasks по дням/неделям
- [ ] Productivity score
- [ ] Графики и charts
- [ ] Streaks (серии выполненных задач)

### 12. Offline Mode 💾
- [ ] Local database (Hive/Isar)
- [ ] Sync queue
- [ ] Conflict resolution
- [ ] Background sync

---

## 🔧 Technical Improvements

### Backend
- [ ] **Тестирование**
  - [ ] Unit tests для services
  - [ ] Integration tests для API
  - [ ] Load testing
  
- [ ] **Performance**
  - [ ] Database query optimization
  - [ ] Caching strategy (Redis)
  - [ ] Connection pooling
  
- [ ] **Security**
  - [ ] Rate limiting
  - [ ] Input validation
  - [ ] SQL injection prevention
  - [ ] CORS настройка

### Frontend
- [ ] **Тестирование**
  - [ ] Widget tests
  - [ ] Unit tests
  - [ ] Integration tests
  
- [ ] **UI/UX**
  - [ ] Shimmer loading
  - [ ] Skeleton screens
  - [ ] Haptic feedback
  - [ ] Dark theme полная поддержка
  
- [ ] **Performance**
  - [ ] Image caching optimization
  - [ ] List virtualization
  - [ ] Memory leak detection

---

## 📝 Как использовать этот TODO

### Приоритизация:
1. **🔥 HIGH** - делаем в первую очередь (следующий спринт)
2. **🟡 MEDIUM** - после HIGH priority
3. **🟢 LOW** - когда будет время

### Workflow:
1. Выбираете задачу из HIGH PRIORITY
2. Отмечаете `[x]` когда выполнено
3. Коммитите с ссылкой на TODO
4. Переходите к следующей задаче

### Оценки времени:
- **Backend (1-2 дня)** - реальная оценка для одного разработчика
- **Frontend (1 день)** - UI + integration

### Обновление:
- TODO обновляется после каждого спринта
- Выполненные задачи переносятся в CHANGELOG
- Новые задачи добавляются по мере необходимости

---

**Последнее обновление:** 5 декабря 2025  
**Текущий фокус:** AI-Powered Task Suggestions 🤖
