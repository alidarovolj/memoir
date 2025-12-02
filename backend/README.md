# Memoir Backend

Backend API для приложения Personal Memory AI.

## Технологический стек

- **FastAPI** - современный async веб-фреймворк
- **PostgreSQL** - основная база данных с расширением pgvector
- **Redis** - кеширование и очереди задач
- **Celery** - фоновые задачи для AI-обработки
- **OpenAI API** - классификация и embeddings

## Установка и запуск

### С помощью Docker (рекомендуется)

1. Скопируйте `.env.example` в `.env` и заполните необходимые переменные:
```bash
cp .env.example .env
```

2. Добавьте ваш OpenAI API ключ в `.env`:
```
OPENAI_API_KEY=sk-your-key-here
```

3. Запустите все сервисы:
```bash
docker-compose up -d
```

4. Примените миграции базы данных:
```bash
docker-compose exec backend alembic upgrade head
```

5. API будет доступен по адресу: http://localhost:8000

### Локальная разработка (без Docker)

1. Создайте виртуальное окружение:
```bash
python -m venv venv
source venv/bin/activate  # Linux/Mac
# или
venv\Scripts\activate  # Windows
```

2. Установите зависимости:
```bash
pip install -r requirements.txt
```

3. Запустите PostgreSQL и Redis локально

4. Примените миграции:
```bash
alembic upgrade head
```

5. Запустите сервер:
```bash
uvicorn app.main:app --reload
```

## API Документация

После запуска сервера документация доступна по адресам:
- Swagger UI: http://localhost:8000/docs
- ReDoc: http://localhost:8000/redoc

## Структура проекта

```
backend/
├── app/
│   ├── api/           # API endpoints
│   ├── core/          # Настройки, безопасность
│   ├── db/            # База данных
│   ├── models/        # SQLAlchemy модели
│   ├── schemas/       # Pydantic схемы
│   ├── services/      # Бизнес-логика
│   ├── tasks/         # Celery задачи
│   └── utils/         # Утилиты
├── alembic/           # Миграции БД
├── tests/             # Тесты
└── docker-compose.yml
```

## Миграции базы данных

Создать новую миграцию:
```bash
alembic revision --autogenerate -m "Description"
```

Применить миграции:
```bash
alembic upgrade head
```

Откатить последнюю миграцию:
```bash
alembic downgrade -1
```

## Celery Workers

Запуск Celery worker:
```bash
celery -A app.tasks.celery_app worker --loglevel=info
```

Мониторинг с помощью Flower:
```bash
celery -A app.tasks.celery_app flower
```
Flower UI будет доступен по адресу: http://localhost:5555

## Тестирование

Запуск тестов:
```bash
pytest
```

С coverage:
```bash
pytest --cov=app tests/
```

