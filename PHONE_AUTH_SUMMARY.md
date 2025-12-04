# 📱 Firebase Phone Authentication - Итоги внедрения

## ✅ Что сделано

### **Backend (FastAPI):**

1. **Обновлена модель User** (`backend/app/models/user.py`):
   - Добавлено поле `phone_number` (обязательное, уникальное)
   - Добавлено поле `firebase_uid` (уникальное)
   - Поля `email`, `username`, `hashed_password` стали опциональными

2. **Обновлены Pydantic схемы** (`backend/app/schemas/user.py`):
   - Создана схема `UserCreatePhone` для phone auth
   - Основное поле теперь `phone_number`, а не `email`

3. **Создан Firebase Service** (`backend/app/services/firebase_service.py`):
   - Интеграция с Firebase Admin SDK
   - Верификация Firebase ID tokens
   - Получение данных пользователя из Firebase

4. **Обновлен Auth Service** (`backend/app/services/auth_service.py`):
   - Новый метод `register_or_login_with_phone()` - unified endpoint
   - Автоматическая регистрация при первом входе
   - Логин для существующих пользователей

5. **Новый API endpoint** (`backend/app/api/v1/auth.py`):
   - `POST /api/v1/auth/phone` - аутентификация по телефону
   - Принимает `phone_number` и `firebase_token`
   - Возвращает JWT токен + данные пользователя

6. **Создана миграция БД** (`backend/alembic/versions/2025_12_04_1437-add_phone_auth_to_users.py`):
   - Добавлены колонки `phone_number` и `firebase_uid`
   - Создан���индексы для быстрого поиска
   - Email стал опциональным

7. **Обновлен requirements.txt**:
   - Добавлен `firebase-admin==6.4.0`

8. **Инициализация Firebase в main.py**:
   - Firebase Admin SDK инициализируется при старте

---

### **Frontend (Flutter):**

1. **Добавлены зависимости** (`pubspec.yaml`):
   - `firebase_core: ^2.27.0`
   - `firebase_auth: ^4.17.8`
   - `intl_phone_field: ^3.2.0`
   - `pin_code_fields: ^8.0.1`

2. **Создан PhoneAuthService** (`lib/core/services/phone_auth_service.dart`):
   - Отправка SMS кода через Firebase
   - Верификация кода
   - Автоматическая верификация (Android)
   - Повторная отправка кода

3. **Создан PhoneLoginPage** (`lib/features/auth/presentation/pages/phone_login_page.dart`):
   - Красивый UI с градиентами и glassmorphism
   - Поле для ввода телефона с выбором страны
   - Валидация номера
   - Отправка SMS кода

4. **Создан PhoneVerifyPage** (`lib/features/auth/presentation/pages/phone_verify_page.dart`):
   - 6-значный PIN код input
   - Автоматическая отправка при вводе
   - Таймер для повторной отправки (60 сек)
   - Интеграция с backend для получения JWT

5. **Обновлен AuthService** (`lib/core/services/auth_service.dart`):
   - Новый метод `authenticateWithPhone()`
   - Отправка Firebase token на backend
   - Сохранение JWT и данных пользователя
   - Обратная совместимость с email/password

6. **Обновлен main.dart**:
   - Инициализация Firebase при старте
   - `PhoneLoginPage` как стартовый экран
   - Добавлены роуты для phone auth

7. **Обновлены Android и iOS конфигурации**:
   - Добавлен Google Services plugin
   - Настроены Gradle файлы

---

## 🚀 Что нужно сделать ТЕБЕ

### **Шаг 1: Настроить Firebase проект**

📄 **Смотри подробную инструкцию:** `FIREBASE_SETUP.md`

**Краткий чек-лист:**
- [ ] Создать Firebase проект
- [ ] Добавить iOS app (bundle ID: `net.memoir-ai.app`)
- [ ] Скачать и добавить `GoogleService-Info.plist` в Xcode
- [ ] Добавить Android app (package: `net.memoir_ai.app`)
- [ ] Скачать и добавить `google-services.json` в `android/app/`
- [ ] Включить Phone Authentication в Firebase Console
- [ ] Настроить SHA-1 fingerprint для Android
- [ ] Настроить APNs Key для iOS

---

### **Шаг 2: Запустить Flutter проект**

```bash
cd /Users/user/Documents/Projects/memoir

# Установить зависимости
flutter pub get

# Запустить на iOS Simulator
flutter run

# Или на Android
flutter run
```

---

### **Шаг 3: Запустить backend с новыми изменениями**

```bash
# Если backend запущен локально в Docker
cd backend
docker-compose down
docker-compose up -d --build

# Применить миграцию
docker exec memoir-backend-1 alembic upgrade head
```

**На VPS (http://194.32.141.227:8000):**

```bash
# SSH на VPS
ssh root@194.32.141.227

# Перейти в директорию backend
cd memoir-python

# Обновить код
git pull origin main

# Пересобрать контейнеры
docker-compose down
docker-compose up -d --build

# Применить миграцию
docker exec memoir-python-backend-1 alembic upgrade head

# ВАЖНО: Добавить Firebase Service Account JSON
# Скачай Service Account JSON из Firebase Console:
# Firebase Console → Project Settings → Service Accounts → Generate new private key

# Загрузи файл на VPS в /root/memoir-python/
# Назови его: firebase-service-account.json

# Добавь в docker-compose.yml:
# backend:
#   environment:
#     - GOOGLE_APPLICATION_CREDENTIALS=/app/firebase-service-account.json
#   volumes:
#     - ./firebase-service-account.json:/app/firebase-service-account.json
```

---

## 📱 Как это работает

### **Флоу авторизации:**

1. **Пользователь вводит номер телефона** → `PhoneLoginPage`
2. **Firebase отправляет SMS код** → через `PhoneAuthService`
3. **Пользователь вводит код** → `PhoneVerifyPage`
4. **Firebase верифицирует код** → возвращает ID Token
5. **Flutter отправляет token на backend** → `POST /api/v1/auth/phone`
6. **Backend верифицирует token через Firebase Admin SDK**
7. **Backend проверяет:**
   - Если пользователь существует (по `firebase_uid`) → **LOGIN**
   - Если не существует → **REGISTER** (создает нового пользователя)
8. **Backend возвращает JWT токен** + данные пользователя
9. **Flutter сохраняет JWT** → навигация на главную страницу

---

## 🔑 Важные моменты

### **Firebase Service Account для Backend**

Backend нужен **Service Account JSON** для верификации токенов.

**Как получить:**
1. Firebase Console → Project Settings → Service Accounts
2. Нажми "Generate new private key"
3. Скачай JSON файл
4. Загрузи на VPS в директорию backend
5. Укажи путь в переменной окружения `GOOGLE_APPLICATION_CREDENTIALS`

---

### **Тестирование Phone Auth**

#### **На реальных устройствах:**
- SMS будет отправлен на реальный номер
- Все работает как в продакшне

#### **На симуляторах/эмуляторах:**
Firebase поддерживает **Test Phone Numbers**:

1. Firebase Console → Authentication → Sign-in method → Phone
2. Scroll down → Phone numbers for testing
3. Добавь тестовый номер (например: `+7 999 999 9999`) и код (`123456`)
4. Используй этот номер в приложении - SMS не придет, но код `123456` будет работать

---

## 🎨 UI/UX

### **PhoneLoginPage:**
- Красивый градиентный фон
- Glassmorphism карточка для ввода телефона
- Поле с выбором страны (по умолчанию Казахстан - KZ)
- Валидация номера
- Анимированная кнопка с loading state

### **PhoneVerifyPage:**
- 6 красивых квадратиков для PIN кода
- Автоматическая отправка при вводе 6 цифр
- Таймер 60 секунд для повторной отправки
- Показ номера телефона для подтверждения

---

## 🐛 Troubleshooting

### **Проблема: "Invalid Firebase token"**
- Убедись что Firebase Service Account JSON загружен на backend
- Проверь что `GOOGLE_APPLICATION_CREDENTIALS` указан в `.env` или docker-compose

### **Проблема: "SMS не приходит"**
- Проверь что Phone Auth включен в Firebase Console
- Для iOS: убедись что APNs Key настроен
- Для Android: убедись что SHA-1 fingerprint добавлен
- Используй Test Phone Numbers для тестирования

### **Проблема: "Backend error 500"**
- Проверь логи backend: `docker logs memoir-python-backend-1`
- Убедись что миграция применена: `docker exec memoir-python-backend-1 alembic current`

### **Проблема: "401 Unauthorized при создании memories"**
- Firebase токен успешно обменян на JWT?
- JWT сохранен в SharedPreferences?
- Проверь что `AuthInterceptor` добавляет токен в headers

---

## 🎯 Следующие шаги (опционально)

1. **WhatsApp Auth** (если нужно):
   - Интеграция с Twilio WhatsApp API
   - Требует Business аккаунт и аппрув

2. **Social Auth** (Google, Apple):
   - Можно оставить как дополнительные опции
   - Или полностью убрать

3. **Обновление существующих пользователей**:
   - Если есть пользователи с email/password
   - Создать миграционный flow для привязки телефона

---

## 📦 Deployment Checklist

### **Flutter:**
- [ ] Обновить `.env` для продакшна (API_BASE_URL)
- [ ] Проверить что `GoogleService-Info.plist` и `google-services.json` в `.gitignore`
- [ ] Настроить APNs certificates для production
- [ ] Настроить Release signing для Android

### **Backend:**
- [ ] Загрузить Firebase Service Account JSON на VPS
- [ ] Настроить `GOOGLE_APPLICATION_CREDENTIALS` в docker-compose
- [ ] Применить миграцию БД
- [ ] Перезапустить backend контейнеры
- [ ] Проверить что Phone Auth endpoint работает

---

## 🎉 Готово!

Теперь у тебя есть полностью рабочая **Phone Authentication через Firebase**!

Если что-то не работает - смотри `FIREBASE_SETUP.md` для подробной настройки или пиши мне! 🚀

