import 'package:flutter/material.dart';
import 'package:memoir/core/theme/app_theme.dart';
import 'package:memoir/core/utils/snackbar_utils.dart';
import 'package:memoir/features/auth/presentation/pages/email_auth_page.dart';
import 'package:memoir/features/auth/data/services/google_auth_service.dart';
import 'package:memoir/features/auth/data/services/apple_auth_service.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _googleAuthService = GoogleAuthService();
  final _appleAuthService = AppleAuthService();
  bool _isGoogleLoading = false;
  bool _isAppleLoading = false;
  bool _isAppleAvailable = false;

  @override
  void initState() {
    super.initState();
    _checkAppleSignInAvailability();
  }

  Future<void> _checkAppleSignInAvailability() async {
    final available = await AppleAuthService.isAvailable();
    if (mounted) {
      setState(() => _isAppleAvailable = available);
    }
  }

  Future<void> _signInWithGoogle() async {
    setState(() => _isGoogleLoading = true);

    try {
      final result = await _googleAuthService.signInWithGoogle();

      if (mounted) {
        setState(() => _isGoogleLoading = false);

        final user = result['user'];

        // Проверяем, заполнены ли обязательные поля профиля
        final hasFirstName =
            user['first_name'] != null &&
            user['first_name'].toString().isNotEmpty;
        final hasLastName =
            user['last_name'] != null &&
            user['last_name'].toString().isNotEmpty;

        if (!hasFirstName || !hasLastName) {
          // Данные не заполнены - отправляем на настройку профиля
          Navigator.of(
            context,
          ).pushNamedAndRemoveUntil('/profile-setup', (route) => false);
        } else {
          // Все данные есть - сразу на главную
          Navigator.of(
            context,
          ).pushNamedAndRemoveUntil('/home', (route) => false);
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isGoogleLoading = false);
        SnackBarUtils.showError(
          context,
          e.toString().replaceAll('Exception: ', ''),
        );
      }
    }
  }

  Future<void> _signInWithApple() async {
    setState(() => _isAppleLoading = true);

    try {
      final result = await _appleAuthService.signInWithApple();

      if (mounted) {
        setState(() => _isAppleLoading = false);

        final user = result['user'];

        // Проверяем, заполнены ли обязательные поля профиля
        final hasFirstName =
            user['first_name'] != null &&
            user['first_name'].toString().isNotEmpty;
        final hasLastName =
            user['last_name'] != null &&
            user['last_name'].toString().isNotEmpty;

        if (!hasFirstName || !hasLastName) {
          // Данные не заполнены - отправляем на настройку профиля
          Navigator.of(
            context,
          ).pushNamedAndRemoveUntil('/profile-setup', (route) => false);
        } else {
          // Все данные есть - сразу на главную
          Navigator.of(
            context,
          ).pushNamedAndRemoveUntil('/home', (route) => false);
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isAppleLoading = false);
        SnackBarUtils.showError(
          context,
          e.toString().replaceAll('Exception: ', ''),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.whiteColor,
      body: Column(
        children: [
          // Header Section with green background
          _buildHeader(context),

          // Main Content Section - перекрывает зеленый блок
          Expanded(
            child: Transform.translate(
              offset: const Offset(
                0,
                -20,
              ), // Смещаем вверх, чтобы перекрыть зеленый блок
              child: Container(
                decoration: const BoxDecoration(
                  color: AppTheme.whiteColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: _buildContent(context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    // Получаем высоту статус-бара
    final statusBarHeight = MediaQuery.of(context).padding.top;

    return Container(
      decoration: const BoxDecoration(gradient: AppTheme.primaryGradient),
      child: Column(
        children: [
          // Status bar spacer and navigation
          Padding(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              top: statusBarHeight + 12,
              bottom: 12,
            ),
            child: Row(
              children: [
                // Показываем кнопку назад только если можно вернуться
                if (Navigator.of(context).canPop())
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppTheme.whiteColor,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.darkColor.withOpacity(0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.arrow_back,
                        color: AppTheme.darkColor,
                        size: 24,
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // Illustration area with hearts
          Stack(
            children: [
              // Hearts decoration
              Positioned.fill(child: CustomPaint(painter: _HeartsPainter())),

              // Bird illustration placeholder (можно заменить на реальную иллюстрацию)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: AppTheme.whiteColor,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.accentColor.withOpacity(0.3),
                            blurRadius: 20,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Text('🐦', style: TextStyle(fontSize: 60)),
                      ),
                    ),
                    const SizedBox(width: 20),
                  ],
                ),
              ),

              // Speech bubble
              Positioned(
                right: 40,
                top: 40,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: AppTheme.whiteColor,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.darkColor.withOpacity(0.1),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: const Text(
                    'Join us',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.darkColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 32),

            // Title
            const Text(
              'Sign up for Memoir',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: AppTheme.darkColor,
              ),
            ),

            const SizedBox(height: 16),

            // Description
            Text(
              'Create an account to save your progress and access it on different devices!',
              style: TextStyle(
                fontSize: 14,
                color: AppTheme.darkColor.withOpacity(0.6),
                height: 1.5,
              ),
            ),

            const SizedBox(height: 40),

            // Continue with Google
            _buildSocialButton(
              onPressed: (_isGoogleLoading || _isAppleLoading)
                  ? () {}
                  : _signInWithGoogle,
              backgroundColor: AppTheme.whiteColor,
              borderColor: AppTheme.darkColor,
              icon: _isGoogleLoading
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppTheme.darkColor,
                        ),
                      ),
                    )
                  : Image.asset(
                      'assets/icons/auth/google.png',
                      height: 24,
                      width: 24,
                    ),
              text: 'Continue with Google',
              textColor: AppTheme.darkColor,
            ),

            const SizedBox(height: 16),

            // Continue with Apple
            if (_isAppleAvailable)
              _buildSocialButton(
                onPressed: (_isGoogleLoading || _isAppleLoading)
                    ? () {}
                    : _signInWithApple,
                backgroundColor: AppTheme.darkColor,
                icon: _isAppleLoading
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                        ),
                      )
                    : Image.asset(
                        'assets/icons/auth/apple.png',
                        height: 24,
                        width: 24,
                        color: Colors.white,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.apple,
                            color: Colors.white,
                            size: 24,
                          );
                        },
                      ),
                text: 'Continue with Apple',
                textColor: Colors.white,
              ),

            if (_isAppleAvailable) const SizedBox(height: 16),

            // Continue with Email
            _buildSocialButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const EmailAuthPage(),
                  ),
                );
              },
              backgroundColor: AppTheme.primaryColor,
              icon: const Icon(
                Icons.email_outlined,
                color: AppTheme.whiteColor,
                size: 24,
              ),
              text: 'Continue with Email',
              textColor: AppTheme.whiteColor,
            ),

            const SizedBox(height: 24),

            // Terms and Privacy Policy
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'By continuing, you agree to our Terms of Service and Privacy Policy',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: AppTheme.darkColor.withOpacity(0.5),
                    height: 1.4,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialButton({
    required VoidCallback onPressed,
    required Color backgroundColor,
    required Widget icon,
    required String text,
    required Color textColor,
    Color? borderColor,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 56, // Фиксированная высота для всех кнопок
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          minimumSize: const Size(double.infinity, 56),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28), // Полный border-radius
            side: borderColor != null
                ? BorderSide(color: borderColor, width: 1)
                : BorderSide.none,
          ),
          elevation: 0,
        ),
        child: Row(
          children: [
            // Иконка слева
            Padding(padding: const EdgeInsets.only(left: 20), child: icon),
            // Текст строго по центру
            Expanded(
              child: Center(
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: textColor,
                  ),
                ),
              ),
            ),
            // Невидимый элемент справа для баланса
            const SizedBox(width: 44), // Ширина иконки (24) + отступ (20)
          ],
        ),
      ),
    );
  }
}

// Custom painter for hearts decoration
class _HeartsPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppTheme.whiteColor.withOpacity(0.2)
      ..style = PaintingStyle.fill;

    // Draw multiple hearts
    final hearts = [
      Offset(size.width * 0.2, size.height * 0.3),
      Offset(size.width * 0.1, size.height * 0.5),
      Offset(size.width * 0.3, size.height * 0.6),
      Offset(size.width * 0.15, size.height * 0.7),
    ];

    for (final heart in hearts) {
      _drawHeart(canvas, heart, 20, paint);
    }
  }

  void _drawHeart(Canvas canvas, Offset center, double size, Paint paint) {
    final path = Path();
    path.moveTo(center.dx, center.dy + size * 0.3);
    path.cubicTo(
      center.dx - size * 0.5,
      center.dy - size * 0.2,
      center.dx - size,
      center.dy - size * 0.5,
      center.dx,
      center.dy - size,
    );
    path.cubicTo(
      center.dx + size,
      center.dy - size * 0.5,
      center.dx + size * 0.5,
      center.dy - size * 0.2,
      center.dx,
      center.dy + size * 0.3,
    );
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
