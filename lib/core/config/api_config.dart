/// API configuration
class ApiConfig {
  static const String baseUrl = 'http://localhost:8000';
  static const String apiV1 = '$baseUrl/api/v1';
  
  // Auth endpoints
  static const String register = '$apiV1/auth/register';
  static const String login = '$apiV1/auth/login';
  static const String refresh = '$apiV1/auth/refresh';
  static const String me = '$apiV1/auth/me';
  
  // Memory endpoints
  static const String memories = '$apiV1/memories';
  
  // Category endpoints
  static const String categories = '$apiV1/categories';
  
  // Search endpoints
  static const String search = '$apiV1/search';
  static const String searchSemantic = '$apiV1/search/semantic';
  static const String smartSearch = '$apiV1/smart-search';
  static const String contentDetails = '$apiV1/content-details';
  
  // Story endpoints
  static const String stories = '$apiV1/stories';
  
  // Task endpoints
  static const String tasks = '$apiV1/tasks';
  static const String tasksAnalyze = '$apiV1/tasks/analyze';
  
  // Timeouts
  static const int connectTimeout = 30000; // 30 seconds
  static const int receiveTimeout = 30000; // 30 seconds
}

