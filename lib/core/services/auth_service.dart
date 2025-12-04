import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:memoir/core/config/api_config.dart';
import 'dart:developer' as developer;

class AuthService {
  static const String _tokenKey = 'auth_token';
  static const String _userIdKey = 'user_id';
  static const String _phoneKey = 'user_phone';
  
  final Dio dio;
  final SharedPreferences prefs;
  
  AuthService(this.dio, this.prefs);

  // Регистрация
  Future<Map<String, dynamic>> register({
    required String email,
    required String password,
  }) async {
    try {
      final response = await dio.post(
        ApiConfig.register,
        data: {
          'email': email,
          'password': password,
        },
      );
      
      final token = response.data['access_token'];
      final user = response.data['user'];
      
      // Сохраняем токен и данные пользователя
      await _saveAuthData(token, user['id'], user['email']);
      
      return {
        'token': token,
        'user': user,
      };
    } catch (e) {
      rethrow;
    }
  }

  // Phone Authentication (Primary method)
  Future<Map<String, dynamic>> authenticateWithPhone({
    required String phoneNumber,
    required String firebaseToken,
  }) async {
    try {
      developer.log('🌐 [AUTH_SERVICE] Authenticating with phone: $phoneNumber');
      
      final response = await dio.post(
        '${ApiConfig.apiV1}/auth/phone',
        data: {
          'phone_number': phoneNumber,
          'firebase_token': firebaseToken,
        },
      );
      
      final token = response.data['access_token'];
      final user = response.data['user'];
      
      developer.log('✅ [AUTH_SERVICE] Authentication successful');
      developer.log('👤 [AUTH_SERVICE] User ID: ${user['id']}');
      
      // Save auth data
      await _saveAuthDataPhone(token, user['id'], user['phone_number']);
      
      return {
        'token': token,
        'user': user,
      };
    } catch (e) {
      developer.log('❌ [AUTH_SERVICE] Authentication error: $e');
      rethrow;
    }
  }
  
  // Legacy email/password login (keep for backward compatibility)
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await dio.post(
        ApiConfig.login,
        data: {
          'email': email,
          'password': password,
        },
      );
      
      final token = response.data['access_token'];
      
      // Get user data
      final userResponse = await dio.get(
        ApiConfig.me,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      
      final user = userResponse.data;
      await _saveAuthDataPhone(token, user['id'], user['phone_number'] ?? '');
      
      return {
        'token': token,
        'user': user,
      };
    } catch (e) {
      rethrow;
    }
  }

  // Выход
  Future<void> logout() async {
    await prefs.remove(_tokenKey);
    await prefs.remove(_userIdKey);
    await prefs.remove(_phoneKey);
    developer.log('👋 [AUTH_SERVICE] Logged out');
  }

  // Получить токен
  Future<String?> getToken() async {
    return prefs.getString(_tokenKey);
  }

  // Проверить авторизацию
  Future<bool> isAuthenticated() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }

  // Получить текущего пользователя
  Future<Map<String, dynamic>?> getCurrentUser() async {
    final userId = prefs.getString(_userIdKey);
    final phone = prefs.getString(_phoneKey);
    
    if (userId == null) return null;
    
    return {
      'id': userId,
      'phone_number': phone ?? '',
    };
  }

  // Сохранить данные авторизации с телефоном
  Future<void> _saveAuthDataPhone(String token, String userId, String phoneNumber) async {
    await prefs.setString(_tokenKey, token);
    await prefs.setString(_userIdKey, userId);
    await prefs.setString(_phoneKey, phoneNumber);
    developer.log('💾 [AUTH_SERVICE] Auth data saved');
  }
  
  // Legacy method (для совместимости)
  Future<void> _saveAuthData(String token, String userId, String email) async {
    await prefs.setString(_tokenKey, token);
    await prefs.setString(_userIdKey, userId);
    developer.log('💾 [AUTH_SERVICE] Auth data saved (legacy)');
  }
}

