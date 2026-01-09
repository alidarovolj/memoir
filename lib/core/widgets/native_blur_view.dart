import 'dart:io';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Native iOS blur view using UIVisualEffectView
/// Обеспечивает настоящий iOS "Liquid Glass" эффект
/// идентичный Telegram / ChatGPT
///
/// ВАЖНО: Работает только на iOS!
/// На других платформах показывает fallback (BackdropFilter)
class NativeBlurView extends StatelessWidget {
  /// Стиль blur эффекта
  /// - ultraThin: самый тонкий (по умолчанию)
  /// - thin: тонкий
  /// - regular: обычный
  /// - thick: толстый
  /// - chrome: хромированный
  final String style;
  
  /// Радиус скругления углов (по умолчанию 0)
  final double cornerRadius;
  
  /// Дочерний виджет, который будет отображаться поверх blur
  final Widget? child;
  
  const NativeBlurView({
    super.key,
    this.style = 'ultraThin',
    this.cornerRadius = 0,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    // Проверяем платформу
    if (!kIsWeb && Platform.isIOS) {
      // iOS: используем нативный PlatformView
      return Stack(
        children: [
          UiKitView(
            viewType: 'native-blur-view',
            layoutDirection: TextDirection.ltr,
            creationParams: {
              'style': style,
              'cornerRadius': cornerRadius,
            },
            creationParamsCodec: const StandardMessageCodec(),
          ),
          if (child != null) child!,
        ],
      );
    } else {
      // Fallback для других платформ
      return ClipRRect(
        borderRadius: BorderRadius.circular(cornerRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.12),
              borderRadius: BorderRadius.circular(cornerRadius),
            ),
            child: child,
          ),
        ),
      );
    }
  }
}
