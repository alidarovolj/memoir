import 'package:flutter_dotenv/flutter_dotenv.dart';

/// API configuration
class ApiConfig {
  // Get base URL from environment or fallback to localhost
  static String get baseUrl => dotenv.env['API_BASE_URL'] ?? 'http://localhost:8000';
  static String get apiV1 => '$baseUrl/api/v1';
  
  // Auth endpoints
  static String get register => '$apiV1/auth/register';
  static String get login => '$apiV1/auth/login';
  static String get refresh => '$apiV1/auth/refresh';
  static String get me => '$apiV1/auth/me';
  
  // Memory endpoints
  static String get memories => '$apiV1/memories';
  
  // Category endpoints
  static String get categories => '$apiV1/categories';
  
  // Search endpoints
  static String get search => '$apiV1/search';
  static String get searchSemantic => '$apiV1/search/semantic';
  static String get smartSearch => '$apiV1/smart-search';
  static String get contentDetails => '$apiV1/content-details';
  
  // Story endpoints
  static String get stories => '$apiV1/stories';
  
  // Task endpoints
  static String get tasks => '$apiV1/tasks';
  static String get tasksAnalyze => '$apiV1/tasks/analyze';
  
  // Timeouts
  static int get connectTimeout => 
      int.tryParse(dotenv.env['API_TIMEOUT'] ?? '30000') ?? 30000;
  static int get receiveTimeout => 
      int.tryParse(dotenv.env['API_TIMEOUT'] ?? '30000') ?? 30000;
}

