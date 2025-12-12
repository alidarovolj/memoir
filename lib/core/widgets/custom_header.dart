import 'package:flutter/material.dart';
import 'package:memoir/core/theme/app_theme.dart';
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
      color: AppTheme.headerBackgroundColor,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Stack(
        children: [
          // Центрированный заголовок с отступами для кнопок
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
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: SlideTransition(
                      position:
                          Tween<Offset>(
                            begin: const Offset(0.0, -0.3),
                            end: Offset.zero,
                          ).animate(
                            CurvedAnimation(
                              parent: animation,
                              curve: Curves.easeOut,
                            ),
                          ),
                      child: child,
                    ),
                  );
                },
                child: title.isNotEmpty
                    ? Text(
                        title,
                        key: const ValueKey('title'),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      )
                    : const SizedBox.shrink(key: ValueKey('empty')),
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
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    if (onBack != null) {
                      onBack!();
                    } else {
                      if (Navigator.canPop(context)) {
                        Navigator.of(context).pop();
                      }
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: Icon(
                      Ionicons.chevron_back,
                      color: AppTheme.primaryColor,
                      size: 24,
                    ),
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
                child: GestureDetector(
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
                    color: AppTheme.primaryColor,
                    size: 24,
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
