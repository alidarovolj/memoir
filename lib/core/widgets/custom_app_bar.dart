import 'package:flutter/material.dart';
import 'package:memoir/core/theme/app_theme.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final Widget? leading;
  final bool centerTitle;
  final bool useGradient;

  const CustomAppBar({
    super.key,
    required this.title,
    this.actions,
    this.leading,
    this.centerTitle = true,
    this.useGradient = true,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return AppBar(
      backgroundColor: isDark ? Colors.transparent : Colors.white.withOpacity(0.9),
      leading: leading,
      centerTitle: centerTitle,
      title: useGradient
          ? ShaderMask(
              shaderCallback: (bounds) =>
                  AppTheme.primaryGradient.createShader(bounds),
              child: const Text(
                'Memoir',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            )
          : Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold, 
                fontSize: 24,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
      actions: actions,
      iconTheme: IconThemeData(
        color: isDark ? Colors.white : Colors.black87,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
