// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_group_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TaskGroupModelImpl _$$TaskGroupModelImplFromJson(Map<String, dynamic> json) =>
    _$TaskGroupModelImpl(
      id: json['id'] as String,
      user_id: json['user_id'] as String,
      name: json['name'] as String,
      color: json['color'] as String,
      icon: json['icon'] as String,
      notification_enabled: json['notification_enabled'] as String,
      order_index: (json['order_index'] as num).toInt(),
      created_at: DateTime.parse(json['created_at'] as String),
      updated_at: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$$TaskGroupModelImplToJson(
  _$TaskGroupModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'user_id': instance.user_id,
  'name': instance.name,
  'color': instance.color,
  'icon': instance.icon,
  'notification_enabled': instance.notification_enabled,
  'order_index': instance.order_index,
  'created_at': instance.created_at.toIso8601String(),
  'updated_at': instance.updated_at.toIso8601String(),
};
