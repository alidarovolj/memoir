# 🚀 Memoir Backend Deployment Guide

Пошаговая инструкция по деплою на VPS.

## 📋 Информация о сервере

- **IP**: 194.32.141.227
- **OS**: Ubuntu 22.04 LTS
- **Resources**: 4 CPU, 4 GB RAM, 80 GB SSD
- **User**: ubuntu
- **Password**: ClmkWS2Ghiq3GF91r+MocmE=

---

## 🔧 Шаг 1: Подключение к серверу

Открой терминал на своем Mac и подключись:

```bash
ssh ubuntu@194.32.141.227
# Введи пароль: ClmkWS2Ghiq3GF91r+MocmE=
```

После первого входа сменим пароль на более удобный:

```bash
passwd
# Введи старый пароль, затем новый (дважды)
```

---

## 🐳 Шаг 2: Установка Docker и Docker Compose

```bash
# Обновим систему
sudo apt update && sudo apt upgrade -y

# Установим Docker
curl -fsSL https://get.docker.com | sh

# Добавим пользователя в группу docker
sudo usermod -aG docker ubuntu

# Установим Docker Compose
sudo apt install docker-compose-plugin -y

# Установим Git
sudo apt install git -y

# Перелогинимся для применения группы docker
exit
```

Подключись снова:
```bash
ssh ubuntu@194.32.141.227
```

Проверь установку:
```bash
docker --version
docker compose version
git --version
```

---

## 📦 Шаг 3: Клонирование репозитория

```bash
# Создадим директорию для проектов
mkdir -p ~/projects
cd ~/projects

# Клонируем backend (через HTTPS для простоты)
git clone https://github.com/alidarovolj/memoir-python.git
cd memoir-python
```

---

## 🔐 Шаг 4: Настройка переменных окружения

Создай файл `.env`:

```bash
nano .env
```

Вставь следующее содержимое (ОБЯЗАТЕЛЬНО замени API ключи):

```env
# App
APP_NAME=Memoir
DEBUG=False
SECRET_KEY=memoir_super_secret_key_production_2024
HOST=0.0.0.0
PORT=8000

# Database
DATABASE_URL=postgresql+asyncpg://memoir_user:memoir_pass_prod_2024@postgres:5432/memoir

# Redis
REDIS_URL=redis://redis:6379/0

# JWT (30 days)
JWT_SECRET_KEY=memoir_jwt_secret_key_production_2024
JWT_ALGORITHM=HS256
ACCESS_TOKEN_EXPIRE_MINUTES=43200
REFRESH_TOKEN_EXPIRE_DAYS=90

# OpenAI
OPENAI_API_KEY=sk-YOUR_OPENAI_KEY_HERE
OPENAI_MODEL_CLASSIFICATION=gpt-4o-mini
OPENAI_MODEL_EMBEDDING=text-embedding-3-small

# External APIs
TMDB_API_KEY=YOUR_TMDB_KEY_HERE
GOOGLE_BOOKS_KEY=YOUR_GOOGLE_BOOKS_KEY_HERE
GOOGLE_SEARCH_KEY=YOUR_GOOGLE_SEARCH_KEY_HERE
GOOGLE_SEARCH_CX=YOUR_GOOGLE_SEARCH_CX_HERE
SPOONACULAR_KEY=YOUR_SPOONACULAR_KEY_HERE

# Celery
CELERY_BROKER_URL=redis://redis:6379/0
CELERY_RESULT_BACKEND=redis://redis:6379/0

# CORS (добавь свой домен)
CORS_ORIGINS=["http://localhost:8000","https://memoir-ai.net","https://api.memoir-ai.net"]
```

**Важно**: Замени ВСЕ ключи API на реальные!

Сохрани файл:
- Нажми `Ctrl + O` (сохранить)
- Нажми `Enter`
- Нажми `Ctrl + X` (выход)

---

## 🚀 Шаг 5: Запуск сервисов

```bash
# Запустим все сервисы в фоновом режиме
docker compose up -d

# Проверим статус
docker compose ps
```

Ты должен увидеть запущенные контейнеры:
- postgres
- redis
- backend
- celery_worker

Проверь логи backend:
```bash
docker compose logs -f backend
# Нажми Ctrl+C чтобы выйти
```

---

## 🗄️ Шаг 6: Применение миграций

```bash
# Применим все миграции БД
docker compose exec backend alembic upgrade head
```

Должно появиться сообщение об успешном применении миграций.

---

## ✅ Шаг 7: Проверка работоспособности

```bash
# Проверим API
curl http://localhost:8000/docs

# Или с другого терминала на твоем Mac:
curl http://194.32.141.227:8000/docs
```

Должен вернуться HTML со Swagger документацией.

Также можешь открыть в браузере:
- **Swagger**: http://194.32.141.227:8000/docs
- **ReDoc**: http://194.32.141.227:8000/redoc

---

## 🔒 Шаг 8: Настройка Firewall (безопасность)

```bash
# Установим UFW
sudo apt install ufw -y

# Разрешим SSH, HTTP, HTTPS
sudo ufw allow 22/tcp
sudo ufw allow 8000/tcp
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp

# Включим firewall
sudo ufw --force enable

# Проверим статус
sudo ufw status
```

---

## 🌐 Шаг 9: Настройка Nginx (опционально, для красивого URL)

Если хочешь использовать домен вместо IP:

```bash
# Установим Nginx
sudo apt install nginx -y

# Создадим конфигурацию
sudo nano /etc/nginx/sites-available/memoir
```

Вставь:
```nginx
server {
    listen 80;
    server_name api.memoir-ai.net 194.32.141.227;

    location / {
        proxy_pass http://localhost:8000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```

Активируем:
```bash
sudo ln -s /etc/nginx/sites-available/memoir /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl restart nginx
```

---

## 📱 Шаг 10: Обновление Flutter приложения

На твоем Mac измени API URL в Flutter:

```dart
// lib/core/config/api_config.dart
class ApiConfig {
  static const String baseUrl = 'http://194.32.141.227:8000'; // или твой домен
  // ...
}
```

---

## 🔄 Полезные команды

### Просмотр логов:
```bash
docker compose logs -f backend      # Backend логи
docker compose logs -f celery       # Celery логи
docker compose logs -f postgres     # PostgreSQL логи
```

### Перезапуск сервисов:
```bash
docker compose restart backend
docker compose restart celery
```

### Остановка всех сервисов:
```bash
docker compose down
```

### Запуск после остановки:
```bash
docker compose up -d
```

### Обновление кода с GitHub:
```bash
cd ~/projects/memoir-python
git pull origin main
docker compose down
docker compose up -d --build
docker compose exec backend alembic upgrade head
```

### Просмотр использования ресурсов:
```bash
docker stats
```

---

## 🐛 Решение проблем

### Если backend не запускается:
```bash
docker compose logs backend
```

### Если PostgreSQL не работает:
```bash
docker compose logs postgres
```

### Если порт занят:
```bash
sudo lsof -i :8000
sudo kill -9 <PID>
```

### Пересоздать все контейнеры:
```bash
docker compose down -v
docker compose up -d
docker compose exec backend alembic upgrade head
```

---

## ✅ Проверка всего стека

Создай тестовый скрипт:

```bash
nano test_api.sh
```

Вставь:
```bash
#!/bin/bash

echo "1. Testing API health..."
curl http://localhost:8000/docs | head -n 5

echo -e "\n\n2. Testing registration..."
curl -X POST http://localhost:8000/api/v1/auth/register \
  -H "Content-Type: application/json" \
  -d '{"email":"test@test.com","password":"test123"}'

echo -e "\n\n3. Testing login..."
curl -X POST http://localhost:8000/api/v1/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email":"test@test.com","password":"test123"}'
```

Запусти:
```bash
chmod +x test_api.sh
./test_api.sh
```

---

## 🎯 Итоговый чеклист

- [ ] Docker установлен
- [ ] Репозиторий склонирован
- [ ] `.env` настроен с реальными API ключами
- [ ] `docker compose up -d` выполнен
- [ ] Миграции применены
- [ ] API доступен по http://194.32.141.227:8000/docs
- [ ] Firewall настроен
- [ ] Flutter приложение обновлено с новым API URL

---

## 📞 В случае проблем

1. Проверь логи: `docker compose logs -f`
2. Проверь статус: `docker compose ps`
3. Проверь `.env` файл на ошибки
4. Убедись что все API ключи правильные

---

**Backend готов к работе! 🚀**

API теперь доступен по адресу: **http://194.32.141.227:8000**

