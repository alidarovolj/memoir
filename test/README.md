# 🧪 Testing Guide - Memoir

## 📋 Обзор

Этот проект использует **Flutter Test Framework** для unit, widget и integration тестирования.

## 🗂️ Структура тестов

```
test/
├── core/
│   ├── services/          # Unit тесты для сервисов
│   │   └── audio_recorder_service_test.dart
│   └── widgets/           # Widget тесты
│       ├── audio_player_widget_test.dart
│       └── custom_header_test.dart
├── features/
│   ├── pet/
│   │   └── pet_service_test.dart
│   └── challenges/
│       └── models/
│           └── challenge_model_test.dart
└── widget_test.dart       # Базовый тест

```

## 🚀 Запуск тестов

### Все тесты
```bash
flutter test
```

### Конкретный файл
```bash
flutter test test/features/pet/pet_service_test.dart
```

### С coverage
```bash
flutter test --coverage
```

## ✅ Текущее покрытие

- **Unit Tests**: 5 тестов
  - Pet Service (XP, Evolution, Happiness)
  - Challenge Model (JSON, Calculations)
  
- **Widget Tests**: 5 тестов
  - Custom Header (Title, Back Button)
  - Audio Player Widget (UI, Delete)
  
- **Total**: 10+ тестов

## 📝 Примеры

### Unit Test (Service)
```dart
test('XP calculation for level up', () {
  expect(calculateXPForLevel(1), 100);
  expect(calculateXPForLevel(5), 500);
});
```

### Widget Test
```dart
testWidgets('should display title correctly', (tester) async {
  await tester.pumpWidget(
    MaterialApp(
      home: CustomHeader(title: 'Test'),
    ),
  );
  
  expect(find.text('Test'), findsOneWidget);
});
```

### Model Test (JSON)
```dart
test('should create model from JSON', () {
  final json = {'title': 'Test', 'count': 10};
  final model = Model.fromJson(json);
  
  expect(model.title, 'Test');
  expect(model.count, 10);
});
```

## 🛠️ Best Practices

1. **Один тест - одна проверка**: Каждый test() проверяет только одну вещь
2. **Четкие названия**: `test('should calculate XP correctly')`
3. **Setup/Teardown**: Используйте `setUp()` и `tearDown()` для инициализации
4. **Mocking**: Для зависимостей используйте `mockito` или `mocktail`
5. **Integration Tests**: Для сложных флоу используйте `integration_test/`

## 📚 Что тестировать

### ✅ Должно быть протестировано:
- Business Logic (services, repositories)
- Модели (JSON serialization)
- Utility functions
- Widget states и interactions
- Navigation flows

### ❌ Не обязательно тестировать:
- UI layouts (visual regression testing лучше)
- Third-party packages
- Platform channels (integration tests)

## 🔮 Планы

- [ ] Увеличить покрытие до 80%
- [ ] Добавить Integration Tests
- [ ] Настроить CI/CD с автозапуском тестов
- [ ] Golden Tests для UI компонентов
- [ ] E2E тесты критических флоу

## 📖 Ресурсы

- [Flutter Testing Docs](https://flutter.dev/docs/testing)
- [Effective Dart: Testing](https://dart.dev/guides/language/effective-dart/testing)
- [Widget Testing](https://flutter.dev/docs/cookbook/testing/widget/introduction)
