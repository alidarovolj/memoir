import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:memoir/core/config/api_config.dart';

class AuthService {
  static const String _tokenKey = 'auth_token';
  static const String _userIdKey = 'user_id';
  static const String _emailKey = 'user_email';
  
  final Dio dio;
  
  AuthService({required this.dio});

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

  // Вход
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await dio.post(
        ApiConfig.login,
        data: {
          'email': email, // Backend ожидает email в JSON
          'password': password,
        },
      );
      
      final token = response.data['access_token'];
      
      // Получаем данные пользователя
      final userResponse = await dio.get(
        ApiConfig.me,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      
      final user = userResponse.data;
      await _saveAuthData(token, user['id'], user['email']);
      
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
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_userIdKey);
    await prefs.remove(_emailKey);
  }

  // Получить токен
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  // Проверить авторизацию
  Future<bool> isAuthenticated() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }

  // Получить текущего пользователя
  Future<Map<String, dynamic>?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString(_userIdKey);
    final email = prefs.getString(_emailKey);
    
    if (userId == null || email == null) return null;
    
    return {
      'id': userId,
      'email': email,
    };
  }

  // Сохранить данные авторизации
  Future<void> _saveAuthData(String token, String userId, String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
    await prefs.setString(_userIdKey, userId);
    await prefs.setString(_emailKey, email);
  }
}

