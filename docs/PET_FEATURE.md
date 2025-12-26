# 🐾 Virtual Pet Feature - Implementation Guide

**Дата:** 24 декабря 2025  
**Статус:** ✅ РЕАЛИЗОВАНО (Core MVP)

---

## 📖 Обзор

Виртуальный питомец - это **ключевая retention механика**, которая превращает приложение из "просто дневника" в **персонального компаньона роста**.

### Концепция
> "Питомец растет вместе с пользователем. Создание воспоминаний = кормление, выполнение задач = игра, поддержание streak = здоровье"

---

## 🎯 Реализованные функции

### Backend (FastAPI + SQLAlchemy)

#### 1. Database Model (`app/models/pet.py`)
- ✅ `Pet` модель с полями:
  - `pet_type`: bird, cat, dragon
  - `evolution_stage`: egg → baby → adult → legend
  - `level`, `xp`: Система прогрессии
  - `happiness`, `health`: Статы 0-100
  - `last_fed`, `last_played`: Отслеживание активности
- ✅ Методы: `feed()`, `play()`, `evolve()`, `decay_stats()`
- ✅ Evolution thresholds: 5, 15, 30 уровни

#### 2. API Endpoints (`app/api/v1/pets.py`)
```http
POST   /api/v1/pets         # Создать питомца
GET    /api/v1/pets/me      # Получить питомца пользователя
POST   /api/v1/pets/feed    # Покормить (+10 XP, +10 happiness)
POST   /api/v1/pets/play    # Поиграть (+15 XP, +15 health)
PUT    /api/v1/pets/name    # Переименовать питомца
GET    /api/v1/pets/stats   # Получить статистику
```

#### 3. Schemas (`app/schemas/pet.py`)
- ✅ Request/Response модели
- ✅ Enums: `PetType`, `EvolutionStage`
- ✅ Validators для имени и статов

#### 4. Database Migration
```bash
# Alembic migration
backend/alembic/versions/2025_12_24_1600-add_pets_table.py
```

#### 5. Celery Task (`app/tasks/notification_tasks.py`)
- ✅ `check_pet_health`: Проверяет health питомцев 2 раза в день
- ✅ Отправляет push-уведомления если:
  - Не кормили > 48 часов
  - Не играли > 48 часов
  - `happiness` < 30
  - `health` < 30

---

### Frontend (Flutter + Freezed + Dio)

#### 1. Data Models (`lib/features/pet/data/models/pet_model.dart`)
- ✅ `PetModel` (freezed)
- ✅ `PetCreateRequest`
- ✅ `PetActionResponse` (для feed/play)
- ✅ `PetStats`
- ✅ Extensions: emojis, xpPercentage, nextMilestone

#### 2. Data Source (`lib/features/pet/data/datasources/pet_remote_datasource.dart`)
- ✅ `PetRemoteDataSource` с методами API

#### 3. Pet Service (`lib/features/pet/data/services/pet_service.dart`)
- ✅ Singleton сервис для глобального доступа к питомцу
- ✅ Методы: `loadPet()`, `feedPet()`, `playWithPet()`

#### 4. UI Components

##### PetWidget (`lib/features/pet/presentation/widgets/pet_widget.dart`)
- ✅ Floating компаньон для главной страницы
- ✅ Full и compact режимы
- ✅ Progress bars: happiness, health, XP
- ✅ Attention indicator (⚠️)

##### PetPage (`lib/features/pet/presentation/pages/pet_page.dart`)
- ✅ Полноэкранная интерактивная страница
- ✅ Bounce анимация питомца
- ✅ Stat cards с прогресс-барами
- ✅ Action buttons: Покормить, Поиграть
- ✅ Celebration dialogs (level up / evolution)
- ✅ Info section (как растить питомца)

##### PetOnboardingPage (`lib/features/pet/presentation/pages/pet_onboarding_page.dart`)
- ✅ 2-step onboarding:
  1. Выбор типа питомца (bird / cat / dragon)
  2. Название питомца
- ✅ Progress indicator
- ✅ Evolution preview
- ✅ Красивая анимация и градиенты

#### 5. Интеграции

##### Главная страница (`lib/main.dart`)
- ✅ Загрузка питомца при старте
- ✅ Автоматический onboarding если питомца нет
- ✅ PetWidget на главной под ReferralBanner
- ✅ **Feed pet** при создании воспоминания
- ✅ Обновление pet state после действий

##### Tasks Page (`lib/features/tasks/presentation/pages/tasks_page.dart`)
- ✅ **Play with pet** при выполнении задачи

---

## 🎮 User Journey

### Первый запуск
1. Пользователь открывает приложение
2. Загружается главная → обнаруживается отсутствие питомца
3. Автоматически открывается `PetOnboardingPage`
4. Пользователь выбирает тип (bird/cat/dragon)
5. Даёт имя питомцу
6. Питомец создаётся и появляется на главной

### Ежедневное использование
1. **Утро (9:00)**: Push от питомца "Доброе утро! Не забудьте покормить меня"
2. **Создание воспоминания** → Pet автоматически кормится (+10 XP, +10 happiness)
3. **Выполнение задачи** → Pet играет (+15 XP, +15 health)
4. **Level up** → Celebration modal
5. **Evolution (уровни 5, 15, 30)** → Dramatic animation
6. **Вечер (21:00)**: Push "Проверьте своего питомца"

### Если пользователь неактивен
- **24+ часов**: Статы начинают decay (-5 за 24 часа)
- **48+ часов**: Push уведомление
- **happiness < 30**: Питомец грустит 😢
- **health < 30**: Питомец болеет 💔

---

## 📊 Ключевые метрики

### Pet Stats
- **Happiness**: 0-100, падает без воспоминаний
- **Health**: 0-100, падает без задач
- **XP**: Накапливается за действия
- **Level**: Растёт с XP (100 + level * 50 XP за уровень)

### Evolution Stages
| Stage | Level | Emoji Bird | Emoji Cat | Emoji Dragon |
|-------|-------|------------|-----------|--------------|
| Egg   | 1-4   | 🥚         | 🥚        | 🥚           |
| Baby  | 5-14  | 🐣         | 🐱        | 🦎           |
| Adult | 15-29 | 🐦         | 🐈        | 🐲           |
| Legend| 30+   | 🦅         | 🦁        | 🐉           |

### XP Rewards
- **Feed (создание воспоминания)**: +10 XP, +10 happiness
- **Play (выполнение задачи)**: +15 XP, +15 health

---

## 🚀 Запуск и тестирование

### Backend

```bash
# 1. Apply migration
cd backend
alembic upgrade head

# 2. Start services
docker compose up -d

# 3. Test endpoints
curl -X POST http://localhost:8000/api/v1/pets \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"pet_type": "bird", "name": "Tweety"}'

curl http://localhost:8000/api/v1/pets/me \
  -H "Authorization: Bearer YOUR_TOKEN"
```

### Frontend

```bash
# 1. Generate models
flutter pub run build_runner build --delete-conflicting-outputs

# 2. Run app
flutter run

# 3. Test flow
# - Onboarding должен показаться автоматически
# - Создайте воспоминание → питомец кормится
# - Выполните задачу → питомец играет
# - Откройте PetPage → проверьте статы
```

### Celery (Pet Health Check)

```bash
# Start Celery beat
celery -A app.tasks.celery_app beat --loglevel=info

# Run task manually
docker exec memoir-backend celery -A app.tasks.celery_app call check_pet_health
```

---

## 📁 Файловая структура

```
backend/
├── app/
│   ├── models/
│   │   ├── pet.py                     ✅ Pet model
│   │   └── user.py                    ✅ Updated (relationship)
│   ├── schemas/
│   │   └── pet.py                     ✅ Pydantic schemas
│   ├── api/v1/
│   │   ├── pets.py                    ✅ API endpoints
│   │   └── __init__.py                ✅ Updated (router)
│   └── tasks/
│       └── notification_tasks.py      ✅ check_pet_health task
└── alembic/versions/
    └── 2025_12_24_1600-add_pets_table.py  ✅ Migration

lib/
├── features/pet/
│   ├── data/
│   │   ├── models/
│   │   │   ├── pet_model.dart          ✅ Freezed models
│   │   │   ├── pet_model.freezed.dart  ✅ Generated
│   │   │   └── pet_model.g.dart        ✅ Generated
│   │   ├── datasources/
│   │   │   └── pet_remote_datasource.dart  ✅ API client
│   │   └── services/
│   │       └── pet_service.dart        ✅ Global service
│   └── presentation/
│       ├── pages/
│       │   ├── pet_page.dart           ✅ Full-screen pet page
│       │   └── pet_onboarding_page.dart ✅ Onboarding
│       └── widgets/
│           └── pet_widget.dart         ✅ Floating widget
└── main.dart                           ✅ Integration
```

---

## 🎨 UI/UX Features

### Визуальные эффекты
- ✅ Gradient backgrounds (primaryGradient)
- ✅ Bounce animation для питомца
- ✅ Fade/Slide transitions
- ✅ Progress bars с цветами:
  - Happiness: 💖 Pink
  - Health: 💚 Green
  - XP: ⭐ Yellow

### Feedback механики
- ✅ Celebration dialogs (level up / evolution)
- ✅ Attention indicator (⚠️ оранжевый)
- ✅ Success snackbars
- ✅ Next milestone hints

---

## 🔮 Что дальше (Not in MVP)

### Phase 2: Animations
- [ ] Lottie/Rive анимации питомцев
- [ ] Idle animations (питомец дышит)
- [ ] Feed/Play анимации
- [ ] Evolution transformation

### Phase 3: Customization
- [ ] Accessories (шляпы, очки)
- [ ] Pet backgrounds/themes
- [ ] Unlockable items

### Phase 4: Social
- [ ] Pet Village (см. питомцев друзей)
- [ ] Pet interactions
- [ ] Leaderboard по уровням

### Phase 5: Advanced Mechanics
- [ ] Mini-games с питомцем
- [ ] Pet abilities (усиливают награды)
- [ ] Pet mood system (не только счастье/здоровье)

---

## ✅ Checklist выполнения

- [x] Backend: Pet model + migration
- [x] Backend: API endpoints (/pets, /feed, /play)
- [x] Backend: Celery task для health check
- [x] Frontend: Freezed models + datasource
- [x] Frontend: PetService (global state)
- [x] Frontend: PetWidget (home display)
- [x] Frontend: PetPage (full interaction)
- [x] Frontend: PetOnboardingPage
- [x] Integration: Feed при создании воспоминания
- [x] Integration: Play при выполнении задачи
- [x] Integration: Автоматический onboarding
- [ ] Notification Service: send_pet_reminder method
- [ ] Testing: Unit tests
- [ ] Testing: E2E flow
- [ ] Lottie animations (Phase 2)

---

## 💡 Советы по дальнейшей разработке

1. **Анимации**: Используйте Rive для интерактивных анимаций питомцев
2. **A/B тестирование**: 
   - Тестируйте разные XP rewards
   - Оптимизируйте decay rates
3. **Персонализация**: AI может генерировать персональные советы от имени питомца
4. **Gamification**: Добавьте seasonal events (Новый год, Хэллоуин)
5. **Retention**: Отслеживайте correlation между pet level и user retention

---

**Статус**: ✅ Core MVP реализован и готов к тестированию  
**Следующий шаг**: Soft launch с 50-100 пользователями для сбора feedback
