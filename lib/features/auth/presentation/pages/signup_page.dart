import 'package:flutter/material.dart';
import 'package:memoir/features/auth/presentation/pages/phone_login_page.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Header Section with purple background
          _buildHeader(context),
          
          // Main Content Section
          Expanded(
            child: _buildContent(context),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    // Получаем высоту статус-бара
    final statusBarHeight = MediaQuery.of(context).padding.top;
    
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFE8D5FF), // Light purple background
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
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
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.arrow_back,
                        color: Color(0xFF202020),
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
              Positioned.fill(
                child: CustomPaint(
                  painter: _HeartsPainter(),
                ),
              ),
              
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
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.purple.withOpacity(0.2),
                            blurRadius: 20,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Text(
                          '🐦',
                          style: TextStyle(fontSize: 60),
                        ),
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
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
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
                      color: Color(0xFF202020),
                    ),
                  ),
                ),
              ),
            ],
          ),
          
          // Curved white line separator
          Container(
            height: 20,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
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
              'Sign up for Me+',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color(0xFF202020),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Description
            Text(
              'Create an account to save your progress and access it on different devices!',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                height: 1.5,
              ),
            ),
            
            const SizedBox(height: 40),
            
            // Continue with Facebook
            _buildSocialButton(
              onPressed: () {
                // TODO: Implement Facebook auth
              },
              backgroundColor: const Color(0xFF1877F2), // Facebook blue
              icon: const Text(
                'f',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              text: 'Continue with Facebook',
              textColor: Colors.white,
            ),
            
            const SizedBox(height: 16),
            
            // Continue with Google
            _buildSocialButton(
              onPressed: () {
                // TODO: Implement Google auth
              },
              backgroundColor: Colors.white,
              borderColor: Colors.black,
              icon: Image.asset(
                'assets/icons/auth/google.png',
                height: 24,
                width: 24,
              ),
              text: 'Continue with Google',
              textColor: Colors.black,
            ),
            
            const SizedBox(height: 16),
            
            // Continue with Apple
            _buildSocialButton(
              onPressed: () {
                // TODO: Implement Apple auth
              },
              backgroundColor: Colors.black,
              icon: Image.asset(
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
            
            const SizedBox(height: 16),
            
            // Continue with Email
            _buildSocialButton(
              onPressed: () {
                // TODO: Navigate to email signup
              },
              backgroundColor: const Color(0xFFD4A5FF), // Light purple/lilac
              icon: const Icon(
                Icons.email_outlined,
                color: Colors.white,
                size: 24,
              ),
              text: 'Continue with Email',
              textColor: Colors.black,
            ),
            
            const SizedBox(height: 32),
            
            // Login link
            Center(
              child: RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                  children: [
                    const TextSpan(text: 'Already have an account? '),
                    WidgetSpan(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PhoneLoginPage(),
                            ),
                          );
                        },
                        child: const Text(
                          'Log in!',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF9B59B6), // Purple
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                  ],
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
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: borderColor != null
                ? BorderSide(color: borderColor, width: 1)
                : BorderSide.none,
          ),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
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
      ..color = const Color(0xFFD4A5FF).withOpacity(0.3)
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
