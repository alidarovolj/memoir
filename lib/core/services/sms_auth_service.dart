import 'package:dio/dio.dart';
import 'dart:developer' as developer;

/// Service for SMS-based authentication
/// Communicates with Backend API (Mobizon integration on backend side)
class SmsAuthService {
  final Dio dio;

  SmsAuthService(this.dio);

  /// Send SMS verification code
  Future<Map<String, dynamic>> sendCode({
    required String phoneNumber,
  }) async {
    try {
      developer.log('📱 [SMS_AUTH] Sending code to: $phoneNumber');

      final response = await dio.post(
        '/api/v1/sms-auth/send-code',
        data: {
          'phone_number': phoneNumber,
        },
      );

      developer.log('✅ [SMS_AUTH] Code sent successfully');
      developer.log('⏱️ [SMS_AUTH] Expires in: ${response.data['expires_in']}s');

      return response.data;
    } catch (e) {
      developer.log('❌ [SMS_AUTH] Error sending code: $e');
      rethrow;
    }
  }

  /// Verify SMS code and authenticate
  Future<Map<String, dynamic>> verifyCode({
    required String phoneNumber,
    required String code,
  }) async {
    try {
      developer.log('🔍 [SMS_AUTH] Verifying code for: $phoneNumber');

      final response = await dio.post(
        '/api/v1/sms-auth/verify-code',
        data: {
          'phone_number': phoneNumber,
          'code': code,
        },
      );

      developer.log('✅ [SMS_AUTH] Code verified successfully');

      return response.data;
    } catch (e) {
      developer.log('❌ [SMS_AUTH] Verification error: $e');
      rethrow;
    }
  }

  /// Resend verification code
  Future<Map<String, dynamic>> resendCode({
    required String phoneNumber,
  }) async {
    try {
      developer.log('🔄 [SMS_AUTH] Resending code to: $phoneNumber');

      final response = await dio.post(
        '/api/v1/sms-auth/resend-code',
        data: {
          'phone_number': phoneNumber,
        },
      );

      developer.log('✅ [SMS_AUTH] Code resent successfully');

      return response.data;
    } catch (e) {
      developer.log('❌ [SMS_AUTH] Error resending code: $e');
      rethrow;
    }
  }
}

