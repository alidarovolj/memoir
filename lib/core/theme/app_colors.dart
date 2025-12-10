import 'package:flutter/material.dart';

/// Цветовая палитра приложения Memoir
///
/// Основана на дизайн-системе с использованием:
/// - Темных тонов для фона (#202020)
/// - Салатового акцента (#c9ff58)
/// - Светло-серого для secondary элементов (#f2f3f5)
///
/// Последнее обновление: 11 декабря 2025
class AppColors {
  // ========== ОСНОВНАЯ ПАЛИТРА ==========

  /// Темный цвет (#202020)
  /// Используется для: темные поверхности, текст на светлом
  static const Color dark = Color(0xFF202020);

  /// Фон приложения (#2f3035)
  /// Используется для: основной фон всего приложения
  static const Color appBackground = Color(0xFF2F3035);

  /// Синий/Blue (#6366ff)
  /// Используется для: accent, активные элементы, кнопки, выделение
  static const Color blue = Color(0xFF6366FF);

  /// Салатовый/Lime (#c9ff58) - резервный
  static const Color lime = Color(0xFFC9FF58);

  /// Светло-серый (#f2f3f5)
  /// Используется для: вторичные элементы, borders, разделители
  static const Color lightGray = Color(0xFFF2F3F5);

  /// Белый (#ffffff)
  /// Используется для: текст на темном, светлый фон, иконки
  static const Color white = Color(0xFFFFFFFF);

  // ========== ДОПОЛНИТЕЛЬНЫЕ ОТТЕНКИ ==========

  /// Темная поверхность (для карточек, модалов)
  static const Color darkSurface = Color(0xFF2A2A2A);

  /// Очень темный (для градиентов)
  static const Color veryDark = Color(0xFF1A1A1A);

  /// Светлый lime (для градиентов)
  static const Color limeLighter = Color(0xFFD4FF7A);

  /// Темный lime (для градиентов)
  static const Color limeDarker = Color(0xFFB3E64E);

  // ========== ГРАДИЕНТЫ ==========

  /// Основной градиент (Blue)
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [blue, Color(0xFF8B5CF6)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Градиент для floating tab bar
  static LinearGradient floatingTabBarGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [darkSurface.withOpacity(0.65), veryDark.withOpacity(0.75)],
  );

  /// Градиент фона
  static const LinearGradient backgroundGradient = LinearGradient(
    colors: [appBackground, Color(0xFF25262A)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // ========== СЕМАНТИЧЕСКИЕ ЦВЕТА ==========

  /// Успех (зеленый)
  static const Color success = Color(0xFF10B981);

  /// Ошибка (красный)
  static const Color error = Color(0xFFEF4444);

  /// Предупреждение (желтый)
  static const Color warning = Color(0xFFF59E0B);

  /// Информация (синий)
  static const Color info = Color(0xFF3B82F6);

  // ========== ПРИМЕНЕНИЕ ==========

  /// Пример использования:
  /// ```dart
  /// Container(
  ///   color: AppColors.dark,
  ///   child: Text(
  ///     'Hello',
  ///     style: TextStyle(color: AppColors.lime),
  ///   ),
  /// )
  /// ```
}
