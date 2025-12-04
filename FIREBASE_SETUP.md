# 🔥 Firebase Phone Authentication - Инструкция по настройке

## Шаг 1: Создание Firebase проекта

1. Перейди на [Firebase Console](https://console.firebase.google.com/)
2. Нажми "Add project" (Создать проект)
3. Название проекта: `Memoir` (или любое другое)
4. Отключи Google Analytics (не нужен для MVP)
5. Нажми "Create project"

---

## Шаг 2: Добавление iOS приложения

### 2.1. Регистрация iOS app
1. В Firebase Console → Project Overview → Add app → iOS
2. iOS bundle ID: `net.memoir-ai.app`
3. App nickname: `Memoir iOS`
4. Нажми "Register app"

### 2.2. Скачай GoogleService-Info.plist
1. Скачай файл `GoogleService-Info.plist`
2. Открой Xcode: `open ios/Runner.xcworkspace`
3. Перетащи `GoogleService-Info.plist` в `Runner/Runner` папку
4. ✅ Убедись что выбрано "Copy items if needed"

### 2.3. Включи Phone Authentication
1. В Firebase Console → Authentication → Get started
2. Sign-in method → Phone → Enable → Save

---

## Шаг 3: Добавление Android приложения

### 3.1. Регистрация Android app
1. В Firebase Console → Project Overview → Add app → Android
2. Android package name: `net.memoir_ai.app`
3. App nickname: `Memoir Android`
4. Нажми "Register app"

### 3.2. Скачай google-services.json
1. Скачай файл `google-services.json`
2. Помести его в `android/app/google-services.json`

### 3.3. Настрой SHA-1 fingerprint (важно для Phone Auth!)

**Debug SHA-1:**
```bash
cd android
./gradlew signingReport
```

Скопируй SHA1 и SHA-256 для `debug` и добавь в Firebase Console:
- Project Settings → Your apps → Android app → Add fingerprint

**Release SHA-1** (потом, когда будешь публиковать):
```bash
keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android -keypass android
```

---

## Шаг 4: Настройка iOS для Phone Auth

### 4.1. Включи Push Notifications в Xcode
1. Открой `ios/Runner.xcworkspace` в Xcode
2. Выбери Runner target
3. Signing & Capabilities → + Capability → Push Notifications

### 4.2. Включи Background Modes
1. Signing & Capabilities → + Capability → Background Modes
2. Включи: ✅ Background fetch, ✅ Remote notifications

### 4.3. Настрой APNs Key (для reCAPTCHA bypass)
1. Перейди в [Apple Developer Account](https://developer.apple.com/account/resources/authkeys/list)
2. Keys → + (создать новый ключ)
3. Название: `Memoir APNs Key`
4. Включи: ✅ Apple Push Notifications service (APNs)
5. Скачай `.p8` файл (сохрани безопасно!)
6. Скопируй **Key ID**

7. В Firebase Console → Project Settings → Cloud Messaging → iOS app configuration
8. Загрузи `.p8` файл
9. Введи Key ID и Team ID (найдешь в Apple Developer → Membership)

---

## Шаг 5: Настройка Android для Phone Auth

### 5.1. Обнови android/build.gradle
Добавь в `dependencies`:
```gradle
classpath 'com.google.gms:google-services:4.4.0'
```

### 5.2. Обнови android/app/build.gradle.kts
В конец файла добавь:
```kotlin
apply(plugin = "com.google.gms.google-services")
```

---

## Шаг 6: Flutter CLI - инициализация Firebase

После того как добавишь все файлы, выполни:

```bash
# Установи FlutterFire CLI
dart pub global activate flutterfire_cli

# Настрой Firebase для проекта
flutterfire configure
```

Выбери:
- ✅ iOS
- ✅ Android

---

## 🎯 Следующий шаг

После выполнения всех шагов, дай мне знать и я продолжу с кодом! 🚀

---

## 📌 Чек-лист

- [ ] Firebase проект создан
- [ ] iOS app добавлен + GoogleService-Info.plist
- [ ] Android app добавлен + google-services.json
- [ ] Phone Authentication включен в Firebase Console
- [ ] SHA-1 fingerprint добавлен для Android
- [ ] APNs Key настроен для iOS
- [ ] Push Notifications включены в Xcode
- [ ] google-services plugin добавлен в Android
- [ ] flutterfire configure выполнен

Когда всё готово - пиши! 💪

