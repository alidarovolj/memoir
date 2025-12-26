// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'story_share_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StoryShareModelImpl _$$StoryShareModelImplFromJson(
  Map<String, dynamic> json,
) => _$StoryShareModelImpl(
  id: json['id'] as String,
  story_id: json['story_id'] as String,
  sender_id: json['sender_id'] as String,
  recipient_id: json['recipient_id'] as String,
  created_at: DateTime.parse(json['created_at'] as String),
  viewed_at: json['viewed_at'] == null
      ? null
      : DateTime.parse(json['viewed_at'] as String),
  sender: json['sender'] == null
      ? null
      : StoryUserModel.fromJson(json['sender'] as Map<String, dynamic>),
  recipient: json['recipient'] == null
      ? null
      : StoryUserModel.fromJson(json['recipient'] as Map<String, dynamic>),
  story: json['story'] == null
      ? null
      : StoryShareStoryModel.fromJson(json['story'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$StoryShareModelImplToJson(
  _$StoryShareModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'story_id': instance.story_id,
  'sender_id': instance.sender_id,
  'recipient_id': instance.recipient_id,
  'created_at': instance.created_at.toIso8601String(),
  'viewed_at': instance.viewed_at?.toIso8601String(),
  'sender': instance.sender,
  'recipient': instance.recipient,
  'story': instance.story,
};

_$StoryShareStoryModelImpl _$$StoryShareStoryModelImplFromJson(
  Map<String, dynamic> json,
) => _$StoryShareStoryModelImpl(
  id: json['id'] as String,
  user: json['user'] == null
      ? null
      : StoryUserModel.fromJson(json['user'] as Map<String, dynamic>),
  memory: json['memory'] == null
      ? null
      : StoryMemoryModel.fromJson(json['memory'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$StoryShareStoryModelImplToJson(
  _$StoryShareStoryModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'user': instance.user,
  'memory': instance.memory,
};

_$StoryShareListModelImpl _$$StoryShareListModelImplFromJson(
  Map<String, dynamic> json,
) => _$StoryShareListModelImpl(
  items: (json['items'] as List<dynamic>)
      .map((e) => StoryShareModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  total: (json['total'] as num).toInt(),
);

Map<String, dynamic> _$$StoryShareListModelImplToJson(
  _$StoryShareListModelImpl instance,
) => <String, dynamic>{'items': instance.items, 'total': instance.total};
