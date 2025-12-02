import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:memoir/core/network/auth_interceptor.dart';
import 'package:memoir/core/config/api_config.dart';
import 'package:memoir/core/services/auth_service.dart';

class DioClient {
  static Dio? _instance;
  static GlobalKey<NavigatorState>? _navigatorKey;

  static void initialize(GlobalKey<NavigatorState> navigatorKey) {
    _navigatorKey = navigatorKey;
    _instance = null; // Сбрасываем instance чтобы пересоздать с новым ключом
  }

  static Dio get instance {
    if (_instance == null) {
      _instance = Dio(
        BaseOptions(
          baseUrl: ApiConfig.baseUrl,
          connectTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 30),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      // Добавляем interceptor для логирования
      _instance!.interceptors.add(
        LogInterceptor(
          request: true,
          requestHeader: true,
          requestBody: true,
          responseHeader: true,
          responseBody: true,
          error: true,
          logPrint: (obj) => print('🌐 API: $obj'),
        ),
      );

      // Добавляем auth interceptor с navigation key
      if (_navigatorKey != null) {
        final authService = AuthService(dio: _instance!);
        _instance!.interceptors.add(
          AuthInterceptor(
            authService: authService,
            navigatorKey: _navigatorKey!,
          ),
        );
      }
    }

    return _instance!;
  }
}
