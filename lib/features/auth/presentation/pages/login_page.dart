import 'package:flutter/material.dart';
import 'package:memoir/core/core.dart';
import 'package:memoir/core/services/auth_service.dart';
import 'package:memoir/core/services/oauth_service.dart';
import 'package:memoir/core/network/dio_client.dart';
import 'package:ionicons/ionicons.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _isGoogleLoading = false;
  bool _isAppleLoading = false;
  bool _obscurePassword = true;
  bool _isAppleAvailable = false;

  @override
  void initState() {
    super.initState();
    _checkAppleAvailability();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isLoading = true);

    try {
      final authService = AuthService(dio: DioClient.instance);
      await authService.login(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      if (mounted) {
        Navigator.of(context).pushReplacementNamed('/home');
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        final message = ErrorMessages.getAuthErrorMessage(e);
        SnackBarUtils.showError(context, message);
      }
    }
  }

  void _goToRegister() {
    Navigator.of(context).pushReplacementNamed('/register');
  }

  Future<void> _checkAppleAvailability() async {
    final isAvailable = await OAuthService.isAppleSignInAvailable();
    if (mounted) {
      setState(() {
        _isAppleAvailable = isAvailable;
      });
    }
  }

  Future<void> _signInWithGoogle() async {
    setState(() => _isGoogleLoading = true);

    try {
      final result = await OAuthService.signInWithGoogle();

      if (result == null) {
        // Пользователь отменил
        if (mounted) {
          setState(() => _isGoogleLoading = false);
        }
        return;
      }

      // TODO: Отправить result на backend для получения JWT токена
      print('Google auth result: $result');

      if (mounted) {
        SnackBarUtils.showInfo(
          context,
          'Google OAuth: ${result['email']}\nИнтеграция с backend - в разработке',
        );
        setState(() => _isGoogleLoading = false);
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isGoogleLoading = false);
        SnackBarUtils.showError(
          context,
          'Не удалось войти через Google. Попробуйте снова',
        );
      }
    }
  }

  Future<void> _signInWithApple() async {
    setState(() => _isAppleLoading = true);

    try {
      final result = await OAuthService.signInWithApple();

      if (result == null) {
        if (mounted) {
          setState(() => _isAppleLoading = false);
        }
        return;
      }

      // TODO: Отправить result на backend для получения JWT токена
      print('Apple auth result: $result');

      if (mounted) {
        SnackBarUtils.showInfo(
          context,
          'Apple OAuth: ${result['email'] ?? result['user_id']}\nИнтеграция с backend - в разработке',
        );
        setState(() => _isAppleLoading = false);
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isAppleLoading = false);
        SnackBarUtils.showError(
          context,
          'Не удалось войти через Apple. Попробуйте снова',
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppTheme.lightBackgroundGradient,
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Лого
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        gradient: AppTheme.primaryGradient,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.primaryColor.withOpacity(0.4),
                            blurRadius: 30,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Ionicons.sparkles,
                        size: 50,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Заголовок
                    ShaderMask(
                      shaderCallback: (bounds) =>
                          AppTheme.primaryGradient.createShader(bounds),
                      child: const Text(
                        'Memoir',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          letterSpacing: -1,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Personal Memory AI',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 48),

                    // OAuth кнопки
                    SizedBox(
                      width: double.infinity,
                      child: GoogleSignInButton(
                        onPressed: _signInWithGoogle,
                        isLoading: _isGoogleLoading,
                      ),
                    ),
                    if (_isAppleAvailable) ...[
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: AppleSignInButton(
                          onPressed: _signInWithApple,
                          isLoading: _isAppleLoading,
                        ),
                      ),
                    ],
                    const SizedBox(height: 24),

                    // Разделитель
                    const OrDivider(),
                    const SizedBox(height: 24),

                    // Email
                    CustomTextField(
                      controller: _emailController,
                      hintText: 'Email',
                      prefixIcon: Ionicons.mail_outline,
                      keyboardType: TextInputType.emailAddress,
                      enabled: !_isLoading,
                    ),
                    const SizedBox(height: 16),

                    // Password
                    TextFormField(
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      enabled: !_isLoading,
                      style: const TextStyle(color: Colors.black87),
                      decoration: InputDecoration(
                        hintText: 'Пароль',
                        prefixIcon: const Icon(
                          Ionicons.lock_closed_outline,
                          color: AppTheme.primaryColor,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Ionicons.eye_outline
                                : Ionicons.eye_off_outline,
                            color: Colors.black54,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Введите пароль';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 32),

                    // Кнопка входа
                    SizedBox(
                      width: double.infinity,
                      child: GradientButton(
                        text: 'Войти',
                        icon: Ionicons.log_in_outline,
                        onPressed: _login,
                        isLoading: _isLoading,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Регистрация
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedGradientButton(
                        text: 'Создать аккаунт',
                        icon: Ionicons.person_add_outline,
                        onPressed: _goToRegister,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
