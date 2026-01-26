import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:memoir/core/theme/app_theme.dart';

class BaseInput extends StatelessWidget {
  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final IconData? icon;
  final String? iconPath;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final TextInputType? keyboardType;
  final bool obscureText;
  final bool enabled;
  final int? maxLength;
  final TextCapitalization textCapitalization;
  final FocusNode? focusNode;
  final String? initialValue;
  final bool readOnly;
  final void Function()? onTap;

  const BaseInput({
    super.key,
    this.controller,
    this.label,
    this.hint,
    this.icon,
    this.iconPath,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.keyboardType,
    this.obscureText = false,
    this.enabled = true,
    this.maxLength,
    this.textCapitalization = TextCapitalization.none,
    this.focusNode,
    this.initialValue,
    this.readOnly = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Widget? prefixWidget;

    if (prefixIcon != null) {
      prefixWidget = prefixIcon;
    } else if (iconPath != null) {
      prefixWidget = Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: SizedBox(
          width: 28,
          height: 28,
          child: Image.asset(
            iconPath!,
            width: 28,
            height: 28,
            fit: BoxFit.contain,
            package: null,
            errorBuilder: (context, error, stackTrace) {
              debugPrint('Error loading icon: $iconPath - $error');
              return icon != null
                  ? Icon(
                      icon,
                      color: AppTheme.primaryColor,
                      size: 28,
                    )
                  : Icon(
                      Icons.image_not_supported,
                      color: AppTheme.primaryColor,
                      size: 28,
                    );
            },
          ),
        ),
      );
    } else if (icon != null) {
      prefixWidget = Icon(icon, color: AppTheme.primaryColor, size: 20);
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: AppTheme.darkColor.withOpacity(0.1),
            width: 1,
          ),
        ),
        child: TextFormField(
        controller: controller,
        initialValue: initialValue,
        validator: validator,
        onChanged: onChanged,
        onFieldSubmitted: onSubmitted,
        keyboardType: keyboardType,
        obscureText: obscureText,
        enabled: enabled,
        maxLength: maxLength,
        textCapitalization: textCapitalization,
        focusNode: focusNode,
        readOnly: readOnly,
        onTap: onTap,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          prefixIcon: prefixWidget,
          suffixIcon: suffixIcon,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
          filled: false,
          fillColor: Colors.white,
          counterText: '',
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 10,
          ),
          isDense: true,
          constraints: const BoxConstraints(
            minHeight: 44,
          ),
          hintStyle: const TextStyle(
            color: Color(0xFF8F8F8F),
          ),
          labelStyle: const TextStyle(
            color: Color(0xFF8F8F8F),
          ),
          floatingLabelStyle: const TextStyle(
            color: Color(0xFF8F8F8F),
          ),
        ),
        style: const TextStyle(
          color: Colors.black87,
        ),
        ),
      ),
    );
  }
}
