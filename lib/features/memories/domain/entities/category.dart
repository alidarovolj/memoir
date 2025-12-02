import 'package:equatable/equatable.dart';

/// Category entity
class Category extends Equatable {
  final String id;
  final String name;
  final String displayName;
  final String icon;
  final String color;
  final DateTime createdAt;
  
  const Category({
    required this.id,
    required this.name,
    required this.displayName,
    required this.icon,
    required this.color,
    required this.createdAt,
  });
  
  @override
  List<Object?> get props => [id, name, displayName, icon, color, createdAt];
}

