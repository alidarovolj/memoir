import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:memoir/core/services/auth_service.dart';

class AuthInterceptor extends Interceptor {
  final AuthService authService;
  final GlobalKey<NavigatorState> navigatorKey;

  AuthInterceptor({
    required this.authService,
    required this.navigatorKey,
  });

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
    if (err.response?.statusCode == 401 || err.response?.statusCode == 403) {
      print('🔐 Token expired or invalid (${err.response?.statusCode}), logging out...');
      
      // Очищаем токен
      await authService.logout();
      
      // Перенаправляем на страницу логина
      if (navigatorKey.currentState != null) {
        navigatorKey.currentState!.pushNamedAndRemoveUntil(
          '/login',
          (route) => false,
        );
      }
    }
    
    super.onError(err, handler);
  }
}

