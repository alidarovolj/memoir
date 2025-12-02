# 🏗️ Архитектура Memoir - Personal Memory AI

Полное описание архитектуры приложения, технологий и принятых решений.

---

## 📐 Общая архитектура системы

```
┌─────────────────────────────────────────────────────────────┐
│                        Flutter App                           │
│  ┌──────────────────────────────────────────────────────┐  │
│  │  Presentation Layer (UI + BLoC)                      │  │
│  └────────────────┬─────────────────────────────────────┘  │
│                   │                                          │
│  ┌────────────────▼─────────────────────────────────────┐  │
│  │  Domain Layer (Entities + UseCases + Repositories)   │  │
│  └────────────────┬─────────────────────────────────────┘  │
│                   │                                          │
│  ┌────────────────▼─────────────────────────────────────┐  │
│  │  Data Layer (Models + DataSources + Repo Impl)       │  │
│  └────────────────┬─────────────────────────────────────┘  │
└───────────────────┼─────────────────────────────────────────┘
                    │ HTTP / REST API
                    │
        ┌───────────▼──────────────┐
        │   FastAPI Backend        │
        │  ┌────────────────────┐  │
        │  │  API Endpoints     │  │
        │  └──────┬─────────────┘  │
        │         │                 │
        │  ┌──────▼─────────────┐  │
        │  │  Services          │  │
        │  └──────┬─────────────┘  │
        │         │                 │
        │  ┌──────▼─────────────┐  │
        │  │  Models (ORM)      │  │
        │  └──────┬─────────────┘  │
        └─────────┼─────────────────┘
                  │
     ┌────────────┼────────────────┐
     │            │                 │
┌────▼────┐  ┌───▼─────┐    ┌─────▼──────┐
│PostgreSQL│  │  Redis  │    │  OpenAI    │
│+pgvector │  │         │    │   API      │
└──────────┘  └────┬────┘    └────────────┘
                   │
              ┌────▼─────┐
              │  Celery  │
              │  Worker  │
              └──────────┘
```

---

## 🔄 Поток данных

### 1. Создание воспоминания

```
User (Flutter) → POST /api/v1/memories
                     ↓
              FastAPI Endpoint
                     ↓
              Memory Service
                     ↓
              PostgreSQL (save)
                     ↓
              Return Memory ← Response
                     ↓
              Trigger Celery Task (async)
                     ↓
         ┌───────────┴────────────┐
         │                        │
    Classify         Generate Embedding
    (OpenAI)         (OpenAI)
         │                        │
         ↓                        ↓
    Update Memory            Save to embeddings
    (category, tags)         table (vector)
```

### 2. Семантический поиск

```
User Query → POST /api/v1/search/semantic?q=...
                     ↓
              Generate Query Embedding
                     (OpenAI API)
                     ↓
              Vector Similarity Search
                     (pgvector)
                     ↓
              Fetch Matching Memories
                     ↓
              Return Results
```

---

## 🎨 Frontend: Clean Architecture (Flutter)

### Слои и зависимости

```
┌──────────────────────────────────────────────────┐
│         Presentation Layer                        │
│  - Pages (UI Screens)                            │
│  - Widgets (Reusable components)                 │
│  - BLoC (State Management)                       │
│                                                   │
│  Зависит от → Domain Layer                       │
└────────────────┬─────────────────────────────────┘
                 │
                 ↓ (uses)
┌────────────────────────────────────────────────────┐
│         Domain Layer                               │
│  - Entities (Business models)                     │
│  - Repositories (Interfaces)                      │
│  - UseCases (Business logic)                      │
│                                                   │
│  Не зависит от внешних слоёв!                     │
└────────────────┬─────────────────────────────────┘
                 │
                 ↑ (implements)
┌────────────────────────────────────────────────────┐
│         Data Layer                                 │
│  - Models (JSON DTO)                              │
│  - DataSources (Remote API, Local Cache)          │
│  - Repository Implementations                      │
│                                                   │
│  Зависит от → Domain Layer                        │
└────────────────────────────────────────────────────┘
```

### Пример: Memory Feature

```dart
// Domain Layer (entities/memory.dart)
class Memory {
  final String id;
  final String title;
  // ... pure business logic entity
}

// Domain Layer (repositories/memory_repository.dart)
abstract class MemoryRepository {
  Future<Either<Failure, List<Memory>>> getMemories();
  Future<Either<Failure, Memory>> createMemory(MemoryCreate data);
}

// Data Layer (models/memory_model.dart)
class MemoryModel extends Memory {
  // JSON serialization
  factory MemoryModel.fromJson(Map<String, dynamic> json);
  Map<String, dynamic> toJson();
}

// Data Layer (repositories/memory_repository_impl.dart)
class MemoryRepositoryImpl implements MemoryRepository {
  final MemoryRemoteDataSource remoteDataSource;
  
  @override
  Future<Either<Failure, List<Memory>>> getMemories() async {
    try {
      final models = await remoteDataSource.getMemories();
      return Right(models.map((m) => m.toEntity()).toList());
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}

// Presentation Layer (bloc/memory_list_bloc.dart)
class MemoryListBloc extends Bloc<MemoryListEvent, MemoryListState> {
  final GetMemoriesUseCase getMemoriesUseCase;
  
  on<LoadMemories>((event, emit) async {
    emit(MemoryListLoading());
    final result = await getMemoriesUseCase();
    result.fold(
      (failure) => emit(MemoryListError(failure.message)),
      (memories) => emit(MemoryListLoaded(memories)),
    );
  });
}
```

### State Management (BLoC Pattern)

```
┌──────────────┐
│   UI Widget  │
│              │
│  listens to  │
└──────┬───────┘
       │
       │ State Stream
       │
┌──────▼───────────────┐
│       BLoC           │
│  ┌────────────────┐  │
│  │  State         │  │ (Immutable)
│  └────────────────┘  │
│         ▲            │
│         │            │
│  ┌──────┴─────────┐  │
│  │  Event Handler │  │
│  └──────▲─────────┘  │
└─────────┼────────────┘
          │
          │ Events
┌─────────┴────────┐
│   User Actions   │
│  (button press,  │
│   page load)     │
└──────────────────┘
```

---

## 🐍 Backend: Layered Architecture (FastAPI)

### Слои

```
┌─────────────────────────────────────────┐
│         API Layer                        │
│  - Endpoints (routes)                   │
│  - Request/Response handling            │
│  - Validation (Pydantic)                │
└──────────────┬──────────────────────────┘
               │
               ↓ calls
┌──────────────────────────────────────────┐
│         Service Layer                     │
│  - Business logic                        │
│  - Orchestration                         │
│  - Error handling                        │
└──────────────┬──────────────────────────┘
               │
               ↓ uses
┌──────────────────────────────────────────┐
│         Repository/Model Layer            │
│  - Database operations (SQLAlchemy)      │
│  - ORM models                            │
│  - Database sessions                     │
└──────────────────────────────────────────┘
```

### Пример: Memory Create Flow

```python
# API Layer (api/v1/memories.py)
@router.post("", response_model=Memory)
async def create_memory(
    memory_data: MemoryCreate,
    db: AsyncSession = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    memory = await MemoryService.create_memory(
        db, str(current_user.id), memory_data
    )
    
    # Trigger async AI processing
    process_memory_full.delay(str(memory.id))
    
    return memory

# Service Layer (services/memory_service.py)
class MemoryService:
    @staticmethod
    async def create_memory(
        db: AsyncSession,
        user_id: str,
        memory_data: MemoryCreate
    ) -> Memory:
        # Validate category if provided
        if memory_data.category_id:
            category = await db.get(Category, memory_data.category_id)
            if not category:
                raise NotFoundError("Category not found")
        
        # Create memory
        new_memory = Memory(
            user_id=user_id,
            title=memory_data.title,
            content=memory_data.content,
            # ...
        )
        
        db.add(new_memory)
        await db.commit()
        await db.refresh(new_memory)
        
        return new_memory

# Task Layer (tasks/ai_tasks.py)
@celery_app.task(name="process_memory_full")
def process_memory_full(memory_id: str):
    # 1. Classify
    classification = classify_memory_async(memory_id)
    
    # 2. Generate embedding
    embedding = generate_embedding_async(memory_id)
    
    return {"classification": classification, "embedding": embedding}
```

---

## 🤖 AI Integration Architecture

### OpenAI Services

```
┌─────────────────────────────────────────────────┐
│             AIService                            │
│  ┌───────────────────────────────────────────┐  │
│  │  classify_memory()                        │  │
│  │  - GPT-4o-mini                            │  │
│  │  - System prompt with categories          │  │
│  │  - Returns: category, confidence,         │  │
│  │    extracted_data                         │  │
│  └───────────────────────────────────────────┘  │
│                                                  │
│  ┌───────────────────────────────────────────┐  │
│  │  generate_embedding()                     │  │
│  │  - text-embedding-3-small                 │  │
│  │  - Returns: vector[1536]                  │  │
│  └───────────────────────────────────────────┘  │
│                                                  │
│  ┌───────────────────────────────────────────┐  │
│  │  generate_tags()                          │  │
│  │  - GPT-4o-mini                            │  │
│  │  - Returns: list[str]                     │  │
│  └───────────────────────────────────────────┘  │
│                                                  │
│  ┌───────────────────────────────────────────┐  │
│  │  extract_entities()                       │  │
│  │  - Category-specific extraction           │  │
│  │  - Returns: dict with metadata            │  │
│  └───────────────────────────────────────────┘  │
└─────────────────────────────────────────────────┘
```

### Classification Prompt Strategy

```python
SYSTEM_PROMPT = """
Ты — AI-ассистент для приложения Personal Memory.
Классифицируй контент в одну из категорий:
- movies (фильмы, сериалы)
- books (книги, статьи)
- places (места, рестораны)
- ideas (идеи, инсайты)
- recipes (рецепты)
- products (товары)

Верни JSON:
{
  "category": "название",
  "confidence": 0.95,
  "reasoning": "объяснение",
  "extracted_data": {...}
}
"""

USER_PROMPT = f"Контент: {memory.content}"
```

### Embedding Strategy

1. **Комбинированный текст:** `title + "\n\n" + content`
2. **Модель:** text-embedding-3-small (512 dims → 1536 dims)
3. **Хранение:** PostgreSQL с pgvector расширением
4. **Индекс:** ivfflat для быстрого cosine similarity

### Semantic Search Flow

```
Query: "фильмы про космос"
   ↓
Generate embedding[1536]
   ↓
SELECT * FROM memories m
JOIN embeddings e ON m.id = e.memory_id
ORDER BY e.embedding <=> query_vector
LIMIT 10
   ↓
Results: [Interstellar, Gravity, Martian, ...]
```

---

## 💾 Database Schema

### ERD Diagram

```
┌─────────────────┐
│     users       │
├─────────────────┤
│ id (UUID) PK    │
│ email           │
│ username        │
│ hashed_password │
│ created_at      │
│ updated_at      │
└────────┬────────┘
         │
         │ 1:N
         │
┌────────▼────────────────┐
│      memories           │
├─────────────────────────┤
│ id (UUID) PK            │
│ user_id (UUID) FK       │────┐
│ category_id (UUID) FK   │    │
│ title                   │    │
│ content                 │    │
│ source_type (ENUM)      │    │
│ source_url              │    │
│ metadata (JSONB)        │    │
│ ai_confidence (FLOAT)   │    │
│ tags (ARRAY)            │    │
│ created_at              │    │
│ updated_at              │    │
└─────────┬───────────────┘    │
          │                     │
          │ 1:1                 │ N:1
          │                     │
┌─────────▼───────────┐   ┌────▼───────────┐
│   embeddings        │   │   categories   │
├─────────────────────┤   ├────────────────┤
│ id (UUID) PK        │   │ id (UUID) PK   │
│ memory_id (UUID) FK │   │ name           │
│ embedding (VECTOR)  │   │ display_name   │
│ model               │   │ icon           │
│ created_at          │   │ color          │
└─────────────────────┘   │ created_at     │
                          └────────────────┘
```

### Indexes

```sql
-- Performance indexes
CREATE INDEX idx_memories_user_id ON memories(user_id);
CREATE INDEX idx_memories_category_id ON memories(category_id);
CREATE INDEX idx_memories_created_at ON memories(created_at DESC);
CREATE INDEX idx_embeddings_memory_id ON embeddings(memory_id);

-- Vector search index (IVFFlat)
CREATE INDEX idx_embeddings_vector ON embeddings 
  USING ivfflat (embedding vector_cosine_ops) 
  WITH (lists = 100);
```

---

## 🔐 Security Architecture

### Authentication Flow

```
1. User Registration/Login
   ↓
2. Server generates:
   - access_token (JWT, 30 min lifetime)
   - refresh_token (JWT, 7 days lifetime)
   ↓
3. Client stores tokens (SharedPreferences/SecureStorage)
   ↓
4. API requests include: Authorization: Bearer {access_token}
   ↓
5. Token expires?
   → Client sends refresh_token to /api/v1/auth/refresh
   → Server returns new access_token + refresh_token
   ↓
6. Refresh token expired?
   → User must re-login
```

### JWT Structure

```json
{
  "sub": "user_id",
  "exp": 1234567890,
  "type": "access"  // or "refresh"
}
```

### Password Security

- **Hashing:** bcrypt (via passlib)
- **Salt:** автоматический (встроен в bcrypt)
- **Rounds:** 12 (по умолчанию)

---

## 🚀 Deployment Architecture

### Development (Docker Compose)

```
┌────────────────────────────────────────────┐
│           Docker Host                       │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐ │
│  │PostgreSQL│  │  Redis   │  │ Backend  │ │
│  │  :5432   │  │  :6379   │  │  :8000   │ │
│  └──────────┘  └──────────┘  └──────────┘ │
│                                             │
│  ┌──────────┐  ┌──────────┐                │
│  │  Celery  │  │  Flower  │                │
│  │  Worker  │  │  :5555   │                │
│  └──────────┘  └──────────┘                │
└────────────────────────────────────────────┘
         ↑
         │ HTTP
    ┌────┴─────┐
    │  Flutter │
    │   App    │
    └──────────┘
```

### Production (рекомендуемая)

```
┌─────────────────────────────────────────────────┐
│              Cloud Provider (AWS/GCP/DO)        │
│                                                  │
│  ┌───────────────────────────────────────────┐  │
│  │  Load Balancer (HTTPS)                    │  │
│  └─────────────┬─────────────────────────────┘  │
│                │                                 │
│  ┌─────────────▼─────────────────────────────┐  │
│  │  Backend (ECS/GKE/Kubernetes)             │  │
│  │  - FastAPI containers (N replicas)        │  │
│  │  - Auto-scaling                           │  │
│  └───────────────────────────────────────────┘  │
│                                                  │
│  ┌───────────────────────────────────────────┐  │
│  │  Celery Workers                           │  │
│  │  - Separate worker containers             │  │
│  │  - Queue-based scaling                    │  │
│  └───────────────────────────────────────────┘  │
│                                                  │
│  ┌───────────────────────────────────────────┐  │
│  │  Managed Services                         │  │
│  │  - RDS PostgreSQL (+pgvector)             │  │
│  │  - ElastiCache Redis                      │  │
│  │  - S3 for file storage                    │  │
│  └───────────────────────────────────────────┘  │
└─────────────────────────────────────────────────┘
           ↑
           │ HTTPS
      ┌────┴─────┐
      │  Mobile  │
      │   Apps   │
      └──────────┘
```

---

## 📊 Performance Considerations

### Backend Optimization

1. **Database Connection Pooling**
   - AsyncPG connection pool
   - Max 20 connections per worker

2. **Caching Strategy**
   - Redis для кеширования категорий
   - TTL: 1 час
   - Invalidation при обновлении

3. **Async Processing**
   - All I/O operations async (FastAPI + asyncpg)
   - Non-blocking AI processing (Celery)

4. **Database Indexes**
   - Composite indexes для частых queries
   - Vector index (ivfflat) для embeddings

### Frontend Optimization

1. **State Management**
   - BLoC для centralized state
   - Immutable states для predictable updates

2. **Local Caching**
   - Hive для offline storage
   - Cache-first strategy

3. **Lazy Loading**
   - Pagination для списков
   - Infinite scroll

4. **Image Optimization**
   - CachedNetworkImage для автокеша
   - Thumbnail generation на сервере

---

## 🔄 Scalability Plan

### Horizontal Scaling

**Backend:**
- Stateless FastAPI → N replicas за Load Balancer
- Celery workers → Auto-scale по queue size

**Database:**
- Read replicas для read-heavy queries
- Connection pooling (PgBouncer)

**Caching:**
- Redis Cluster для distributed cache

### Vertical Scaling

**Database:**
- Увеличить RAM для PostgreSQL
- SSD storage для faster I/O

**Backend:**
- Больше CPU для Celery workers (AI tasks)

---

## 🎯 Key Design Decisions

### 1. Почему Clean Architecture во Flutter?
- ✅ Разделение бизнес-логики от UI
- ✅ Легкое тестирование (mocking layers)
- ✅ Масштабируемость при добавлении features
- ✅ Независимость от фреймворков

### 2. Почему FastAPI?
- ✅ Async by default → высокая производительность
- ✅ Автогенерация OpenAPI docs
- ✅ Pydantic validation из коробки
- ✅ Хорошая экосистема для Python AI

### 3. Почему PostgreSQL + pgvector?
- ✅ Проверенная БД с ACID гарантиями
- ✅ pgvector → native vector search без отдельного сервиса
- ✅ JSONB для flexible metadata
- ✅ Отличная производительность с правильными индексами

### 4. Почему Celery?
- ✅ AI-запросы медленные (1-3 sec)
- ✅ Non-blocking UX для пользователя
- ✅ Retry logic из коробки
- ✅ Мониторинг через Flower

### 5. Почему BLoC pattern?
- ✅ Predictable state management
- ✅ Separation of concerns
- ✅ Easy testing
- ✅ Recommended by Flutter team

---

## 📈 Мониторинг и метрики

### Backend Metrics

- **Request latency:** P50, P95, P99
- **Error rate:** 4xx, 5xx
- **Celery queue size**
- **Database connections**
- **OpenAI API usage & cost**

### Frontend Metrics

- **Crash-free rate**
- **Screen load time**
- **API response time from client**
- **User retention (D1, D7, D30)**

---

## 🛣️ Roadmap

### Phase 1: MVP (текущая) ✅
- Backend API
- AI классификация
- Базовая Flutter структура

### Phase 2: UI Completion ⏳
- Полноценные Auth screens
- Home page с memories
- Create/Edit flows
- Search UI

### Phase 3: Advanced Features ⏳
- Image upload + OCR
- Voice notes + transcription
- Share sheet integration
- Push notifications

### Phase 4: Optimization ⏳
- Offline-first
- Advanced caching
- Performance tuning
- Comprehensive testing

### Phase 5: Production ⏳
- CI/CD pipeline
- Production deployment
- Monitoring & alerting
- User analytics

---

## 📚 Полезные ресурсы

- [Clean Architecture by Uncle Bob](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [BLoC Pattern Documentation](https://bloclibrary.dev/)
- [FastAPI Best Practices](https://github.com/zhanymkanov/fastapi-best-practices)
- [pgvector Performance Tuning](https://github.com/pgvector/pgvector#performance)
- [OpenAI Best Practices](https://platform.openai.com/docs/guides/production-best-practices)

