/// Application configuration
class AppConfig {
  static const String appName = 'Memoir';
  static const String appVersion = '0.1.0';
  
  // Storage keys
  static const String accessTokenKey = 'access_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String userDataKey = 'user_data';
  
  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;
  
  // Cache
  static const int cacheMaxAge = 3600; // 1 hour in seconds
}

