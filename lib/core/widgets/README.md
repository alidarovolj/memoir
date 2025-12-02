# Переиспользуемые виджеты Memoir

Все глобальные виджеты приложения для единообразного дизайна и простоты разработки.

## 📦 Импорт

```dart
import 'package:memoir/core/widgets/widgets.dart';
// или
import 'package:memoir/core/core.dart';
```

---

## 🎨 UI Компоненты

### CustomAppBar

Кастомный AppBar с градиентным заголовком.

```dart
CustomAppBar(
  title: 'Memoir',
  actions: [
    IconButton(
      icon: Icon(Icons.search),
      onPressed: () {},
    ),
  ],
  leading: IconButton(
    icon: Icon(Icons.arrow_back),
    onPressed: () => Navigator.pop(context),
  ),
  useGradient: true, // по умолчанию
  centerTitle: true,  // по умолчанию
)
```

---

### CustomBottomNav

Кастомный bottom navigation bar с анимациями.

```dart
CustomBottomNav(
  selectedIndex: _selectedIndex,
  onDestinationSelected: (index) {
    setState(() => _selectedIndex = index);
    // Навигация
  },
)
```

---

### GradientButton

Кнопка с градиентным фоном и тенью.

```dart
GradientButton(
  text: 'Создать',
  icon: Icons.add,
  onPressed: () {},
  isLoading: false,
  gradient: AppTheme.primaryGradient, // опционально
)
```

### OutlinedGradientButton

Outlined кнопка с градиентной границей.

```dart
OutlinedGradientButton(
  text: 'Отмена',
  icon: Icons.close,
  onPressed: () {},
)
```

---

### CustomTextField

Стильное текстовое поле.

```dart
CustomTextField(
  controller: _controller,
  labelText: 'Заголовок',
  hintText: 'Введите текст...',
  prefixIcon: Icons.title,
  maxLines: 1,
  enabled: true,
)
```

---

### AIInfoCard

Информационная карточка об AI возможностях.

```dart
AIInfoCard(
  title: 'AI автоматически:',
  features: [
    AIFeature(icon: Icons.category, text: 'Определит категорию'),
    AIFeature(icon: Icons.tag, text: 'Создаст теги'),
  ],
)
```

---

### CategoryCard

Карточка категории с анимациями.

```dart
CategoryCard(
  name: 'Movies & TV',
  icon: Icons.movie,
  color: Colors.red,
  emoji: '🎬',
  count: 5,
  onTap: () {
    // Открыть категорию
  },
)
```

---

### EmptyState

Красивое пустое состояние с кнопкой действия.

```dart
EmptyState(
  icon: Icons.inbox,
  title: 'У вас пока нет воспоминаний',
  subtitle: 'Начните сохранять важные моменты',
  buttonText: 'Создать первое',
  buttonIcon: Icons.add,
  onButtonPressed: () {},
)
```

---

### LoadingState

Индикатор загрузки в фирменном стиле.

```dart
LoadingState(
  message: 'Загрузка...', // опционально
)
```

### LoadingOverlay

Оверлей с загрузкой поверх контента.

```dart
LoadingOverlay(
  isLoading: _isLoading,
  message: 'Сохранение...',
  child: YourContent(),
)
```

---

### GlassCard

Glassmorphism эффект для карточек.

```dart
GlassCard(
  blur: 10,
  opacity: 0.1,
  borderRadius: BorderRadius.circular(20),
  padding: EdgeInsets.all(16),
  child: YourWidget(),
)
```

---

### GradientIcon

Иконка с градиентным цветом.

```dart
GradientIcon(
  icon: Icons.star,
  size: 48,
  gradient: AppTheme.primaryGradient,
)
```

---

## 🎭 Переходы между страницами

### PageTransitions

Красивые анимированные переходы.

```dart
// Slide снизу вверх
Navigator.push(
  context,
  PageTransitions.slideFromBottom(NextPage()),
);

// Fade
Navigator.push(
  context,
  PageTransitions.fade(NextPage()),
);

// Scale + Fade
Navigator.push(
  context,
  PageTransitions.scale(NextPage()),
);

// Slide справа налево
Navigator.push(
  context,
  PageTransitions.slideFromRight(NextPage()),
);
```

---

## 🔔 Уведомления

### SnackBarUtils

Готовые SnackBar уведомления в фирменном стиле.

```dart
// Успех
SnackBarUtils.showSuccess(context, 'Сохранено!');

// Ошибка
SnackBarUtils.showError(context, 'Что-то пошло не так');

// Предупреждение
SnackBarUtils.showWarning(context, 'Заполните все поля');

// Информация
SnackBarUtils.showInfo(context, 'Поиск - в разработке');

// AI процесс
SnackBarUtils.showAIProcessing(
  context,
  'AI обрабатывает ваш запрос...',
);
```

---

## 🎨 Тема

### AppTheme

Все цвета и градиенты приложения.

```dart
// Цвета
AppTheme.primaryColor
AppTheme.secondaryColor
AppTheme.accentColor
AppTheme.backgroundColor
AppTheme.surfaceColor

// Градиенты
AppTheme.primaryGradient
AppTheme.accentGradient
AppTheme.backgroundGradient

// Использование
Container(
  decoration: BoxDecoration(
    gradient: AppTheme.primaryGradient,
  ),
)
```

---

## 📝 Примеры использования

### Полная страница с виджетами

```dart
class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        title: 'Мои воспоминания',
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: AppTheme.backgroundGradient,
        ),
        child: SafeArea(
          child: EmptyState(
            icon: Icons.inbox,
            title: 'Пусто',
            subtitle: 'Добавьте первое воспоминание',
            buttonText: 'Создать',
            buttonIcon: Icons.add,
            onButtonPressed: () {
              Navigator.push(
                context,
                PageTransitions.slideFromBottom(CreatePage()),
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNav(
        selectedIndex: 0,
        onDestinationSelected: (index) {},
      ),
    );
  }
}
```

---

## 🚀 Преимущества

✅ **Единообразие** - один стиль во всем приложении  
✅ **Переиспользование** - пишите меньше кода  
✅ **Анимации** - встроенные плавные переходы  
✅ **Простота** - интуитивно понятный API  
✅ **Масштабируемость** - легко обновлять дизайн  
✅ **Типобезопасность** - все параметры типизированы  

---

## 🎯 Best Practices

1. Всегда используйте переиспользуемые виджеты вместо кастомных
2. Используйте `PageTransitions` для навигации
3. Используйте `SnackBarUtils` для уведомлений
4. Используйте цвета и градиенты из `AppTheme`
5. Оборачивайте страницы в `Container` с `AppTheme.backgroundGradient`

