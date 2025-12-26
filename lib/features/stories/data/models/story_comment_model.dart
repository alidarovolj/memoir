import 'package:freezed_annotation/freezed_annotation.dart';
import 'story_model.dart';

part 'story_comment_model.freezed.dart';
part 'story_comment_model.g.dart';

@freezed
class StoryCommentModel with _$StoryCommentModel {
  // ignore: invalid_annotation_target
  const factory StoryCommentModel({
    required String id,
    // ignore: non_constant_identifier_names
    required String story_id,
    // ignore: non_constant_identifier_names
    required String user_id,
    required String content,
    // ignore: non_constant_identifier_names
    required DateTime created_at,
    // ignore: non_constant_identifier_names
    DateTime? updated_at,
    StoryUserModel? user,
  }) = _StoryCommentModel;

  factory StoryCommentModel.fromJson(Map<String, dynamic> json) =>
      _$StoryCommentModelFromJson(json);
}

@freezed
class StoryCommentListModel with _$StoryCommentListModel {
  const factory StoryCommentListModel({
    required List<StoryCommentModel> items,
    required int total,
  }) = _StoryCommentListModel;

  factory StoryCommentListModel.fromJson(Map<String, dynamic> json) =>
      _$StoryCommentListModelFromJson(json);
}
