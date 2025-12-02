# 🔐 OAuth Авторизация - Настройка

Инструкция по настройке Google и Apple Sign In для Memoir.

---

## 📱 Google Sign In

### 1. Firebase Console Setup

1. Перейдите в [Firebase Console](https://console.firebase.google.com/)
2. Создайте новый проект или выберите существующий
3. Перейдите в **Authentication** → **Sign-in method**
4. Включите **Google** провайдер
5. Скачайте конфигурационные файлы:
   - **Android**: `google-services.json`
   - **iOS**: `GoogleService-Info.plist`

### 2. Android Configuration

**Файл**: `android/app/google-services.json`

1. Поместите `google-services.json` в `android/app/`
2. Обновите `android/build.gradle`:

```gradle
buildscript {
    dependencies {
        // ...
        classpath 'com.google.gms:google-services:4.4.0'
    }
}
```

3. Обновите `android/app/build.gradle`:

```gradle
apply plugin: 'com.google.gms.google-services'

android {
    defaultConfig {
        // ...
        minSdkVersion 21 // Минимум для Google Sign In
    }
}
```

### 3. iOS Configuration

**Файл**: `ios/Runner/GoogleService-Info.plist`

1. Поместите `GoogleService-Info.plist` в `ios/Runner/`
2. Откройте `ios/Runner.xcworkspace` в Xcode
3. Добавьте файл в проект (правый клик → Add Files to "Runner")
4. Обновите `ios/Runner/Info.plist`:

```xml
<key>CFBundleURLTypes</key>
<array>
    <dict>
        <key>CFBundleTypeRole</key>
        <string>Editor</string>
        <key>CFBundleURLSchemes</key>
        <array>
            <!-- Замените на ваш REVERSED_CLIENT_ID из GoogleService-Info.plist -->
            <string>com.googleusercontent.apps.YOUR-CLIENT-ID</string>
        </array>
    </dict>
</array>
```

### 4. Получение SHA-1 для Android

```bash
# Debug keystore
keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android -keypass android

# Release keystore
keytool -list -v -keystore /path/to/your/keystore -alias your-alias
```

Добавьте SHA-1 в Firebase Console:
**Project Settings** → **Your apps** → **Android app** → **SHA certificate fingerprints**

---

## 🍎 Apple Sign In

### 1. Apple Developer Console

1. Перейдите в [Apple Developer](https://developer.apple.com/)
2. **Certificates, Identifiers & Profiles** → **Identifiers**
3. Выберите ваш App ID (или создайте новый)
4. Включите **Sign in with Apple** capability
5. Сохраните изменения

### 2. iOS Configuration

**Xcode Setup:**

1. Откройте `ios/Runner.xcworkspace` в Xcode
2. Выберите Target **Runner**
3. Перейдите в **Signing & Capabilities**
4. Нажмите **+ Capability**
5. Добавьте **Sign in with Apple**

### 3. Проверка Bundle ID

Убедитесь что Bundle ID в Xcode совпадает с App ID в Apple Developer:

**Xcode** → **Runner** → **General** → **Bundle Identifier**

Например: `com.yourcompany.memoir`

### 4. macOS Support (опционально)

Если хотите поддержку macOS:

1. Добавьте capability в macOS target
2. Обновите `macos/Runner/DebugProfile.entitlements`:

```xml
<key>com.apple.developer.applesignin</key>
<array>
    <string>Default</string>
</array>
```

---

## 🔧 Backend Integration

Для полной интеграции нужно добавить эндпоинты в backend:

### Endpoint для OAuth

**POST** `/api/v1/auth/oauth`

**Body:**
```json
{
  "provider": "google|apple",
  "id_token": "...",
  "access_token": "..." // Только для Google
}
```

**Response:**
```json
{
  "access_token": "jwt_token_here",
  "user": {
    "id": "uuid",
    "email": "user@example.com",
    "username": "username"
  }
}
```

### Python Backend (FastAPI)

```python
# app/api/v1/auth.py

from google.oauth2 import id_token
from google.auth.transport import requests

@router.post("/oauth")
async def oauth_login(
    provider: str,
    id_token: str,
    db: AsyncSession = Depends(get_db)
):
    if provider == "google":
        # Верификация Google ID token
        idinfo = id_token.verify_oauth2_token(
            id_token, 
            requests.Request(),
            GOOGLE_CLIENT_ID
        )
        
        email = idinfo['email']
        name = idinfo.get('name')
        
        # Найти или создать пользователя
        user = await get_or_create_user(db, email, name)
        
        # Создать JWT токен
        access_token = create_access_token(user.id)
        
        return {
            "access_token": access_token,
            "user": user
        }
    
    elif provider == "apple":
        # Верификация Apple ID token
        # ...
        pass
```

---

## 📱 Обновление Flutter кода

После настройки backend обновите методы в `OAuthService`:

```dart
// lib/core/services/oauth_service.dart

static Future<String?> signInWithGoogleAndGetToken() async {
  final result = await signInWithGoogle();
  if (result == null) return null;
  
  // Отправить на backend
  final response = await dio.post(
    '/api/v1/auth/oauth',
    data: {
      'provider': 'google',
      'id_token': result['id_token'],
      'access_token': result['access_token'],
    },
  );
  
  // Вернуть JWT token
  return response.data['access_token'];
}
```

---

## ✅ Проверка настройки

### Google Sign In

```bash
# Проверить что SHA-1 добавлен в Firebase
flutter run --debug

# В логах должно быть:
# ✅ Google Sign In configured
# ✅ SHA-1: AA:BB:CC:DD:...
```

### Apple Sign In

```bash
# Только на реальном iOS устройстве (simulator не поддерживает)
flutter run --release
```

---

## 🎯 Текущий статус

✅ **UI готов** - кнопки Google и Apple на LoginPage  
✅ **OAuth Service готов** - логика получения токенов  
⏳ **Backend интеграция** - нужно добавить эндпоинт  
⏳ **Firebase настройка** - нужно добавить конфигурационные файлы  
⏳ **Apple Developer** - нужно настроить App ID  

---

## 🚀 Быстрый старт для тестирования

### Без backend (текущая реализация)

Приложение уже показывает OAuth кнопки и выполняет вход через Google/Apple,
но не интегрировано с backend. После успешного входа показывается SnackBar
с информацией о пользователе.

### С backend (после настройки)

1. Настройте Firebase и Apple Developer
2. Добавьте конфигурационные файлы
3. Реализуйте endpoint `/api/v1/auth/oauth` в backend
4. Обновите `OAuthService` для отправки токенов на backend
5. Сохраняйте JWT токен и переходите на HomePage

---

## 📚 Полезные ссылки

- [Google Sign In for Flutter](https://pub.dev/packages/google_sign_in)
- [Sign in with Apple for Flutter](https://pub.dev/packages/sign_in_with_apple)
- [Firebase Console](https://console.firebase.google.com/)
- [Apple Developer Console](https://developer.apple.com/)
- [Google OAuth 2.0 Docs](https://developers.google.com/identity/protocols/oauth2)
- [Apple Sign In Docs](https://developer.apple.com/sign-in-with-apple/)

---

## 💡 Советы

- **Google**: Работает на всех платформах (Android, iOS, Web)
- **Apple**: Только iOS/macOS (автоматически скрывается на Android)
- **Testing**: Google можно тестировать на эмуляторе, Apple - только на устройстве
- **SHA-1**: Нужен для Android, получите из debug и release keystore
- **Bundle ID**: Должен совпадать везде (Xcode, Firebase, Apple Developer)

---

Успешной интеграции! 🎉

