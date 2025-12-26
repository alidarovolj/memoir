import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:ionicons/ionicons.dart';
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
  bool _canResend = false;
  int _resendCountdown = 60;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _initSmsAuthService();
    _startResendTimer();
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

  void _startResendTimer() {
    _resendCountdown = 60;
    _canResend = false;

    _timer?.cancel(); // Cancel any existing timer
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }

      if (_resendCountdown > 0) {
        _resendCountdown--;
      } else {
        _canResend = true;
        timer.cancel();
      }

      if (mounted) {
        setState(() {});
      }
    });
  }

  Future<void> _verifyCode(String code) async {
    if (code.length != 6) return;

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
        code: code,
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

        // Clear controller only if not disposed
        if (_codeController.hasListeners) {
          _codeController.clear();
        }

        SnackBarUtils.showError(context, errorMessage);
      }
    }
  }

  Future<void> _resendCode() async {
    if (!_canResend || _smsAuthService == null) return;

    developer.log('🔄 [PHONE_VERIFY] Resending code to: ${widget.phoneNumber}');

    try {
      await _smsAuthService!.resendCode(phoneNumber: widget.phoneNumber);

      developer.log('✅ [PHONE_VERIFY] Code resent');

      if (mounted) {
        SnackBarUtils.showSuccess(context, 'Код отправлен повторно');
        _startResendTimer();
      }
    } catch (e) {
      developer.log('❌ [PHONE_VERIFY] Resend error: $e');

      if (mounted) {
        SnackBarUtils.showError(context, 'Не удалось отправить код');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.pageBackgroundColor,
      body: Column(
        children: [
          // Custom Header
          Container(
            color: AppTheme.headerBackgroundColor,
            child: SafeArea(
              bottom: false,
              child: Container(
                height: 64,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Stack(
                  children: [
                    // Заголовок
                    const Center(
                      child: Text(
                        'Подтверждение',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    // Кнопка назад
                    Positioned(
                      left: 0,
                      top: 0,
                      bottom: 0,
                      child: Center(
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () => Navigator.of(context).pop(),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            child: const Icon(
                              Ionicons.chevron_back,
                              color: AppTheme.primaryColor,
                              size: 24,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 32),

                  // Title
                  const Text(
                    'Введите код',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 16),

                  // Subtitle
                  Text(
                    'Мы отправили SMS с кодом на номер',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withOpacity(0.6),
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 8),

                  // Phone Number
                  Text(
                    widget.phoneNumber,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryColor,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 48),

                  // PIN Code Input
                  PinCodeTextField(
                    key: _pinCodeKey,
                    appContext: context,
                    length: 6,
                    controller: _codeController,
                    animationType: AnimationType.fade,
                    keyboardType: TextInputType.number,
                    autoFocus: true,
                    enabled: !_isLoading,
                    cursorColor: Colors.white,
                    textStyle: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(12),
                      fieldHeight: 60,
                      fieldWidth: 50,
                      activeFillColor: AppTheme.cardColor,
                      inactiveFillColor: AppTheme.surfaceColor,
                      selectedFillColor: AppTheme.cardColor,
                      activeColor: AppTheme.primaryColor,
                      inactiveColor: Colors.white.withOpacity(0.1),
                      selectedColor: AppTheme.primaryColor,
                      borderWidth: 1.5,
                    ),
                    animationDuration: const Duration(milliseconds: 200),
                    backgroundColor: Colors.transparent,
                    enableActiveFill: true,
                    onCompleted: (code) {
                      _verifyCode(code);
                    },
                    onChanged: (value) {},
                  ),

                  const SizedBox(height: 32),

                  // Loading Indicator
                  if (_isLoading)
                    const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppTheme.primaryColor,
                        ),
                      ),
                    ),

                  const Spacer(),

                  // Resend Code Button
                  Center(
                    child: TextButton(
                      onPressed: _canResend ? _resendCode : null,
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                      ),
                      child: Text(
                        _canResend
                            ? 'Отправить код повторно'
                            : 'Отправить повторно через $_resendCountdown сек',
                        style: TextStyle(
                          fontSize: 14,
                          color: _canResend
                              ? AppTheme.primaryColor
                              : Colors.white.withOpacity(0.4),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
