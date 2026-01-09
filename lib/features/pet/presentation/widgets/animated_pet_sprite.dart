import 'dart:async';
import 'package:flutter/material.dart';

/// Animated pixel art pet sprite widget
class AnimatedPetSprite extends StatefulWidget {
  final String emotion;
  final double size;
  final bool isShiny;

  const AnimatedPetSprite({
    super.key,
    required this.emotion,
    this.size = 120,
    this.isShiny = false,
  });

  @override
  State<AnimatedPetSprite> createState() => _AnimatedPetSpriteState();
}

class _AnimatedPetSpriteState extends State<AnimatedPetSprite>
    with TickerProviderStateMixin {
  late AnimationController _frameController; // Анимация кадров
  late AnimationController _blinkController; // Анимация blink scale эффекта
  Timer? _idleTimer;

  // Количество кадров в спрайт-листе
  static const int _frameCount = 6;

  // Реальные размеры спрайт-листа: 996x250
  // Один кадр: 166x250
  // Aspect ratio одного кадра: ширина/высота = 166/250 = 0.664
  static const double _frameAspectRatio = 166.0 / 250.0;

  @override
  void initState() {
    super.initState();

    // Циклическая анимация кадров (6 кадров за 900мс = 150мс на кадр)
    _frameController = AnimationController(
      duration: const Duration(milliseconds: 900),
      vsync: this,
    )..repeat(); // бесконечно крутится 0→1→0→1...

    _blinkController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    // Random blink animation
    _startIdleAnimation();
  }

  void _startIdleAnimation() {
    _idleTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (mounted) {
        _blink();
      }
    });
  }

  Future<void> _blink() async {
    await _blinkController.forward();
    await Future.delayed(const Duration(milliseconds: 100));
    await _blinkController.reverse();
  }

  @override
  void dispose() {
    _idleTimer?.cancel();
    _frameController.dispose();
    _blinkController.dispose();
    super.dispose();
  }

  /// Получаем анимированный индекс кадра (0→1→2→3→4→5→0...)
  int _getAnimatedSpriteIndex() {
    // _frameController.value идёт от 0.0 до 1.0
    // Умножаем на _frameCount → получаем 0.0 до 5.999
    // floor() даёт целое число 0,1,2,3,4,5
    return (_frameController.value * _frameCount).floor() % _frameCount;
  }

  @override
  Widget build(BuildContext context) {
    // Рассчитываем правильные размеры: size = высота кадра
    final frameHeight = widget.size;
    final frameWidth = widget.size * _frameAspectRatio; // 120 * 0.664 = 79.68

    // Используем анимированный индекс вместо статичного
    return AnimatedBuilder(
      animation: _frameController,
      builder: (context, child) {
        final spriteIndex = _getAnimatedSpriteIndex();

        return Stack(
          alignment: Alignment.center,
          children: [
            // Shiny glow effect
            if (widget.isShiny)
              Container(
                width: frameWidth + 40,
                height: frameHeight + 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.amber.withOpacity(0.3),
                      blurRadius: 30,
                      spreadRadius: 10,
                    ),
                  ],
                ),
              ),

            // Pet sprite with frame animation
            AnimatedBuilder(
              animation: _blinkController,
              builder: (context, child) {
                return Transform.scale(
                  scale: 1.0 + (_blinkController.value * 0.05),
                  child: child,
                );
              },
              child: SizedBox(
                width: frameWidth,
                height: frameHeight,
                child: Stack(
                  children: [
                    // Показываем только нужный кадр
                    Positioned(
                      left: -frameWidth * spriteIndex,
                      top: 0,
                      width: frameWidth * _frameCount,
                      height: frameHeight,
                      child: Image.asset(
                        'assets/images/cat.png',
                        width: frameWidth * _frameCount,
                        height: frameHeight,
                        filterQuality:
                            FilterQuality.none, // 🔥 Pixel art без размытия!
                        fit: BoxFit.fill,
                        errorBuilder: (context, error, stackTrace) {
                          // Fallback на эмодзи если картинка не загрузится
                          return SizedBox(
                            width: frameWidth,
                            height: frameHeight,
                            child: Center(
                              child: Text(
                                _getEmojiForEmotion(widget.emotion),
                                style: TextStyle(fontSize: widget.size * 0.8),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Shiny sparkle badge
            if (widget.isShiny)
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.amber.withOpacity(0.5),
                        blurRadius: 8,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: const Text('✨', style: TextStyle(fontSize: 16)),
                ),
              ),
          ],
        );
      },
    );
  }

  String _getEmojiForEmotion(String emotion) {
    switch (emotion) {
      case 'happy':
        return '😊';
      case 'sad':
        return '😢';
      case 'sleepy':
        return '😴';
      case 'excited':
        return '🤩';
      case 'loving':
        return '😍';
      case 'celebrating':
        return '🥳';
      case 'thinking':
        return '🤔';
      case 'cool':
        return '😎';
      default:
        return '😊';
    }
  }
}
