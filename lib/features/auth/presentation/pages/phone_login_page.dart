import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:memoir/core/theme/app_theme.dart';
import 'package:memoir/core/widgets/widgets.dart';
import 'package:memoir/core/utils/snackbar_utils.dart';
import 'package:memoir/core/services/sms_auth_service.dart';
import 'package:memoir/core/network/dio_client.dart';
import 'package:memoir/features/auth/presentation/pages/phone_verify_page.dart';
import 'dart:developer' as developer;

class PhoneLoginPage extends StatefulWidget {
  const PhoneLoginPage({super.key});

  @override
  State<PhoneLoginPage> createState() => _PhoneLoginPageState();
}

class _PhoneLoginPageState extends State<PhoneLoginPage> {
  final _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;
  String? _fullPhoneNumber;
  SmsAuthService? _smsAuthService;

  @override
  void initState() {
    super.initState();
    _initSmsAuthService();
  }

  Future<void> _initSmsAuthService() async {
    final dio = DioClient.instance; // Use global instance with auth interceptor
    _smsAuthService = SmsAuthService(dio);
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _sendCode() async {
    if (!_formKey.currentState!.validate()) return;

    if (_fullPhoneNumber == null || _fullPhoneNumber!.isEmpty) {
      SnackBarUtils.showError(context, 'Введите номер телефона');
      return;
    }

    if (_smsAuthService == null) {
      SnackBarUtils.showError(context, 'Сервис инициализируется...');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    developer.log('📱 [PHONE_LOGIN] Sending code to: $_fullPhoneNumber');

    try {
      final result = await _smsAuthService!.sendCode(
        phoneNumber: _fullPhoneNumber!,
      );

      setState(() {
        _isLoading = false;
      });

      developer.log('✅ [PHONE_LOGIN] Code sent, navigating to verification');

      // Navigate to verification page
      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PhoneVerifyPage(
              phoneNumber: _fullPhoneNumber!,
              expiresIn: result['expires_in'] ?? 300,
            ),
          ),
        );
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });

      developer.log('❌ [PHONE_LOGIN] Error: $e');

      if (mounted) {
        SnackBarUtils.showError(
          context,
          'Не удалось отправить код. Попробуйте снова.',
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: AppTheme.lightBackgroundGradient),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Logo
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      gradient: AppTheme.primaryGradient,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.memory,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Title
                  ShaderMask(
                    shaderCallback: (bounds) =>
                        AppTheme.primaryGradient.createShader(bounds),
                    child: Text(
                      'Memoir',
                      style: Theme.of(context).textTheme.headlineLarge
                          ?.copyWith(color: Colors.white, fontSize: 42),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    'Войдите с помощью номера телефона',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey.shade600,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 48),

                  // Phone Input
                  GlassCard(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      child: IntlPhoneField(
                        controller: _phoneController,
                        decoration: InputDecoration(
                          labelText: 'Номер телефона',
                          labelStyle: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: Colors.grey.shade600),
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                        style: Theme.of(context).textTheme.bodyLarge,
                        initialCountryCode: 'KZ',
                        dropdownTextStyle: Theme.of(
                          context,
                        ).textTheme.bodyMedium,
                        onChanged: (phone) {
                          _fullPhoneNumber = phone.completeNumber;
                          developer.log(
                            '📱 [PHONE_LOGIN] Phone number: $_fullPhoneNumber',
                          );
                        },
                        validator: (phone) {
                          if (phone == null || phone.number.isEmpty) {
                            return 'Введите номер телефона';
                          }
                          if (phone.number.length < 10) {
                            return 'Неверный формат номера';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Send Code Button
                  GradientButton(
                    text: 'Получить код',
                    onPressed: _isLoading ? null : _sendCode,
                    isLoading: _isLoading,
                  ),

                  const SizedBox(height: 24),

                  // Info Text
                  Text(
                    'Мы отправим SMS с кодом подтверждения на ваш номер',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey.shade600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
