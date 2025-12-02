# 🚀 Getting Started - Memoir Personal Memory AI

Пошаговая инструкция для запуска проекта.

---

## 📋 Предварительные требования

### Backend
- Docker Desktop установлен и запущен
- Python 3.11+ (опционально, для локальной разработки)
- OpenAI API ключ ([получить здесь](https://platform.openai.com/api-keys))

### Frontend
- Flutter SDK 3.9.2 или выше
- Android Studio / VS Code с Flutter плагинами
- iOS симулятор (для macOS) или Android эмулятор

---

## ⚙️ Установка

### Шаг 1: Клонирование репозитория

```bash
cd /Users/user/Documents/Projects/memoir
```

### Шаг 2: Настройка Backend

```bash
cd backend

# Создайте .env файл
cp .env.example .env

# Откройте .env и добавьте свой OpenAI API ключ
nano .env
```

В `.env` файле измените:
```bash
OPENAI_API_KEY=sk-ваш-реальный-ключ-здесь
```

### Шаг 3: Запуск Backend с Docker

```bash
# Убедитесь, что Docker Desktop запущен

# Запустите все сервисы
docker-compose up -d

# Проверьте, что все контейнеры запущены
docker-compose ps

# Должны быть запущены:
# - postgres (порт 5432)
# - redis (порт 6379)
# - backend (порт 8000)
# - celery_worker
# - flower (порт 5555)
```

### Шаг 4: Применение миграций БД

```bash
# Создайте таблицы и заполните категории
docker-compose exec backend alembic upgrade head

# Если возникла ошибка, проверьте логи:
docker-compose logs backend
```

### Шаг 5: Проверка Backend

Откройте в браузере:
- **API Docs**: http://localhost:8000/docs
- **Health Check**: http://localhost:8000/health
- **Flower (Celery)**: http://localhost:5555

Вы должны увидеть Swagger UI с документацией API.

### Шаг 6: Тестирование API

Попробуйте зарегистрироваться:

```bash
curl -X POST http://localhost:8000/api/v1/auth/register \
  -H "Content-Type: application/json" \
  -d '{
    "email": "test@example.com",
    "username": "testuser",
    "password": "password123"
  }'
```

Затем войдите:

```bash
curl -X POST http://localhost:8000/api/v1/auth/login \
  -H "Content-Type: application/json" \
  -d '{
    "email": "test@example.com",
    "password": "password123"
  }'
```

Вы получите `access_token` и `refresh_token`.

### Шаг 7: Настройка Flutter

```bash
# Вернитесь в корень проекта
cd ..

# Установите зависимости Flutter
flutter pub get

# Проверьте, что Flutter настроен корректно
flutter doctor
```

### Шаг 8: Генерация кода для Flutter

```bash
# Сгенерируйте JSON serialization код
flutter pub run build_runner build --delete-conflicting-outputs

# Если появляются ошибки, это нормально на данном этапе
# так как не все классы полностью реализованы
```

### Шаг 9: Запуск Flutter приложения

```bash
# Запустите приложение (выберите устройство/эмулятор)
flutter run

# Или запустите в конкретном режиме:
flutter run -d chrome     # Веб-версия
flutter run -d macos      # macOS desktop
flutter run -d <device>   # Конкретное устройство
```

Вы увидите SplashScreen с надписью "Memoir - Personal Memory AI".

---

## 🧪 Тестирование полного потока

### 1. Создание пользователя и воспоминания

Используйте Swagger UI (http://localhost:8000/docs):

1. Перейдите в раздел **auth**
2. Выполните `POST /api/v1/auth/register` с данными нового пользователя
3. Выполните `POST /api/v1/auth/login` для получения токена
4. Нажмите кнопку **Authorize** вверху, введите токен в формате: `Bearer ваш_токен`
5. Перейдите в раздел **memories**
6. Выполните `POST /api/v1/memories`:

```json
{
  "title": "Хочу посмотреть Интерстеллар",
  "content": "Фильм Кристофера Нолана про космос и путешествия во времени. Слышал очень хорошие отзывы!",
  "source_type": "text"
}
```

### 2. Проверка AI-классификации

AI обработка происходит в фоне через Celery:

```bash
# Проверьте логи Celery worker
docker-compose logs -f celery_worker

# Вы должны увидеть:
# - classify_memory_async: классификация контента
# - generate_embedding_async: создание embedding
```

Через 5-10 секунд выполните `GET /api/v1/memories/{id}` — вы увидите:
- `category_id` будет заполнен (скорее всего "movies")
- `ai_confidence` ≈ 0.9+
- `tags` будут сгенерированы
- `metadata` будет содержать извлечённые данные

### 3. Тестирование поиска

**Текстовый поиск:**
```
GET /api/v1/search?q=Нолан
```

**Семантический поиск:**
```
POST /api/v1/search/semantic?q=фильмы про космос
```

Семантический поиск вернёт "Интерстеллар", даже если слово "космос" не было в заголовке!

---

## 📊 Мониторинг

### Проверка состояния сервисов

```bash
# Проверка всех контейнеров
docker-compose ps

# Логи backend
docker-compose logs -f backend

# Логи Celery worker
docker-compose logs -f celery_worker

# Логи PostgreSQL
docker-compose logs -f postgres

# Логи Redis
docker-compose logs -f redis
```

### Celery Flower Dashboard

Откройте http://localhost:5555 для мониторинга фоновых задач:
- Видны все запущенные задачи
- Статистика выполнения
- Ошибки и трейсы

### База данных

Подключение к PostgreSQL:

```bash
docker-compose exec postgres psql -U memoir_user -d memoir

# Проверка таблиц
\dt

# Проверка категорий
SELECT * FROM categories;

# Проверка воспоминаний
SELECT id, title, category_id, ai_confidence FROM memories;

# Проверка embeddings
SELECT COUNT(*) FROM embeddings;
```

---

## 🛠️ Разработка

### Backend: Локальная разработка

Если хотите разрабатывать backend без Docker:

```bash
cd backend

# Создайте виртуальное окружение
python -m venv venv
source venv/bin/activate  # macOS/Linux
# или
venv\Scripts\activate  # Windows

# Установите зависимости
pip install -r requirements.txt

# Запустите PostgreSQL и Redis в Docker
docker-compose up -d postgres redis

# Измените DATABASE_URL в .env на localhost:
# DATABASE_URL=postgresql+asyncpg://memoir_user:memoir_pass@localhost:5432/memoir
# DATABASE_URL_SYNC=postgresql://memoir_user:memoir_pass@localhost:5432/memoir

# Примените миграции
alembic upgrade head

# Запустите backend
uvicorn app.main:app --reload --host 0.0.0.0 --port 8000

# В другом терминале запустите Celery worker
celery -A app.tasks.celery_app worker --loglevel=info
```

### Flutter: Hot Reload

После запуска `flutter run`, вы можете редактировать код и нажимать:
- `r` - hot reload (быстрое обновление UI)
- `R` - hot restart (полный перезапуск приложения)
- `q` - выход

### Генерация кода

При изменении моделей с `@JsonSerializable()` нужно перегенерировать код:

```bash
# Одноразовая генерация
flutter pub run build_runner build --delete-conflicting-outputs

# Автоматическая генерация при изменениях
flutter pub run build_runner watch
```

---

## 🐛 Решение проблем

### Backend не запускается

```bash
# Проверьте логи
docker-compose logs backend

# Распространённые ошибки:
# - "connection refused" → PostgreSQL не запустился
# - "permission denied" → проблемы с Docker volumes
# - "module not found" → пересоберите образ: docker-compose build backend
```

### Миграции не применяются

```bash
# Пересоздайте базу данных
docker-compose down -v
docker-compose up -d
docker-compose exec backend alembic upgrade head
```

### OpenAI API ошибки

```bash
# Проверьте, что ключ правильный
docker-compose exec backend env | grep OPENAI_API_KEY

# Проверьте баланс: https://platform.openai.com/usage
# Проверьте лимиты: https://platform.openai.com/account/limits
```

### Flutter build_runner ошибки

```bash
# Очистите кеш и перегенерируйте
flutter clean
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
```

### Celery задачи не выполняются

```bash
# Проверьте Celery worker
docker-compose logs celery_worker

# Перезапустите worker
docker-compose restart celery_worker

# Проверьте Redis
docker-compose exec redis redis-cli ping
# Должен ответить: PONG
```

---

## 📝 Следующие шаги

После успешного запуска, вы можете:

1. **Изучить код:**
   - Backend: `backend/app/`
   - Flutter: `lib/`
   - Архитектуру: смотрите `README.md`

2. **Доработать Flutter UI:**
   - Реализовать Auth screens
   - Создать Home page с grid воспоминаний
   - Добавить Create Memory форму
   - Реализовать Search screen

3. **Добавить функционал:**
   - Image upload для воспоминаний
   - Voice notes
   - Share sheet integration
   - Push notifications

4. **Оптимизировать:**
   - Добавить кеширование в Flutter (Hive)
   - Реализовать offline-first
   - Добавить pagination для больших списков

5. **Тестировать:**
   - Написать unit тесты
   - Добавить integration тесты
   - Провести E2E тестирование

---

## 💡 Полезные команды

### Docker

```bash
# Остановить все сервисы
docker-compose down

# Остановить и удалить volumes (ВНИМАНИЕ: удалит БД!)
docker-compose down -v

# Пересобрать образы
docker-compose build

# Просмотр логов в реальном времени
docker-compose logs -f

# Выполнить команду в контейнере
docker-compose exec backend bash
```

### Alembic (миграции)

```bash
# Создать новую миграцию
docker-compose exec backend alembic revision --autogenerate -m "Description"

# Применить миграции
docker-compose exec backend alembic upgrade head

# Откатить последнюю миграцию
docker-compose exec backend alembic downgrade -1

# Проверить текущую версию
docker-compose exec backend alembic current
```

### Flutter

```bash
# Проверить устройства
flutter devices

# Очистить build
flutter clean

# Проанализировать код
flutter analyze

# Запустить тесты
flutter test

# Собрать релиз APK (Android)
flutter build apk

# Собрать iOS app (macOS only)
flutter build ios
```

---

## 🎉 Готово!

Теперь у вас запущен полноценный AI-powered backend с автоматической классификацией контента и семантическим поиском!

Для вопросов и предложений смотрите `README.md` и документацию API на http://localhost:8000/docs.

Удачи в разработке! 🚀

