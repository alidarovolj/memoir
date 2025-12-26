import 'package:freezed_annotation/freezed_annotation.dart';
import 'story_model.dart';

part 'story_like_model.freezed.dart';
part 'story_like_model.g.dart';

@freezed
class StoryLikeModel with _$StoryLikeModel {
  // ignore: invalid_annotation_target
  const factory StoryLikeModel({
    required String id,
    // ignore: non_constant_identifier_names
    required String story_id,
    // ignore: non_constant_identifier_names
    required String user_id,
    // ignore: non_constant_identifier_names
    required DateTime created_at,
    StoryUserModel? user,
  }) = _StoryLikeModel;

  factory StoryLikeModel.fromJson(Map<String, dynamic> json) =>
      _$StoryLikeModelFromJson(json);
}

@freezed
class StoryLikeListModel with _$StoryLikeListModel {
  const factory StoryLikeListModel({
    required List<StoryLikeModel> items,
    required int total,
  }) = _StoryLikeListModel;

  factory StoryLikeListModel.fromJson(Map<String, dynamic> json) =>
      _$StoryLikeListModelFromJson(json);
}
