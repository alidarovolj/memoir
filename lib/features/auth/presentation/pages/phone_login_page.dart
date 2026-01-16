import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:memoir/core/theme/app_theme.dart';
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
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController(text: '+7 ');

  bool _isLoading = false;
  String? _fullPhoneNumber;
  SmsAuthService? _smsAuthService;

  @override
  void initState() {
    super.initState();
    _initSmsAuthService();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _initSmsAuthService() async {
    final dio = DioClient.instance;
    _smsAuthService = SmsAuthService(dio);
  }

  String _extractDigits(String text) {
    return text.replaceAll(RegExp(r'[^\d]'), '');
  }

  Future<void> _sendCode() async {
    final digits = _extractDigits(_phoneController.text);
    
    // Проверяем, что номер начинается с 7 и имеет 11 цифр
    if (digits.length != 11 || !digits.startsWith('7')) {
      SnackBarUtils.showError(context, 'Введите корректный номер телефона');
      return;
    }

    _fullPhoneNumber = '+$digits';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Title
                const Text(
                  'Enter your phone number',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF202020),
                  ),
                ),

                const SizedBox(height: 16),

                // Phone Number Label
                const Text(
                  'Phone Number',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF202020),
                  ),
                ),

                const SizedBox(height: 8),

                // Phone Input with formatting
                TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    _PhoneNumberFormatter(),
                  ],
                  decoration: InputDecoration(
                    hintText: '+7 (xxx) xxx-xx-xx',
                    hintStyle: const TextStyle(
                      color: Color(0xFF999999),
                      fontSize: 16,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Color(0xFFE0E0E0),
                        width: 1,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Color(0xFFE0E0E0),
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Color(0xFFE0E0E0),
                        width: 1,
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                  ),
                  style: const TextStyle(
                    color: Color(0xFF202020),
                    fontSize: 16,
                  ),
                ),

                const Spacer(),

                // Log in Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _sendCode,
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
                            'Log in',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),

                const SizedBox(height: 24),

                // Divider
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: Colors.grey[300],
                        thickness: 1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'or',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: Colors.grey[300],
                        thickness: 1,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Social Auth Buttons
                Row(
                  children: [
                    // Google Button
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          // TODO: Implement Google auth
                        },
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: const BorderSide(
                              color: Color(0xFFE0E0E0),
                              width: 1,
                            ),
                          ),
                          backgroundColor: Colors.white,
                        ),
                        child: Image.asset(
                          'assets/icons/auth/google.png',
                          height: 24,
                          width: 24,
                        ),
                      ),
                    ),

                    const SizedBox(width: 16),

                    // Apple Button
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          // TODO: Implement Apple auth
                        },
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: const BorderSide(
                              color: Color(0xFFE0E0E0),
                              width: 1,
                            ),
                          ),
                          backgroundColor: Colors.white,
                        ),
                        child: Image.asset(
                          'assets/icons/auth/apple.png',
                          height: 24,
                          width: 24,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Create Account Link
                Center(
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF202020),
                      ),
                      children: [
                        const TextSpan(text: "Don't have an account? "),
                        WidgetSpan(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/signup');
                            },
                            child: const Text(
                              'Create Account',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.blue,
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
        ),
      ),
    );
  }
}

/// Форматтер для номера телефона в формате +7 (xxx) xxx-xx-xx
class _PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final newText = newValue.text;
    final oldText = oldValue.text;
    
    // Если пользователь вводит текст, извлекаем только цифры
    final newDigits = newText.replaceAll(RegExp(r'[^\d]'), '');
    final oldDigits = oldText.replaceAll(RegExp(r'[^\d]'), '');
    
    // Если пользователь удаляет символы
    if (newDigits.length < oldDigits.length) {
      // Удаляем цифры из старого значения
      String phoneDigits = newDigits;
      
      // Если первая цифра не 7, добавляем 7
      if (phoneDigits.isNotEmpty && !phoneDigits.startsWith('7')) {
        phoneDigits = '7$phoneDigits';
      }
      
      // Форматируем
      final formatted = _formatPhoneNumber(phoneDigits);
      
      // Вычисляем позицию курсора
      int cursorPosition = _calculateCursorPosition(
        formatted,
        newDigits.length,
        oldValue.selection.baseOffset,
        oldText,
        newText,
      );
      
      return TextEditingValue(
        text: formatted,
        selection: TextSelection.collapsed(offset: cursorPosition),
      );
    }
    
    // Если пользователь вводит символы
    if (newDigits.isEmpty) {
      return TextEditingValue(
        text: '+7 ',
        selection: const TextSelection.collapsed(offset: 3),
      );
    }
    
    // Если первая цифра не 7, добавляем 7
    String phoneDigits = newDigits;
    if (!phoneDigits.startsWith('7')) {
      phoneDigits = '7$phoneDigits';
    }
    
    // Ограничиваем до 11 цифр (7 + 10)
    if (phoneDigits.length > 11) {
      phoneDigits = phoneDigits.substring(0, 11);
    }
    
    // Форматируем
    final formatted = _formatPhoneNumber(phoneDigits);
    
    // Вычисляем позицию курсора
    int cursorPosition = _calculateCursorPosition(
      formatted,
      phoneDigits.length,
      newValue.selection.baseOffset,
      oldText,
      newText,
    );
    
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: cursorPosition),
    );
  }
  
  String _formatPhoneNumber(String digits) {
    if (digits.isEmpty || digits == '7') {
      return '+7 ';
    }
    
    String formatted = '+7';
    
    if (digits.length > 1) {
      final part1 = digits.substring(1, digits.length > 4 ? 4 : digits.length);
      formatted += ' ($part1';
      
      if (digits.length > 4) {
        final part2 = digits.substring(4, digits.length > 7 ? 7 : digits.length);
        formatted += ') $part2';
        
        if (digits.length > 7) {
          final part3 = digits.substring(7, digits.length > 9 ? 9 : digits.length);
          formatted += '-$part3';
          
          if (digits.length > 9) {
            final part4 = digits.substring(9);
            formatted += '-$part4';
          }
        }
      } else {
        formatted += ')';
      }
    }
    
    return formatted;
  }
  
  int _calculateCursorPosition(
    String formatted,
    int digitCount,
    int oldCursorPosition,
    String oldText,
    String newText,
  ) {
    // Если это удаление, пытаемся сохранить позицию
    if (oldText.length > newText.length) {
      // Находим позицию последней цифры в отформатированной строке
      int digitIndex = 0;
      for (int i = 0; i < formatted.length; i++) {
        if (RegExp(r'\d').hasMatch(formatted[i])) {
          digitIndex++;
          if (digitIndex == digitCount) {
            // Возвращаем позицию после последней цифры
            return i + 1;
          }
        }
      }
    }
    
    // При вводе ставим курсор в конец
    return formatted.length;
  }
}
