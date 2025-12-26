import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:memoir/core/network/auth_interceptor.dart';
import 'package:memoir/core/config/api_config.dart';
import 'package:memoir/core/services/auth_service.dart';
import 'package:chucker_flutter/chucker_flutter.dart';

class DioClient {
  static Dio? _instance;
  static GlobalKey<NavigatorState>? _navigatorKey;
  static SharedPreferences? _prefs;

  static Future<void> initialize(GlobalKey<NavigatorState> navigatorKey) async {
    _navigatorKey = navigatorKey;
    _prefs = await SharedPreferences.getInstance();
    _instance = null; // Сбрасываем instance чтобы пересоздать с новым ключом
  }

  /// Create a new Dio instance with auth interceptor
  static Dio createDio(SharedPreferences prefs) {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiConfig.baseUrl,
        connectTimeout: Duration(milliseconds: ApiConfig.connectTimeout),
        receiveTimeout: Duration(milliseconds: ApiConfig.receiveTimeout),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // Add Chucker interceptor for network debugging (first, so it captures everything)
    dio.interceptors.add(ChuckerDioInterceptor());

    // Add logging interceptor
    dio.interceptors.add(
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

    // Add auth interceptor if navigator key is available
    if (_navigatorKey != null) {
      final authService = AuthService(dio, prefs);
      dio.interceptors.add(
        AuthInterceptor(authService: authService, navigatorKey: _navigatorKey!),
      );
    }

    return dio;
  }

  static Dio get instance {
    if (_instance == null && _prefs != null && _navigatorKey != null) {
      _instance = createDio(_prefs!);
    } else if (_instance == null) {
      // Fallback without auth interceptor
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

      // Add Chucker interceptor
      _instance!.interceptors.add(ChuckerDioInterceptor());

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
    }

    return _instance!;
  }
}
