import 'package:flutter/material.dart';

class OAuthButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;
  final bool isLoading;

  const OAuthButton({
    super.key,
    required this.text,
    required this.icon,
    required this.onPressed,
    this.backgroundColor = Colors.white,
    this.textColor = Colors.black87,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isLoading ? null : onPressed,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (isLoading)
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: textColor,
                    ),
                  )
                else ...[
                  Icon(icon, color: textColor, size: 24),
                  const SizedBox(width: 12),
                  Text(
                    text,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: textColor,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Google кнопка
class GoogleSignInButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isLoading;

  const GoogleSignInButton({
    super.key,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return OAuthButton(
      text: 'Войти через Google',
      icon: Icons.g_mobiledata_rounded, // или можно использовать custom icon
      onPressed: onPressed,
      backgroundColor: Colors.white,
      textColor: Colors.black87,
      isLoading: isLoading,
    );
  }
}

// Apple кнопка
class AppleSignInButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isLoading;

  const AppleSignInButton({
    super.key,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return OAuthButton(
      text: 'Войти через Apple',
      icon: Icons.apple,
      onPressed: onPressed,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      isLoading: isLoading,
    );
  }
}

// Divider с текстом "или"
class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Colors.transparent,
                  isDark 
                      ? Colors.white.withOpacity(0.3)
                      : Colors.black.withOpacity(0.2),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'или',
            style: TextStyle(
              fontSize: 14,
              color: isDark 
                  ? Colors.white.withOpacity(0.5)
                  : Colors.black54,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  isDark 
                      ? Colors.white.withOpacity(0.3)
                      : Colors.black.withOpacity(0.2),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

