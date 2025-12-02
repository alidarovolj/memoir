import 'package:equatable/equatable.dart';

/// Base class for failures
abstract class Failure extends Equatable {
  final String message;
  
  const Failure(this.message);
  
  @override
  List<Object?> get props => [message];
}

/// Server failure
class ServerFailure extends Failure {
  const ServerFailure([String message = 'Server error occurred']) : super(message);
}

/// Cache failure
class CacheFailure extends Failure {
  const CacheFailure([String message = 'Cache error occurred']) : super(message);
}

/// Network failure
class NetworkFailure extends Failure {
  const NetworkFailure([String message = 'Network error occurred']) : super(message);
}

/// Authentication failure
class AuthenticationFailure extends Failure {
  const AuthenticationFailure([String message = 'Authentication failed']) : super(message);
}

/// Validation failure
class ValidationFailure extends Failure {
  const ValidationFailure([String message = 'Validation failed']) : super(message);
}

/// Not found failure
class NotFoundFailure extends Failure {
  const NotFoundFailure([String message = 'Resource not found']) : super(message);
}

