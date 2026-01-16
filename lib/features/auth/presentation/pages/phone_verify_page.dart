import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:memoir/core/theme/app_theme.dart';
import 'package:memoir/core/utils/snackbar_utils.dart';
import 'package:memoir/core/services/sms_auth_service.dart';
import 'package:memoir/core/services/notification_service.dart';
import 'package:memoir/core/network/dio_client.dart';
import 'package:memoir/features/auth/presentation/pages/profile_setup_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:developer' as developer;

class PhoneVerifyPage extends StatefulWidget {
  final String phoneNumber;
  final int expiresIn;

  const PhoneVerifyPage({
    super.key,
    required this.phoneNumber,
    this.expiresIn = 300, // 5 minutes default
  });

  @override
  State<PhoneVerifyPage> createState() => _PhoneVerifyPageState();
}

class _PhoneVerifyPageState extends State<PhoneVerifyPage> {
  final _codeController = TextEditingController();
  final _pinCodeKey = GlobalKey<FormFieldState>();
  SmsAuthService? _smsAuthService;

  bool _isLoading = false;
  int _remainingSeconds = 140; // 2:20 в секундах
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _initSmsAuthService();
    _startTimer();
  }

  Future<void> _initSmsAuthService() async {
    final dio = DioClient.instance; // Use global instance with auth interceptor
    _smsAuthService = SmsAuthService(dio);
  }

  @override
  void dispose() {
    _timer?.cancel();
    _timer = null;
    // Dispose controller only if it hasn't been disposed yet
    if (mounted) {
      _codeController.dispose();
    }
    super.dispose();
  }

  void _startTimer() {
    _remainingSeconds = widget.expiresIn;

    _timer?.cancel(); // Cancel any existing timer
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }

      if (_remainingSeconds > 0) {
        _remainingSeconds--;
      } else {
        timer.cancel();
      }

      if (mounted) {
        setState(() {});
      }
    });
  }

  String _formatTimer(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  Future<void> _verifyCode(String code) async {
    // Бэкенд ожидает 6-значный код, но на дизайне 5 полей
    // Если введено 5 символов, добавляем ведущий ноль
    String finalCode = code;
    if (code.length == 5) {
      finalCode = '0$code'; // Добавляем ведущий ноль для 6-значного кода
    }
    if (finalCode.length != 6) return;

    if (_smsAuthService == null) {
      SnackBarUtils.showError(context, 'Сервис инициализируется...');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    developer.log('🔍 [PHONE_VERIFY] Verifying code: $code');

    try {
      // Verify code with backend
      final response = await _smsAuthService!.verifyCode(
        phoneNumber: widget.phoneNumber,
        code: finalCode,
      );

      developer.log('✅ [PHONE_VERIFY] Code verified successfully');
      developer.log('👤 [PHONE_VERIFY] User: ${response['user']}');

      // Save tokens and user data
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('auth_token', response['access_token']);
      await prefs.setString('user_id', response['user']['id']);
      await prefs.setString('user_phone', response['user']['phone_number']);
      if (response['user']['username'] != null) {
        await prefs.setString('username', response['user']['username']);
      }
      if (response['user']['email'] != null) {
        await prefs.setString('email', response['user']['email']);
      }

      // Send FCM token to backend after successful login
      try {
        final notificationService = NotificationService();
        await notificationService.sendTokenToBackend();
      } catch (e) {
        developer.log('⚠️ [PHONE_VERIFY] Failed to send FCM token: $e');
      }

      if (!mounted) return;

      // Проверяем, заполнен ли профиль (только имя и фамилия)
      final hasFirstName =
          response['user']['first_name'] != null &&
          response['user']['first_name'].toString().isNotEmpty;
      final hasLastName =
          response['user']['last_name'] != null &&
          response['user']['last_name'].toString().isNotEmpty;

      // Если профиль не заполнен, перенаправляем на страницу настройки профиля
      if (!hasFirstName || !hasLastName) {
        developer.log(
          '👤 [PHONE_VERIFY] Profile incomplete, redirecting to setup',
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ProfileSetupPage()),
        );
      } else {
        // Профиль заполнен, переходим на домашнюю страницу
        developer.log('✅ [PHONE_VERIFY] Profile complete, going to home');
        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
      }
    } catch (e) {
      developer.log('❌ [PHONE_VERIFY] Error: $e');

      if (mounted) {
        String errorMessage = 'Неверный код подтверждения';

        // Parse error from DioException
        final errorStr = e.toString();
        if (errorStr.contains('429')) {
          errorMessage = 'Превышено количество попыток. Запросите новый код';
        } else if (errorStr.contains('401')) {
          // Extract remaining attempts if available
          errorMessage = 'Неверный код. Попробуйте снова';
        }

        setState(() {
          _isLoading = false;
        });

        // Clear controller
        _codeController.clear();

        SnackBarUtils.showError(context, errorMessage);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Оранжево-красный цвет для таймера
    const timerColor = Color(0xFFFF6B35);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header with back button
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: const Icon(
                      Icons.arrow_back,
                      color: Color(0xFF202020),
                      size: 24,
                    ),
                  ),
                ],
              ),
            ),

            // Content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 32),

                    // Title
                    const Text(
                      'Verification',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF202020),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Subtitle
                    const Text(
                      'An authentication code has been send your email',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF202020),
                      ),
                    ),

                    const SizedBox(height: 48),

                    // PIN Code Input with Timer
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // PIN Code Input
                        Expanded(
                          child: PinCodeTextField(
                            key: _pinCodeKey,
                            appContext: context,
                            length: 5,
                            controller: _codeController,
                            animationType: AnimationType.fade,
                            keyboardType: TextInputType.number,
                            autoFocus: true,
                            enabled: !_isLoading,
                            cursorColor: const Color(0xFF202020),
                            textStyle: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF202020),
                            ),
                            pinTheme: PinTheme(
                              shape: PinCodeFieldShape.box,
                              borderRadius: BorderRadius.circular(8),
                              fieldHeight: 56,
                              fieldWidth: 56,
                              activeFillColor: Colors.white,
                              inactiveFillColor: Colors.white,
                              selectedFillColor: Colors.white,
                              activeColor: const Color(0xFFE0E0E0),
                              inactiveColor: const Color(0xFFE0E0E0),
                              selectedColor: const Color(0xFFE0E0E0),
                              borderWidth: 1,
                            ),
                            animationDuration: const Duration(milliseconds: 200),
                            backgroundColor: Colors.transparent,
                            enableActiveFill: true,
                            onCompleted: (code) {
                              _verifyCode(code);
                            },
                            onChanged: (value) {},
                          ),
                        ),

                        const SizedBox(width: 16),

                        // Timer
                        Text(
                          _formatTimer(_remainingSeconds),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: timerColor,
                          ),
                        ),
                      ],
                    ),

                    const Spacer(),

                    // Verify Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : () {
                          if (_codeController.text.length == 5) {
                            _verifyCode(_codeController.text);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.greenButtonColor,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                          disabledBackgroundColor: AppTheme.greenButtonColor.withOpacity(0.5),
                        ),
                        child: _isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white,
                                  ),
                                ),
                              )
                            : const Text(
                                'Verify',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ),

                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
