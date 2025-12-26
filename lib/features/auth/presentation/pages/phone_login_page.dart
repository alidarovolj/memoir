import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:memoir/core/theme/app_theme.dart';
import 'package:memoir/core/utils/snackbar_utils.dart';
import 'package:memoir/core/services/sms_auth_service.dart';
import 'package:memoir/core/network/dio_client.dart';
import 'package:memoir/features/auth/presentation/pages/phone_verify_page.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:developer' as developer;

class PhoneLoginPage extends StatefulWidget {
  const PhoneLoginPage({super.key});

  @override
  State<PhoneLoginPage> createState() => _PhoneLoginPageState();
}

class _PhoneLoginPageState extends State<PhoneLoginPage> {
  final _phoneController = TextEditingController(text: '+');
  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;
  String? _fullPhoneNumber;
  SmsAuthService? _smsAuthService;
  String _countryCode = '';
  String _countryName = '';

  // Карта кодов стран
  final Map<String, String> _countryCodes = {
    '+7': 'Казахстан',
    '+1': 'США',
    '+44': 'Великобритания',
    '+33': 'Франция',
    '+49': 'Германия',
    '+86': 'Китай',
    '+81': 'Япония',
    '+82': 'Корея',
    '+91': 'Индия',
    '+90': 'Турция',
    '+380': 'Украина',
    '+992': 'Таджикистан',
    '+996': 'Кыргызстан',
    '+998': 'Узбекистан',
  };

  @override
  void initState() {
    super.initState();
    _initSmsAuthService();
    _phoneController.addListener(_onPhoneChanged);
    // Устанавливаем курсор после "+"
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _phoneController.selection = TextSelection.fromPosition(
        TextPosition(offset: _phoneController.text.length),
      );
    });
  }

  Future<void> _initSmsAuthService() async {
    final dio = DioClient.instance;
    _smsAuthService = SmsAuthService(dio);
  }

  void _onPhoneChanged() {
    final text = _phoneController.text;

    // Автоматически определяем код страны только если начинается с +
    if (text.startsWith('+')) {
      String detectedCode = '';
      String detectedCountry = '';

      // Проверяем по убыванию длины кода (сначала 4-х значные, потом 3-х, потом 2-х)
      final sortedCodes = _countryCodes.keys.toList()
        ..sort((a, b) => b.length.compareTo(a.length));

      for (final code in sortedCodes) {
        if (text.startsWith(code)) {
          detectedCode = code;
          detectedCountry = _countryCodes[code]!;
          break;
        }
      }

      if (_countryCode != detectedCode || _countryName != detectedCountry) {
        setState(() {
          _countryCode = detectedCode;
          _countryName = detectedCountry;
        });
      }
    } else {
      // Если нет +, очищаем информацию о стране
      if (_countryCode.isNotEmpty || _countryName.isNotEmpty) {
        setState(() {
          _countryCode = '';
          _countryName = '';
        });
      }
    }

    _fullPhoneNumber = text;
  }

  @override
  void dispose() {
    _phoneController.removeListener(_onPhoneChanged);
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _sendCode() async {
    if (!_formKey.currentState!.validate()) return;

    String phoneNumber = _phoneController.text.trim();
    _fullPhoneNumber = phoneNumber;

    if (_fullPhoneNumber == null || _fullPhoneNumber!.length < 11) {
      SnackBarUtils.showError(context, 'Введите корректный номер телефона');
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

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Введите номер телефона';
    }

    // Убираем все кроме цифр и +
    final cleaned = value.replaceAll(RegExp(r'[^\d+]'), '');

    if (cleaned.length < 11) {
      return 'Номер слишком короткий';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.pageBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Logo
                Center(
                  child: SizedBox(
                    height: 150,
                    width: 150,
                    child: SvgPicture.asset('assets/images/first_logo.svg'),
                  ),
                ),

                const SizedBox(height: 32),

                // Title
                const Text(
                  'Memoir',
                  style: TextStyle(
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryColor,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 8),

                Text(
                  'Войдите с помощью номера телефона',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.6),
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 48),

                // Phone Input
                Container(
                  decoration: BoxDecoration(
                    color: AppTheme.surfaceColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.1),
                      width: 1,
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 4,
                  ),
                  child: Row(
                    children: [
                      // Префикс с флагом и названием страны (показывается только если определена)
                      if (_countryName.isNotEmpty) ...[
                        Container(
                          padding: const EdgeInsets.only(right: 12),
                          decoration: BoxDecoration(
                            border: Border(
                              right: BorderSide(
                                color: Colors.white.withOpacity(0.1),
                                width: 1,
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.flag,
                                color: AppTheme.primaryColor,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    _countryName,
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.6),
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    _countryCode,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                      ],
                      // Поле ввода номера
                      Expanded(
                        child: TextFormField(
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Номер телефона',
                            hintStyle: TextStyle(
                              color: Colors.white.withOpacity(0.3),
                              fontSize: 16,
                            ),
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            focusedErrorBorder: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 16,
                            ),
                            errorStyle: const TextStyle(height: 0),
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp(r'[\d+\s\-()]'),
                            ),
                          ],
                          validator: _validatePhone,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                // Send Code Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _sendCode,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                      disabledBackgroundColor: AppTheme.primaryColor
                          .withOpacity(0.5),
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
                            'Получить код',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ),

                const SizedBox(height: 24),

                // Info Text
                Text(
                  'Мы отправим SMS с кодом подтверждения на ваш номер',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white.withOpacity(0.4),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
