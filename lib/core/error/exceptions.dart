/// Base exception
class AppException implements Exception {
  final String message;

  AppException(this.message);

  @override
  String toString() => message;
}

/// Server exception
class ServerException extends AppException {
  ServerException([super.message = 'Server error occurred']);
}

/// Cache exception
class CacheException extends AppException {
  CacheException([super.message = 'Cache error occurred']);
}

/// Network exception
class NetworkException extends AppException {
  NetworkException([super.message = 'Network error occurred']);
}

/// Authentication exception
class AuthenticationException extends AppException {
  AuthenticationException([super.message = 'Authentication failed']);
}

/// Validation exception
class ValidationException extends AppException {
  ValidationException([super.message = 'Validation failed']);
}

/// Not found exception
class NotFoundException extends AppException {
  NotFoundException([super.message = 'Resource not found']);
}
