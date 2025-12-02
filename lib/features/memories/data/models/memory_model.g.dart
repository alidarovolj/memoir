// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'memory_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MemoryModel _$MemoryModelFromJson(Map<String, dynamic> json) => MemoryModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      categoryId: json['categoryId'] as String?,
      title: json['title'] as String,
      content: json['content'] as String,
      sourceType: $enumDecode(_$SourceTypeEnumMap, json['sourceType']),
      sourceUrl: json['sourceUrl'] as String?,
      memoryMetadata:
          json['memoryMetadata'] as Map<String, dynamic>? ?? const {},
      aiConfidence: (json['aiConfidence'] as num?)?.toDouble(),
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      categoryModel: json['category'] == null
          ? null
          : CategoryModel.fromJson(json['category'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MemoryModelToJson(MemoryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'categoryId': instance.categoryId,
      'title': instance.title,
      'content': instance.content,
      'sourceType': _$SourceTypeEnumMap[instance.sourceType]!,
      'sourceUrl': instance.sourceUrl,
      'memoryMetadata': instance.memoryMetadata,
      'aiConfidence': instance.aiConfidence,
      'tags': instance.tags,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'category': instance.categoryModel,
    };

const _$SourceTypeEnumMap = {
  SourceType.text: 'text',
  SourceType.link: 'link',
  SourceType.image: 'image',
  SourceType.voice: 'voice',
};
