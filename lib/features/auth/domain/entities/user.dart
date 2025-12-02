import 'package:equatable/equatable.dart';

/// User entity
class User extends Equatable {
  final String id;
  final String email;
  final String username;
  final DateTime createdAt;
  final DateTime updatedAt;
  
  const User({
    required this.id,
    required this.email,
    required this.username,
    required this.createdAt,
    required this.updatedAt,
  });
  
  @override
  List<Object?> get props => [id, email, username, createdAt, updatedAt];
}

