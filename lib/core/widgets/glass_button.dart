import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:memoir/core/theme/app_theme.dart';

/// Кнопка с эффектом Liquid Glass
/// Использует BackdropFilter с blur эффектом идентичным tabbar
class GlassButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;
  final double size;
  final EdgeInsets padding;

  const GlassButton({
    super.key,
    required this.child,
    required this.onTap,
    this.size = 36,
    this.padding = const EdgeInsets.all(8),
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size / 2),
          // Убрано темное свечение
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(size / 2),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.7),
                borderRadius: BorderRadius.circular(size / 2),
                // Без границ для нативного glassmorphism
              ),
              child: Center(child: child),
            ),
          ),
        ),
      ),
    );
  }
}
