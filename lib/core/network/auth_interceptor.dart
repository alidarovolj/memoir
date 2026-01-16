import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:memoir/core/services/auth_service.dart';

class AuthInterceptor extends Interceptor {
  final AuthService authService;
  final GlobalKey<NavigatorState> navigatorKey;

  AuthInterceptor({required this.authService, required this.navigatorKey});

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Получаем токен
    final token = await authService.getToken();

    if (token != null && token.isNotEmpty) {
      // Добавляем токен в заголовки
      options.headers['Authorization'] = 'Bearer $token';
      print('🔐 Added auth token to request: ${options.path}');
    }

    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // Если 401 или 403 - токен истек или недействителен
    // Если 404 с "User not found" - пользователь удален или база пересоздана
    // НО не делаем logout если это страница логина/регистрации/SMS auth
    if (err.response?.statusCode == 401 ||
        err.response?.statusCode == 403 ||
        (err.response?.statusCode == 404 &&
            err.response?.data?['detail']?.toString().contains(
                  'User not found',
                ) ==
                true)) {
      final uri = err.requestOptions.uri.toString();

      // Не делаем автоматический logout для auth endpoints
      if (!uri.contains('/auth/login') &&
          !uri.contains('/auth/register') &&
          !uri.contains('/sms-auth/') &&
          !uri.contains('/email-auth/')) {
        print(
          '🔐 Authentication error (${err.response?.statusCode}): ${err.response?.data?['detail'] ?? 'Unknown'}, logging out...',
        );

        // Очищаем токен
        await authService.logout();

        // Перенаправляем на страницу регистрации
        if (navigatorKey.currentState != null) {
          navigatorKey.currentState!.pushNamedAndRemoveUntil(
            '/signup',
            (route) => false,
          );
        }
      }
    }

    super.onError(err, handler);
  }
}
