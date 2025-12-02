import 'package:flutter/material.dart';
import 'package:memoir/core/core.dart';
import 'package:memoir/core/services/auth_service.dart';
import 'package:memoir/core/network/dio_client.dart';
import 'package:ionicons/ionicons.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isLoading = true);

    try {
      final authService = AuthService(dio: DioClient.instance);
      await authService.register(
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

  void _goToLogin() {
    Navigator.of(context).pushReplacementNamed('/login');
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
                        'Создать аккаунт',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          letterSpacing: -1,
                        ),
                      ),
                    ),
                    const SizedBox(height: 48),

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
                        hintText: 'Пароль (минимум 6 символов)',
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
                        if (value.length < 6) {
                          return 'Минимум 6 символов';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 32),

                    // Кнопка регистрации
                    SizedBox(
                      width: double.infinity,
                      child: GradientButton(
                        text: 'Зарегистрироваться',
                        icon: Ionicons.person_add_outline,
                        onPressed: _register,
                        isLoading: _isLoading,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Вход
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedGradientButton(
                        text: 'Уже есть аккаунт? Войти',
                        icon: Ionicons.log_in_outline,
                        onPressed: _goToLogin,
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

