import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:memoir/core/theme/app_theme.dart';
import 'package:memoir/core/utils/snackbar_utils.dart';
import 'package:memoir/core/services/sms_auth_service.dart';
import 'package:memoir/core/network/dio_client.dart';
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
    _codeController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _startResendTimer() {
    _resendCountdown = 60;
    _canResend = false;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }

      setState(() {
        if (_resendCountdown > 0) {
          _resendCountdown--;
        } else {
          _canResend = true;
          timer.cancel();
        }
      });
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

      // Save tokens
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('auth_token', response['access_token']);
      await prefs.setString('user_id', response['user']['id']);
      await prefs.setString('user_phone', response['user']['phone_number']);

      setState(() {
        _isLoading = false;
      });

      // Navigate to home
      if (mounted) {
        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);

        SnackBarUtils.showSuccess(context, 'Добро пожаловать!');
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
          _codeController.clear();
        });

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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(gradient: AppTheme.lightBackgroundGradient),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 32),

                // Title
                Text(
                  'Введите код',
                  style: Theme.of(
                    context,
                  ).textTheme.headlineLarge?.copyWith(fontSize: 32),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 16),

                // Subtitle
                Text(
                  'Мы отправили SMS с кодом на номер',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: Colors.grey.shade600),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 8),

                // Phone Number
                Text(
                  widget.phoneNumber,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
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
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(16),
                    fieldHeight: 60,
                    fieldWidth: 50,
                    activeFillColor: Colors.white.withOpacity(0.9),
                    inactiveFillColor: Colors.white.withOpacity(0.5),
                    selectedFillColor: Colors.white.withOpacity(0.9),
                    activeColor: AppTheme.primaryColor,
                    inactiveColor: Colors.grey.shade300,
                    selectedColor: AppTheme.primaryColor,
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
                  const Center(child: CircularProgressIndicator()),

                const Spacer(),

                // Resend Code Button
                Center(
                  child: TextButton(
                    onPressed: _canResend ? _resendCode : null,
                    child: Text(
                      _canResend
                          ? 'Отправить код повторно'
                          : 'Отправить повторно через $_resendCountdown сек',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: _canResend
                            ? AppTheme.primaryColor
                            : Colors.grey.shade600,
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
      ),
    );
  }
}
