import 'package:json_annotation/json_annotation.dart';
import 'package:memoir/features/memories/domain/entities/memory.dart';
import 'package:memoir/features/memories/data/models/category_model.dart';

part 'memory_model.g.dart';

@JsonSerializable()
class MemoryModel extends Memory {
  @JsonKey(name: 'category')
  final CategoryModel? categoryModel;
  
  const MemoryModel({
    required super.id,
    required super.userId,
    super.categoryId,
    required super.title,
    required super.content,
    required super.sourceType,
    super.sourceUrl,
    super.memoryMetadata = const {},
    super.aiConfidence,
    super.tags = const [],
    required super.createdAt,
    required super.updatedAt,
    this.categoryModel,
  }) : super(category: categoryModel);
  
  factory MemoryModel.fromJson(Map<String, dynamic> json) => _$MemoryModelFromJson(json);
  
  Map<String, dynamic> toJson() => _$MemoryModelToJson(this);
  
  Memory toEntity() {
    return Memory(
      id: id,
      userId: userId,
      categoryId: categoryId,
      title: title,
      content: content,
      sourceType: sourceType,
      sourceUrl: sourceUrl,
      memoryMetadata: memoryMetadata,
      aiConfidence: aiConfidence,
      tags: tags,
      createdAt: createdAt,
      updatedAt: updatedAt,
      category: categoryModel?.toEntity(),
    );
  }
}

