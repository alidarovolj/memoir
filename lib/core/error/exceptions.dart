/// Base exception
class AppException implements Exception {
  final String message;
  
  AppException(this.message);
  
  @override
  String toString() => message;
}

/// Server exception
class ServerException extends AppException {
  ServerException([String message = 'Server error occurred']) : super(message);
}

/// Cache exception
class CacheException extends AppException {
  CacheException([String message = 'Cache error occurred']) : super(message);
}

/// Network exception
class NetworkException extends AppException {
  NetworkException([String message = 'Network error occurred']) : super(message);
}

/// Authentication exception
class AuthenticationException extends AppException {
  AuthenticationException([String message = 'Authentication failed']) : super(message);
}

/// Validation exception
class ValidationException extends AppException {
  ValidationException([String message = 'Validation failed']) : super(message);
}

/// Not found exception
class NotFoundException extends AppException {
  NotFoundException([String message = 'Resource not found']) : super(message);
}

