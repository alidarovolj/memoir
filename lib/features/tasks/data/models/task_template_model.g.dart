// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_template_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TaskTemplateModelImpl _$$TaskTemplateModelImplFromJson(
  Map<String, dynamic> json,
) => _$TaskTemplateModelImpl(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String?,
  icon: json['icon'] as String?,
  isSystem: json['isSystem'] as bool,
  userId: json['userId'] as String?,
  taskData: json['taskData'] as Map<String, dynamic>,
  categoryId: json['categoryId'] as String?,
  categoryName: json['categoryName'] as String?,
  usageCount: (json['usageCount'] as num?)?.toInt() ?? 0,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$$TaskTemplateModelImplToJson(
  _$TaskTemplateModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': instance.description,
  'icon': instance.icon,
  'isSystem': instance.isSystem,
  'userId': instance.userId,
  'taskData': instance.taskData,
  'categoryId': instance.categoryId,
  'categoryName': instance.categoryName,
  'usageCount': instance.usageCount,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
};

_$UseTemplateRequestImpl _$$UseTemplateRequestImplFromJson(
  Map<String, dynamic> json,
) => _$UseTemplateRequestImpl(
  dueDate: json['dueDate'] == null
      ? null
      : DateTime.parse(json['dueDate'] as String),
  scheduledTime: json['scheduledTime'] as String?,
  customFields: json['customFields'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$$UseTemplateRequestImplToJson(
  _$UseTemplateRequestImpl instance,
) => <String, dynamic>{
  'dueDate': instance.dueDate?.toIso8601String(),
  'scheduledTime': instance.scheduledTime,
  'customFields': instance.customFields,
};
