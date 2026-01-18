import 'package:google_sign_in/google_sign_in.dart';
import 'package:memoir/core/network/dio_client.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GoogleAuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile'],
    // iOS clientId из GoogleService-Info.plist
    clientId: '660553470030-as8ms2ovb1cb3tk2ii50s1a4iaq1ea0d.apps.googleusercontent.com',
  );

  final Dio _dio = DioClient.instance;

  /// Выполнить вход через Google
  Future<Map<String, dynamic>> signInWithGoogle() async {
    try {
      // Выполняем Google Sign In
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      
      if (googleUser == null) {
        throw Exception('Google Sign In was cancelled');
      }

      // Получаем данные аутентификации
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      
      if (googleAuth.idToken == null) {
        throw Exception('Failed to get ID token');
      }

      // Отправляем токен на бэкенд для верификации
      final response = await _dio.post(
        '/api/v1/auth/google',
        data: {
          'id_token': googleAuth.idToken,
          'access_token': googleAuth.accessToken,
        },
      );

      final data = response.data as Map<String, dynamic>;
      
      // Сохраняем токены с правильными ключами (как в AuthService)
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('auth_token', data['access_token']);  // Изменено с 'access_token' на 'auth_token'
      await prefs.setString('refresh_token', data['refresh_token']);
      await prefs.setString('user_id', data['user']['id']);
      
      return {
        'success': true,
        'user': data['user'],
        'is_new_user': data['is_new_user'] ?? false,
      };
    } on DioException catch (e) {
      throw Exception(
        e.response?.data['detail'] ?? 'Failed to authenticate with Google',
      );
    } catch (e) {
      throw Exception('Failed to sign in with Google: $e');
    }
  }

  /// Выйти из Google аккаунта
  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
    } catch (e) {
      // Игнорируем ошибки выхода
    }
  }

  /// Проверить, есть ли активная сессия Google
  Future<bool> isSignedIn() async {
    return await _googleSignIn.isSignedIn();
  }

  /// Получить текущий Google аккаунт
  Future<GoogleSignInAccount?> getCurrentUser() async {
    return _googleSignIn.currentUser;
  }

  /// Отключить Google аккаунт
  Future<void> disconnect() async {
    try {
      await _googleSignIn.disconnect();
    } catch (e) {
      // Игнорируем ошибки отключения
    }
  }
}
