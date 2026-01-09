import 'package:freezed_annotation/freezed_annotation.dart';

part 'memory_reactions_model.freezed.dart';
part 'memory_reactions_model.g.dart';

enum ReactionType {
  @JsonValue('like')
  like,
  @JsonValue('love')
  love,
  @JsonValue('fire')
  fire,
  @JsonValue('star')
  star,
  @JsonValue('celebrate')
  celebrate,
  @JsonValue('thinking')
  thinking,
}

@freezed
class ReactionsSummary with _$ReactionsSummary {
  const factory ReactionsSummary({
    @Default(0) int like,
    @Default(0) int love,
    @Default(0) int fire,
    @Default(0) int star,
    @Default(0) int celebrate,
    @Default(0) int thinking,
    @Default(0) int total,
    ReactionType? userReaction,
  }) = _ReactionsSummary;

  factory ReactionsSummary.fromJson(Map<String, dynamic> json) =>
      _$ReactionsSummaryFromJson(json);
}

@freezed
class CommentAuthor with _$CommentAuthor {
  const factory CommentAuthor({
    required String userId,
    required String username,
  }) = _CommentAuthor;

  factory CommentAuthor.fromJson(Map<String, dynamic> json) =>
      _$CommentAuthorFromJson(json);
}

@freezed
class MemoryCommentModel with _$MemoryCommentModel {
  const factory MemoryCommentModel({
    required int id,
    required String memoryId,
    required CommentAuthor user,
    required String text,
    int? parentId,
    @Default(0) int repliesCount,
    required DateTime createdAt,
    required DateTime updatedAt,
    @Default(false) bool isEdited,
    @Default([]) List<MemoryCommentModel> replies,
  }) = _MemoryCommentModel;

  factory MemoryCommentModel.fromJson(Map<String, dynamic> json) =>
      _$MemoryCommentModelFromJson(json);
}
