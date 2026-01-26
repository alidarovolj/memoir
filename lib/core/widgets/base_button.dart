import 'package:flutter/material.dart';
import 'package:memoir/core/theme/app_theme.dart';

class BaseButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final IconData? icon;
  final Widget? leadingIcon;
  final bool isLoading;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final bool isFullWidth;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;
  final double? fontSize;
  final FontWeight? fontWeight;

  const BaseButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.icon,
    this.leadingIcon,
    this.isLoading = false,
    this.backgroundColor,
    this.foregroundColor,
    this.isFullWidth = true,
    this.width,
    this.padding,
    this.borderRadius = 12,
    this.fontSize,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    final button = ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? AppTheme.primaryColor,
        foregroundColor: foregroundColor ?? AppTheme.whiteColor,
        disabledBackgroundColor: (backgroundColor ?? AppTheme.primaryColor)
            .withOpacity(0.6),
        padding: padding ??
            const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 16,
            ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        elevation: 0,
      ),
      child: isLoading
          ? SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(
                  foregroundColor ?? AppTheme.whiteColor,
                ),
              ),
            )
          : (icon != null || leadingIcon != null)
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    leadingIcon ??
                        Icon(
                          icon,
                          size: 20,
                        ),
                    const SizedBox(width: 8),
                    Text(
                      text,
                      style: TextStyle(
                        fontSize: fontSize ?? 16,
                        fontWeight: fontWeight ?? FontWeight.w600,
                      ),
                    ),
                  ],
                )
              : Text(
                  text,
                  style: TextStyle(
                    fontSize: fontSize ?? 16,
                    fontWeight: fontWeight ?? FontWeight.w600,
                  ),
                ),
    );

    if (isFullWidth) {
      return SizedBox(
        width: width ?? double.infinity,
        child: button,
      );
    }

    return button;
  }
}
