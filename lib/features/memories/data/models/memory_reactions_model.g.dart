// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'memory_reactions_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReactionsSummaryImpl _$$ReactionsSummaryImplFromJson(
  Map<String, dynamic> json,
) => _$ReactionsSummaryImpl(
  like: (json['like'] as num?)?.toInt() ?? 0,
  love: (json['love'] as num?)?.toInt() ?? 0,
  fire: (json['fire'] as num?)?.toInt() ?? 0,
  star: (json['star'] as num?)?.toInt() ?? 0,
  celebrate: (json['celebrate'] as num?)?.toInt() ?? 0,
  thinking: (json['thinking'] as num?)?.toInt() ?? 0,
  total: (json['total'] as num?)?.toInt() ?? 0,
  userReaction: $enumDecodeNullable(
    _$ReactionTypeEnumMap,
    json['userReaction'],
  ),
);

Map<String, dynamic> _$$ReactionsSummaryImplToJson(
  _$ReactionsSummaryImpl instance,
) => <String, dynamic>{
  'like': instance.like,
  'love': instance.love,
  'fire': instance.fire,
  'star': instance.star,
  'celebrate': instance.celebrate,
  'thinking': instance.thinking,
  'total': instance.total,
  'userReaction': _$ReactionTypeEnumMap[instance.userReaction],
};

const _$ReactionTypeEnumMap = {
  ReactionType.like: 'like',
  ReactionType.love: 'love',
  ReactionType.fire: 'fire',
  ReactionType.star: 'star',
  ReactionType.celebrate: 'celebrate',
  ReactionType.thinking: 'thinking',
};

_$CommentAuthorImpl _$$CommentAuthorImplFromJson(Map<String, dynamic> json) =>
    _$CommentAuthorImpl(
      userId: json['userId'] as String,
      username: json['username'] as String,
    );

Map<String, dynamic> _$$CommentAuthorImplToJson(_$CommentAuthorImpl instance) =>
    <String, dynamic>{'userId': instance.userId, 'username': instance.username};

_$MemoryCommentModelImpl _$$MemoryCommentModelImplFromJson(
  Map<String, dynamic> json,
) => _$MemoryCommentModelImpl(
  id: (json['id'] as num).toInt(),
  memoryId: json['memoryId'] as String,
  user: CommentAuthor.fromJson(json['user'] as Map<String, dynamic>),
  text: json['text'] as String,
  parentId: (json['parentId'] as num?)?.toInt(),
  repliesCount: (json['repliesCount'] as num?)?.toInt() ?? 0,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  isEdited: json['isEdited'] as bool? ?? false,
  replies:
      (json['replies'] as List<dynamic>?)
          ?.map((e) => MemoryCommentModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$$MemoryCommentModelImplToJson(
  _$MemoryCommentModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'memoryId': instance.memoryId,
  'user': instance.user,
  'text': instance.text,
  'parentId': instance.parentId,
  'repliesCount': instance.repliesCount,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
  'isEdited': instance.isEdited,
  'replies': instance.replies,
};
