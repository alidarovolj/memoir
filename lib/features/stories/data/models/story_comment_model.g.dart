// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'story_comment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StoryCommentModelImpl _$$StoryCommentModelImplFromJson(
  Map<String, dynamic> json,
) => _$StoryCommentModelImpl(
  id: json['id'] as String,
  story_id: json['story_id'] as String,
  user_id: json['user_id'] as String,
  content: json['content'] as String,
  created_at: DateTime.parse(json['created_at'] as String),
  updated_at: json['updated_at'] == null
      ? null
      : DateTime.parse(json['updated_at'] as String),
  user: json['user'] == null
      ? null
      : StoryUserModel.fromJson(json['user'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$StoryCommentModelImplToJson(
  _$StoryCommentModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'story_id': instance.story_id,
  'user_id': instance.user_id,
  'content': instance.content,
  'created_at': instance.created_at.toIso8601String(),
  'updated_at': instance.updated_at?.toIso8601String(),
  'user': instance.user,
};

_$StoryCommentListModelImpl _$$StoryCommentListModelImplFromJson(
  Map<String, dynamic> json,
) => _$StoryCommentListModelImpl(
  items: (json['items'] as List<dynamic>)
      .map((e) => StoryCommentModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  total: (json['total'] as num).toInt(),
);

Map<String, dynamic> _$$StoryCommentListModelImplToJson(
  _$StoryCommentListModelImpl instance,
) => <String, dynamic>{'items': instance.items, 'total': instance.total};
