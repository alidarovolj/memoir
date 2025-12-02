import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:memoir/core/config/api_config.dart';
import 'package:memoir/core/config/app_config.dart';

/// API Client with Dio
class ApiClient {
  late final Dio _dio;
  final SharedPreferences _prefs;
  
  ApiClient(this._prefs) {
    _dio = Dio(BaseOptions(
      baseUrl: ApiConfig.baseUrl,
      connectTimeout: const Duration(milliseconds: ApiConfig.connectTimeout),
      receiveTimeout: const Duration(milliseconds: ApiConfig.receiveTimeout),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ));
    
    // Add interceptors
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: _onRequest,
        onError: _onError,
      ),
    );
    
    // Add logger in debug mode
    _dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
      ),
    );
  }
  
  Dio get dio => _dio;
  
  /// Add authorization header
  Future<void> _onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = _prefs.getString(AppConfig.accessTokenKey);
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }
  
  /// Handle errors
  Future<void> _onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    // Handle 401 - try to refresh token
    if (err.response?.statusCode == 401) {
      try {
        final refreshed = await _refreshToken();
        if (refreshed) {
          // Retry original request
          final response = await _dio.fetch(err.requestOptions);
          return handler.resolve(response);
        }
      } catch (e) {
        // Token refresh failed, clear tokens
        await _prefs.remove(AppConfig.accessTokenKey);
        await _prefs.remove(AppConfig.refreshTokenKey);
      }
    }
    
    handler.next(err);
  }
  
  /// Refresh access token
  Future<bool> _refreshToken() async {
    final refreshToken = _prefs.getString(AppConfig.refreshTokenKey);
    if (refreshToken == null) return false;
    
    try {
      final response = await _dio.post(
        ApiConfig.refresh,
        data: {'refresh_token': refreshToken},
      );
      
      final newAccessToken = response.data['access_token'];
      final newRefreshToken = response.data['refresh_token'];
      
      await _prefs.setString(AppConfig.accessTokenKey, newAccessToken);
      await _prefs.setString(AppConfig.refreshTokenKey, newRefreshToken);
      
      return true;
    } catch (e) {
      return false;
    }
  }
  
  /// Save tokens
  Future<void> saveTokens(String accessToken, String refreshToken) async {
    await _prefs.setString(AppConfig.accessTokenKey, accessToken);
    await _prefs.setString(AppConfig.refreshTokenKey, refreshToken);
  }
  
  /// Clear tokens
  Future<void> clearTokens() async {
    await _prefs.remove(AppConfig.accessTokenKey);
    await _prefs.remove(AppConfig.refreshTokenKey);
  }
  
  /// Check if authenticated
  bool isAuthenticated() {
    return _prefs.getString(AppConfig.accessTokenKey) != null;
  }
}

