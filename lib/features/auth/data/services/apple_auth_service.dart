import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:memoir/core/network/dio_client.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppleAuthService {
  final Dio _dio = DioClient.instance;

  /// Выполнить вход через Apple
  Future<Map<String, dynamic>> signInWithApple() async {
    try {
      // Выполняем Apple Sign In
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      // Проверяем наличие identityToken
      if (credential.identityToken == null) {
        throw Exception('Failed to get identity token from Apple');
      }

      // Отправляем токен на бэкенд для верификации
      final response = await _dio.post(
        '/api/v1/auth/apple',
        data: {
          'identity_token': credential.identityToken,
          'authorization_code': credential.authorizationCode,
          'user_identifier': credential.userIdentifier,
          'email': credential.email,
          'given_name': credential.givenName,
          'family_name': credential.familyName,
        },
      );

      final data = response.data as Map<String, dynamic>;

      // Сохраняем токены с правильными ключами (как в AuthService)
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('auth_token', data['access_token']);
      await prefs.setString('refresh_token', data['refresh_token']);
      await prefs.setString('user_id', data['user']['id']);

      return {
        'success': true,
        'user': data['user'],
        'is_new_user': data['is_new_user'] ?? false,
      };
    } on SignInWithAppleAuthorizationException catch (e) {
      if (e.code == AuthorizationErrorCode.canceled) {
        throw Exception('Apple Sign In was cancelled');
      } else if (e.code == AuthorizationErrorCode.failed) {
        throw Exception('Apple Sign In failed');
      } else if (e.code == AuthorizationErrorCode.invalidResponse) {
        throw Exception('Invalid response from Apple');
      } else if (e.code == AuthorizationErrorCode.notHandled) {
        throw Exception('Apple Sign In not handled');
      } else if (e.code == AuthorizationErrorCode.unknown) {
        throw Exception('Unknown error during Apple Sign In');
      }
      throw Exception('Apple Sign In error: ${e.code}');
    } on DioException catch (e) {
      throw Exception(
        e.response?.data['detail'] ?? 'Failed to authenticate with Apple',
      );
    } catch (e) {
      throw Exception('Failed to sign in with Apple: $e');
    }
  }

  /// Выйти (локально)
  Future<void> signOut() async {
    // Apple не требует явного sign out
    // Токены очищаются через AuthService
  }

  /// Проверить доступность Apple Sign In
  static Future<bool> isAvailable() async {
    return await SignInWithApple.isAvailable();
  }
}
