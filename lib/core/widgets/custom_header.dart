import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:memoir/core/theme/app_theme.dart';
import 'package:memoir/core/widgets/glass_button.dart';
import 'package:ionicons/ionicons.dart';

enum HeaderType { pop, close, back, none }

class CustomHeader extends StatelessWidget {
  final String title;
  final HeaderType type;
  final bool isDark;
  final VoidCallback? onBack;
  final Widget? trailing;

  const CustomHeader({
    super.key,
    required this.title,
    this.type = HeaderType.close,
    this.isDark = false,
    this.onBack,
    this.trailing,
  });

  /// Определяет, какой тип кнопки показывать
  /// Если указан pop, но нет предыдущих роутов - показываем close
  HeaderType _getEffectiveType(BuildContext context) {
    if (type == HeaderType.pop) {
      // Проверяем, можно ли сделать pop
      final canPop = Navigator.canPop(context);
      if (!canPop) {
        // Если нельзя сделать pop (например, пришли по диплинку), показываем close
        return HeaderType.close;
      }
    }
    return type;
  }

  @override
  Widget build(BuildContext context) {
    final effectiveType = _getEffectiveType(context);

    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      color: Colors.transparent,
      child: Stack(
            children: [
          // Центрированный заголовок с отступами для кнопок
          if (title.isNotEmpty)
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal:
                      (effectiveType == HeaderType.pop ||
                          effectiveType == HeaderType.close ||
                          effectiveType == HeaderType.back)
                      ? 48 // Отступ для кнопок слева/справа
                      : trailing != null
                      ? 120 // Отступ для trailing виджета (несколько кнопок)
                      : 0,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.darkColor.withOpacity(0.1),
                        blurRadius: 20,
                        spreadRadius: 0,
                        offset: const Offset(0, 4),
                      ),
                      BoxShadow(
                        color: AppTheme.darkColor.withOpacity(0.05),
                        blurRadius: 10,
                        spreadRadius: 0,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.85),
                          borderRadius: BorderRadius.circular(20),
                          border: Border(
                            bottom: BorderSide(
                              color: AppTheme.darkColor.withOpacity(0.08),
                              width: 0.5,
                            ),
                          ),
                        ),
                        child: Text(
                          title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.darkColor,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          // Левая кнопка (pop/back)
          if (effectiveType == HeaderType.pop ||
              effectiveType == HeaderType.back)
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              child: Center(
                child: GlassButton(
                  onTap: () {
                    if (onBack != null) {
                      onBack!();
                    } else {
                      if (Navigator.canPop(context)) {
                        Navigator.of(context).pop();
                      }
                    }
                  },
                  child: Icon(
                    Ionicons.chevron_back,
                    color: AppTheme.darkColor,
                    size: 20,
                  ),
                ),
              ),
            ),
          // Правая кнопка (close)
          if (effectiveType == HeaderType.close)
            Positioned(
              right: 0,
              top: 0,
              bottom: 0,
              child: Center(
                child: GlassButton(
                  onTap: () {
                    // Крестик закрывает модуль полностью и возвращает на главную
                    if (onBack != null) {
                      onBack!();
                    } else {
                      // Закрываем текущий экран или возвращаемся на главную
                      if (Navigator.canPop(context)) {
                        Navigator.of(context).pop();
                      } else {
                        Navigator.of(context).pushReplacementNamed('/home');
                      }
                    }
                  },
                  child: Icon(
                    Ionicons.close,
                    color: AppTheme.darkColor,
                    size: 20,
                  ),
                ),
              ),
            ),
          // Trailing widget (если есть)
          if (trailing != null)
            Positioned(
              right: effectiveType == HeaderType.close ? 48 : 0,
              top: 0,
              bottom: 0,
              child: Center(child: trailing!),
            ),
            ],
      ),
    );
  }
}
