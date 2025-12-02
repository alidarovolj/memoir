import 'package:flutter/material.dart';
import 'package:memoir/core/theme/app_theme.dart';

class EmptyState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String? buttonText;
  final VoidCallback? onButtonPressed;
  final IconData? buttonIcon;

  const EmptyState({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.buttonText,
    this.onButtonPressed,
    this.buttonIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Анимированная иконка
            TweenAnimationBuilder<double>(
              duration: const Duration(milliseconds: 1000),
              tween: Tween(begin: 0.0, end: 1.0),
              builder: (context, value, child) {
                return Transform.scale(
                  scale: 0.8 + (value * 0.2),
                  child: Opacity(
                    opacity: value,
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppTheme.primaryColor.withOpacity(0.2),
                            AppTheme.secondaryColor.withOpacity(0.2),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Icon(
                        icon,
                        size: 80,
                        color: Colors.white.withOpacity(0.5),
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 32),
            Text(
              title,
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              subtitle,
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            if (buttonText != null && onButtonPressed != null) ...[
              const SizedBox(height: 40),
              Container(
                decoration: BoxDecoration(
                  gradient: AppTheme.primaryGradient,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.primaryColor.withOpacity(0.4),
                      blurRadius: 24,
                      spreadRadius: 0,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: ElevatedButton.icon(
                  onPressed: onButtonPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 20),
                  ),
                  icon: buttonIcon != null
                      ? Icon(buttonIcon, size: 24)
                      : const SizedBox.shrink(),
                  label: Text(
                    buttonText!,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

