import 'package:flutter/material.dart';
import 'package:memoir/core/theme/app_theme.dart';
import 'package:ionicons/ionicons.dart';

// Анимированный SnackBar с плавным появлением
class _AnimatedSnackBar extends SnackBar {
  _AnimatedSnackBar({
    required Widget content,
    required Color backgroundColor,
    required Duration duration,
  }) : super(
          content: _SnackBarContent(
            child: content,
            backgroundColor: backgroundColor,
          ),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          backgroundColor: Colors.transparent,
          duration: duration,
          margin: const EdgeInsets.all(16),
          padding: EdgeInsets.zero,
          elevation: 0,
        );
}

// Контент с анимацией появления
class _SnackBarContent extends StatefulWidget {
  final Widget child;
  final Color backgroundColor;

  const _SnackBarContent({
    required this.child,
    required this.backgroundColor,
  });

  @override
  State<_SnackBarContent> createState() => _SnackBarContentState();
}

class _SnackBarContentState extends State<_SnackBarContent>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: widget.backgroundColor,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: widget.backgroundColor.withOpacity(0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: widget.child,
          ),
        ),
      ),
    );
  }
}

// Анимированная иконка
class _AnimatedIconWidget extends StatefulWidget {
  final IconData icon;
  final Color color;
  final Color? iconColor;
  final bool useGradient;
  final bool animateRotation;

  const _AnimatedIconWidget({
    required this.icon,
    required this.color,
    this.iconColor,
    this.useGradient = false,
    this.animateRotation = false,
  });

  @override
  State<_AnimatedIconWidget> createState() => _AnimatedIconWidgetState();
}

class _AnimatedIconWidgetState extends State<_AnimatedIconWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.0, end: 1.2).chain(
          CurveTween(curve: Curves.easeOut),
        ),
        weight: 0.5,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.2, end: 1.0).chain(
          CurveTween(curve: Curves.easeIn),
        ),
        weight: 0.5,
      ),
    ]).animate(_controller);

    if (widget.animateRotation) {
      _rotationAnimation = Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ));
    } else {
      _rotationAnimation = AlwaysStoppedAnimation(0.0);
    }

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Transform.rotate(
            angle: widget.animateRotation
                ? _rotationAnimation.value * 2 * 3.14159
                : 0.0,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: widget.useGradient ? null : widget.iconColor,
                gradient: widget.useGradient ? AppTheme.primaryGradient : null,
                borderRadius: BorderRadius.circular(12),
                boxShadow: widget.useGradient
                    ? [
                        BoxShadow(
                          color: AppTheme.primaryColor.withOpacity(0.3),
                          blurRadius: 8,
                        ),
                      ]
                    : null,
              ),
              child: Icon(
                widget.icon,
                color: widget.color,
                size: 20,
              ),
            ),
          ),
        );
      },
    );
  }
}

// Анимированный текст
class _AnimatedTextWidget extends StatefulWidget {
  final String text;

  const _AnimatedTextWidget({required this.text});

  @override
  State<_AnimatedTextWidget> createState() => _AnimatedTextWidgetState();
}

class _AnimatedTextWidgetState extends State<_AnimatedTextWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.2, 1.0, curve: Curves.easeOut),
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.2, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.2, 1.0, curve: Curves.easeOut),
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Text(
          widget.text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class SnackBarUtils {
  static void showSuccess(BuildContext context, String message) {
    final messenger = ScaffoldMessenger.of(context);
    messenger.hideCurrentSnackBar();
    messenger.showSnackBar(
      _AnimatedSnackBar(
        content: Row(
          children: [
            const _AnimatedIconWidget(
              icon: Ionicons.checkmark_circle,
              color: Colors.white,
              iconColor: Colors.green,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _AnimatedTextWidget(text: message),
            ),
          ],
        ),
        backgroundColor: Colors.green.shade700,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  static void showError(BuildContext context, String message) {
    final messenger = ScaffoldMessenger.of(context);
    messenger.hideCurrentSnackBar();
    messenger.showSnackBar(
      _AnimatedSnackBar(
        content: Row(
          children: [
            const _AnimatedIconWidget(
              icon: Ionicons.close_circle,
              color: Colors.white,
              iconColor: Colors.red,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _AnimatedTextWidget(text: message),
            ),
          ],
        ),
        backgroundColor: Colors.red.shade700,
        duration: const Duration(seconds: 4),
      ),
    );
  }

  static void showWarning(BuildContext context, String message) {
    final messenger = ScaffoldMessenger.of(context);
    messenger.hideCurrentSnackBar();
    messenger.showSnackBar(
      _AnimatedSnackBar(
        content: Row(
          children: [
            const _AnimatedIconWidget(
              icon: Ionicons.warning,
              color: Colors.white,
              iconColor: Colors.orange,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _AnimatedTextWidget(text: message),
            ),
          ],
        ),
        backgroundColor: Colors.orange,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  static void showInfo(BuildContext context, String message) {
    final messenger = ScaffoldMessenger.of(context);
    messenger.hideCurrentSnackBar();
    messenger.showSnackBar(
      _AnimatedSnackBar(
        content: Row(
          children: [
            const _AnimatedIconWidget(
              icon: Ionicons.information_circle,
              color: Colors.white,
              useGradient: true,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _AnimatedTextWidget(text: message),
            ),
          ],
        ),
        backgroundColor: AppTheme.primaryColor,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  static void showAIProcessing(BuildContext context, String message) {
    final messenger = ScaffoldMessenger.of(context);
    messenger.hideCurrentSnackBar();
    messenger.showSnackBar(
      _AnimatedSnackBar(
        content: Row(
          children: [
            const _AnimatedIconWidget(
              icon: Ionicons.sparkles,
              color: Colors.white,
              useGradient: true,
              animateRotation: true,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _AnimatedTextWidget(text: message),
            ),
          ],
        ),
        backgroundColor: Colors.green.shade700,
        duration: const Duration(seconds: 4),
      ),
    );
  }
}
