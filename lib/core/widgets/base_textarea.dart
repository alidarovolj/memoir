import 'package:flutter/material.dart';
import 'package:memoir/core/theme/app_theme.dart';

class BaseTextarea extends StatelessWidget {
  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final IconData? icon;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final int minLines;
  final int maxLines;
  final bool enabled;
  final int? maxLength;
  final TextCapitalization textCapitalization;
  final FocusNode? focusNode;
  final String? initialValue;
  final bool readOnly;
  final void Function()? onTap;

  const BaseTextarea({
    super.key,
    this.controller,
    this.label,
    this.hint,
    this.icon,
    this.validator,
    this.onChanged,
    this.minLines = 3,
    this.maxLines = 5,
    this.enabled = true,
    this.maxLength,
    this.textCapitalization = TextCapitalization.sentences,
    this.focusNode,
    this.initialValue,
    this.readOnly = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
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
        minLines: minLines,
        maxLines: maxLines,
        enabled: enabled,
        maxLength: maxLength,
        textCapitalization: textCapitalization,
        focusNode: focusNode,
        readOnly: readOnly,
        onTap: onTap,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          prefixIcon: icon != null
              ? Padding(
                  padding: EdgeInsets.only(
                    bottom: (minLines * 8).toDouble(),
                  ),
                  child: Icon(icon, color: AppTheme.primaryColor, size: 20),
                )
              : null,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
          filled: false,
          fillColor: Colors.white,
          counterText: '',
          alignLabelWithHint: true,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 10,
          ),
          isDense: true,
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
