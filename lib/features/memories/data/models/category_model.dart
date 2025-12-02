import 'package:json_annotation/json_annotation.dart';
import 'package:memoir/features/memories/domain/entities/category.dart';

part 'category_model.g.dart';

@JsonSerializable()
class CategoryModel extends Category {
  const CategoryModel({
    required super.id,
    required super.name,
    required super.displayName,
    required super.icon,
    required super.color,
    required super.createdAt,
  });
  
  factory CategoryModel.fromJson(Map<String, dynamic> json) => _$CategoryModelFromJson(json);
  
  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);
  
  Category toEntity() {
    return Category(
      id: id,
      name: name,
      displayName: displayName,
      icon: icon,
      color: color,
      createdAt: createdAt,
    );
  }
}

