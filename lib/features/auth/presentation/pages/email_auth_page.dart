import 'package:flutter/material.dart';
import 'package:memoir/core/theme/app_theme.dart';
import 'package:memoir/core/network/dio_client.dart';
import 'package:memoir/core/utils/snackbar_utils.dart';
import 'package:memoir/core/widgets/base_input.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'dart:async';

class EmailAuthPage extends StatefulWidget {
  const EmailAuthPage({super.key});

  @override
  State<EmailAuthPage> createState() => _EmailAuthPageState();
}

class _EmailAuthPageState extends State<EmailAuthPage> {
  final _emailController = TextEditingController();
  final _codeController = TextEditingController();
  bool _isLoading = false;
  bool _codeSent = false;
  int _resendCountdown = 0;
  Timer? _countdownTimer;

  @override
  void dispose() {
    _emailController.dispose();
    _codeController.dispose();
    _countdownTimer?.cancel();
    super.dispose();
  }

  void _startResendCountdown() {
    setState(() => _resendCountdown = 60);
    _countdownTimer?.cancel();
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendCountdown > 0) {
        setState(() => _resendCountdown--);
      } else {
        timer.cancel();
      }
    });
  }

  Future<void> _sendCode() async {
    final email = _emailController.text.trim();
    if (email.isEmpty || !email.contains('@')) {
      SnackBarUtils.showError(context, 'Please enter a valid email');
      return;
    }

    setState(() => _isLoading = true);

    try {
      final dio = DioClient.instance;
      await dio.post(
        '/api/v1/email-auth/send-code',
        data: {'email': email},
      );

      if (mounted) {
        setState(() {
          _codeSent = true;
          _isLoading = false;
        });
        _startResendCountdown();
        SnackBarUtils.showSuccess(
          context,
          'Verification code sent to $email',
        );
      }
    } on DioException catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        SnackBarUtils.showError(
          context,
          e.response?.data['detail'] ?? 'Failed to send code',
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        SnackBarUtils.showError(context, 'Failed to send code');
      }
    }
  }

  Future<void> _resendCode() async {
    setState(() => _isLoading = true);

    try {
      final dio = DioClient.instance;
      await dio.post(
        '/api/v1/email-auth/resend-code',
        data: {'email': _emailController.text.trim()},
      );

      if (mounted) {
        setState(() => _isLoading = false);
        _startResendCountdown();
        SnackBarUtils.showSuccess(context, 'Code resent!');
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        SnackBarUtils.showError(context, 'Failed to resend code');
      }
    }
  }

  Future<void> _verifyCode() async {
    final code = _codeController.text.trim();
    if (code.length != 6) {
      SnackBarUtils.showError(context, 'Please enter a 6-digit code');
      return;
    }

    setState(() => _isLoading = true);

    try {
      final dio = DioClient.instance;
      final response = await dio.post(
        '/api/v1/email-auth/verify-code',
        data: {
          'email': _emailController.text.trim(),
          'code': code,
        },
      );

      // Получаем данные пользователя
      final user = response.data['user'];
      
      // Сохраняем токены (используем ключи из AuthService)
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('auth_token', response.data['access_token']);
      await prefs.setString('refresh_token', response.data['refresh_token']);
      await prefs.setString('user_id', user['id']);
      
      print('💾 [EMAIL_AUTH] Tokens saved:');
      print('  - auth_token: ${response.data['access_token'].substring(0, 20)}...');
      print('  - user_id: ${user['id']}');

      if (mounted) {
        // Проверяем заполненность профиля
        final hasFirstName =
            user['first_name'] != null && user['first_name'].toString().isNotEmpty;
        final hasLastName =
            user['last_name'] != null && user['last_name'].toString().isNotEmpty;

        if (!hasFirstName || !hasLastName) {
          // Профиль не заполнен
          Navigator.of(context).pushNamedAndRemoveUntil(
            '/profile-setup',
            (route) => false,
          );
        } else {
          // Профиль заполнен
          Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
        }
      }
    } on DioException catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        SnackBarUtils.showError(
          context,
          e.response?.data['detail'] ?? 'Invalid verification code',
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        SnackBarUtils.showError(context, 'Verification failed');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.pageBackgroundColor,
      body: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: Transform.translate(
              offset: const Offset(0, -20), // Смещаем вверх, чтобы перекрыть зеленый блок
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
    final statusBarHeight = MediaQuery.of(context).padding.top;

    return Container(
      decoration: const BoxDecoration(
        gradient: AppTheme.primaryGradient,
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              top: statusBarHeight + 12,
              bottom: 12,
            ),
            child: Row(
              children: [
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
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: Container(
              width: 80,
              height: 80,
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
                child: Icon(
                  Icons.email_outlined,
                  size: 40,
                  color: AppTheme.accentColor,
                ),
              ),
            ),
          ),
          Container(
            height: 20,
            decoration: const BoxDecoration(
              color: AppTheme.whiteColor,
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
            Text(
              _codeSent ? 'Enter Code' : 'Sign In',
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: AppTheme.darkColor,
              ),
            ),

            const SizedBox(height: 8),

            // Subtitle
            Text(
              _codeSent
                  ? 'Enter the 6-digit code sent to ${_emailController.text}'
                  : 'Enter your email to receive a verification code',
              style: TextStyle(
                fontSize: 14,
                color: AppTheme.darkColor.withOpacity(0.6),
                height: 1.5,
              ),
            ),

            const SizedBox(height: 40),

            // Email field (always shown)
            BaseInput(
              controller: _emailController,
              label: 'Email',
              hint: 'Enter your email',
              icon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
              enabled: !_codeSent,
            ),

            if (_codeSent) ...[
              const SizedBox(height: 16),

              // Code field
              BaseInput(
                controller: _codeController,
                label: 'Verification Code',
                hint: 'Enter 6-digit code',
                icon: Icons.lock_outline,
                keyboardType: TextInputType.number,
                maxLength: 6,
              ),

              const SizedBox(height: 16),

              // Resend code button
              Center(
                child: TextButton(
                  onPressed: _resendCountdown > 0 || _isLoading ? null : _resendCode,
                  child: Text(
                    _resendCountdown > 0
                        ? 'Resend code in ${_resendCountdown}s'
                        : 'Resend code',
                    style: TextStyle(
                      fontSize: 14,
                      color: _resendCountdown > 0
                          ? AppTheme.darkColor.withOpacity(0.4)
                          : AppTheme.secondaryColor,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 8),

              // Change email button
              Center(
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      _codeSent = false;
                      _codeController.clear();
                      _countdownTimer?.cancel();
                      _resendCountdown = 0;
                    });
                  },
                  child: Text(
                    'Change email',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppTheme.darkColor.withOpacity(0.6),
                    ),
                  ),
                ),
              ),
            ],

            const SizedBox(height: 24),

            // Main action button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _isLoading
                    ? null
                    : (_codeSent ? _verifyCode : _sendCode),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryColor,
                  foregroundColor: AppTheme.whiteColor,
                  minimumSize: const Size(double.infinity, 56),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                  elevation: 0,
                ),
                child: _isLoading
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          color: AppTheme.whiteColor,
                          strokeWidth: 2,
                        ),
                      )
                    : Text(
                        _codeSent ? 'Verify Code' : 'Send Code',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
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
}
