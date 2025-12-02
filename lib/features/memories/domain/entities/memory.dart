import 'package:equatable/equatable.dart';
import 'package:memoir/features/memories/domain/entities/category.dart';

/// Source type enum
enum SourceType {
  text,
  link,
  image,
  voice,
}

/// Memory entity
class Memory extends Equatable {
  final String id;
  final String userId;
  final String? categoryId;
  final String title;
  final String content;
  final SourceType sourceType;
  final String? sourceUrl;
  final Map<String, dynamic> memoryMetadata;
  final double? aiConfidence;
  final List<String> tags;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Category? category;
  
  const Memory({
    required this.id,
    required this.userId,
    this.categoryId,
    required this.title,
    required this.content,
    required this.sourceType,
    this.sourceUrl,
    this.memoryMetadata = const {},
    this.aiConfidence,
    this.tags = const [],
    required this.createdAt,
    required this.updatedAt,
    this.category,
  });
  
  @override
  List<Object?> get props => [
        id,
        userId,
        categoryId,
        title,
        content,
        sourceType,
        sourceUrl,
        memoryMetadata,
        aiConfidence,
        tags,
        createdAt,
        updatedAt,
        category,
      ];
}

