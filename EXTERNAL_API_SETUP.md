# 🔑 External API Setup Guide

Для работы Smart Content Search нужно настроить API ключи внешних сервисов.

---

## 🎬 1. TMDB (The Movie Database) - Фильмы и сериалы

### ✅ Бесплатно: 500,000 запросов/день

### Как получить API ключ:

1. Зарегистрируйтесь на https://www.themoviedb.org/signup
2. Подтвердите email
3. Перейдите в настройки: https://www.themoviedb.org/settings/api
4. Нажмите "Create" и заполните форму:
   - **Application Name:** Memoir App
   - **Application URL:** http://localhost:3000 (для разработки)
   - **Application Summary:** Personal memory management app
5. Примите условия использования
6. Скопируйте **API Key (v3 auth)**

### Добавьте в `.env`:
```bash
TMDB_API_KEY=your-tmdb-api-key-here
```

**Документация:** https://developers.themoviedb.org/3/getting-started/introduction

---

## 📚 2. Google Books API - Книги

### ✅ Бесплатно: unlimited (с rate limiting)

### Как получить API ключ:

1. Перейдите в Google Cloud Console: https://console.cloud.google.com/
2. Создайте новый проект или выберите существующий
3. Перейдите в **APIs & Services → Library**
4. Найдите и включите **Books API**
5. Перейдите в **APIs & Services → Credentials**
6. Нажмите **Create Credentials → API Key**
7. Скопируйте ключ

### Добавьте в `.env`:
```bash
GOOGLE_BOOKS_KEY=your-google-books-api-key
```

**Документация:** https://developers.google.com/books/docs/v1/getting_started

---

## 🔍 3. Google Custom Search API - Универсальный поиск

### ✅ Бесплатно: 100 запросов/день
### 💵 Платно: $5 за 1000 запросов (после 100 бесплатных)

### Как настроить:

#### Шаг 1: Получить API Key

1. В Google Cloud Console (тот же проект, что и Books API)
2. **APIs & Services → Library**
3. Найдите и включите **Custom Search API**
4. **APIs & Services → Credentials**
5. Используйте тот же API Key или создайте новый

#### Шаг 2: Создать Custom Search Engine

1. Перейдите на https://programmablesearchengine.google.com/
2. Нажмите **Create a custom search engine** или **Get Started**
3. Заполните форму:
   - **Sites to search:** `www.google.com/*` (для поиска по всему интернету)
   - **Name:** Memoir Universal Search
4. Нажмите **Create**
5. Перейдите в **Setup → Basic**
6. Включите опцию **Search the entire web**
7. Скопируйте **Search engine ID** (cx)

### Добавьте в `.env`:
```bash
GOOGLE_SEARCH_KEY=your-google-api-key
GOOGLE_SEARCH_CX=your-custom-search-engine-id
```

**Документация:** https://developers.google.com/custom-search/v1/overview

---

## 🍳 4. Spoonacular API - Рецепты (опционально)

### ✅ Бесплатно: 150 запросов/день
### 💵 Платно: от $0.002 за запрос

### Как получить API ключ:

1. Зарегистрируйтесь на https://spoonacular.com/food-api/console#Dashboard
2. Подтвердите email
3. API ключ будет показан на дашборде
4. Скопируйте его

### Добавьте в `.env`:
```bash
SPOONACULAR_KEY=your-spoonacular-api-key
```

**Документация:** https://spoonacular.com/food-api/docs

---

## 📦 Итоговый `.env` файл

Создайте или обновите `/backend/.env`:

```bash
# App
APP_NAME=Memoir
DEBUG=True
SECRET_KEY=your-secret-key-here

# Database
DATABASE_URL=postgresql+asyncpg://memoir_user:memoir_pass@postgres:5432/memoir
DATABASE_URL_SYNC=postgresql://memoir_user:memoir_pass@postgres:5432/memoir

# Redis
REDIS_URL=redis://redis:6379/0

# OpenAI
OPENAI_API_KEY=sk-your-openai-key
OPENAI_MODEL_CLASSIFICATION=gpt-4o-mini
OPENAI_MODEL_EMBEDDING=text-embedding-3-small

# Auth
JWT_SECRET_KEY=your-jwt-secret
JWT_ALGORITHM=HS256
ACCESS_TOKEN_EXPIRE_MINUTES=30
REFRESH_TOKEN_EXPIRE_DAYS=7

# Celery
CELERY_BROKER_URL=redis://redis:6379/0
CELERY_RESULT_BACKEND=redis://redis:6379/0

# CORS
CORS_ORIGINS=["http://localhost:3000","http://localhost:8080"]

# External APIs for Smart Content Search
TMDB_API_KEY=your-tmdb-api-key-here
GOOGLE_BOOKS_KEY=your-google-books-api-key
GOOGLE_SEARCH_KEY=your-google-search-api-key
GOOGLE_SEARCH_CX=your-custom-search-engine-id
SPOONACULAR_KEY=your-spoonacular-api-key-here
```

---

## ✅ Проверка настройки

После добавления ключей:

1. Перезапустите Docker контейнеры:
```bash
cd backend
docker compose restart backend celery_worker
```

2. Проверьте Swagger UI:
```
http://localhost:8000/docs
```

3. Протестируйте `/api/v1/smart-search/smart-search` endpoint:
```bash
curl -X POST "http://localhost:8000/api/v1/smart-search/smart-search?query=Интерстеллар" \
  -H "Authorization: Bearer YOUR_JWT_TOKEN"
```

---

## 💡 Что можно оставить пустым для начала:

- `SPOONACULAR_KEY` - пока не реализованы рецепты
- `GOOGLE_BOOKS_KEY` - если не будете искать книги
- `GOOGLE_SEARCH_KEY` и `GOOGLE_SEARCH_CX` - если хотите только TMDB

**Минимум для MVP:**
```bash
TMDB_API_KEY=your-key  # Для фильмов
GOOGLE_SEARCH_KEY=your-key  # Для универсального поиска (товары, места)
GOOGLE_SEARCH_CX=your-cx  # ID поисковой системы
```

---

## 🚨 Важно:

1. **НЕ коммитьте `.env` в Git!** Он уже в `.gitignore`
2. Для продакшн используйте переменные окружения в Heroku/AWS/DigitalOcean
3. API ключи храните в секретах (GitHub Secrets, AWS Secrets Manager, etc)

---

**Готово!** 🎉 Теперь ваш Memoir может искать контент во всем интернете!

