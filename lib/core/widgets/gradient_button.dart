import 'package:flutter/material.dart';
import 'package:memoir/core/theme/app_theme.dart';

class GradientButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final IconData? icon;
  final Gradient? gradient;
  final EdgeInsets? padding;
  final bool isLoading;

  const GradientButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.icon,
    this.gradient,
    this.padding,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: gradient ?? AppTheme.primaryGradient,
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
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: padding ?? const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : icon != null
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(icon, size: 24),
                      const SizedBox(width: 8),
                      Text(
                        text,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  )
                : Text(
                    text,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
      ),
    );
  }
}

class OutlinedGradientButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final IconData? icon;
  final Gradient? gradient;

  const OutlinedGradientButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.icon,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: gradient ?? AppTheme.primaryGradient,
      ),
      child: Container(
        margin: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: isDark ? AppTheme.backgroundColor : Colors.white,
          borderRadius: BorderRadius.circular(18),
        ),
        child: TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
          ),
          child: icon != null
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ShaderMask(
                      shaderCallback: (bounds) =>
                          (gradient ?? AppTheme.primaryGradient)
                              .createShader(bounds),
                      child: Icon(icon, color: Colors.white),
                    ),
                    const SizedBox(width: 8),
                    ShaderMask(
                      shaderCallback: (bounds) =>
                          (gradient ?? AppTheme.primaryGradient)
                              .createShader(bounds),
                      child: Text(
                        text,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                )
              : ShaderMask(
                  shaderCallback: (bounds) =>
                      (gradient ?? AppTheme.primaryGradient)
                          .createShader(bounds),
                  child: Text(
                    text,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}

