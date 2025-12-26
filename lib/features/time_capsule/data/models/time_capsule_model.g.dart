// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_capsule_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TimeCapsuleModelImpl _$$TimeCapsuleModelImplFromJson(
  Map<String, dynamic> json,
) => _$TimeCapsuleModelImpl(
  id: json['id'] as String,
  userId: json['userId'] as String,
  title: json['title'] as String,
  content: json['content'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
  openDate: DateTime.parse(json['openDate'] as String),
  openedAt: json['openedAt'] == null
      ? null
      : DateTime.parse(json['openedAt'] as String),
  status: $enumDecode(_$CapsuleStatusEnumMap, json['status']),
  notificationSent: json['notificationSent'] as bool,
  isReadyToOpen: json['isReadyToOpen'] as bool,
  daysUntilOpen: (json['daysUntilOpen'] as num).toInt(),
);

Map<String, dynamic> _$$TimeCapsuleModelImplToJson(
  _$TimeCapsuleModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'title': instance.title,
  'content': instance.content,
  'createdAt': instance.createdAt.toIso8601String(),
  'openDate': instance.openDate.toIso8601String(),
  'openedAt': instance.openedAt?.toIso8601String(),
  'status': _$CapsuleStatusEnumMap[instance.status]!,
  'notificationSent': instance.notificationSent,
  'isReadyToOpen': instance.isReadyToOpen,
  'daysUntilOpen': instance.daysUntilOpen,
};

const _$CapsuleStatusEnumMap = {
  CapsuleStatus.sealed: 'SEALED',
  CapsuleStatus.opened: 'OPENED',
  CapsuleStatus.expired: 'EXPIRED',
};
