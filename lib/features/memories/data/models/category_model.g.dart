// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryModel _$CategoryModelFromJson(Map<String, dynamic> json) =>
    CategoryModel(
      id: json['id'] as String,
      name: json['name'] as String,
      displayName: json['displayName'] as String,
      icon: json['icon'] as String,
      color: json['color'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$CategoryModelToJson(CategoryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'displayName': instance.displayName,
      'icon': instance.icon,
      'color': instance.color,
      'createdAt': instance.createdAt.toIso8601String(),
    };
