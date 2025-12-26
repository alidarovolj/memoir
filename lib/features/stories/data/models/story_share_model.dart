import 'package:freezed_annotation/freezed_annotation.dart';
import 'story_model.dart';

part 'story_share_model.freezed.dart';
part 'story_share_model.g.dart';

@freezed
class StoryShareModel with _$StoryShareModel {
  // ignore: invalid_annotation_target
  const factory StoryShareModel({
    required String id,
    // ignore: non_constant_identifier_names
    required String story_id,
    // ignore: non_constant_identifier_names
    required String sender_id,
    // ignore: non_constant_identifier_names
    required String recipient_id,
    // ignore: non_constant_identifier_names
    required DateTime created_at,
    // ignore: non_constant_identifier_names
    DateTime? viewed_at,
    StoryUserModel? sender,
    StoryUserModel? recipient,
    StoryShareStoryModel? story,
  }) = _StoryShareModel;

  factory StoryShareModel.fromJson(Map<String, dynamic> json) =>
      _$StoryShareModelFromJson(json);
}

@freezed
class StoryShareStoryModel with _$StoryShareStoryModel {
  const factory StoryShareStoryModel({
    required String id,
    StoryUserModel? user,
    StoryMemoryModel? memory,
  }) = _StoryShareStoryModel;

  factory StoryShareStoryModel.fromJson(Map<String, dynamic> json) =>
      _$StoryShareStoryModelFromJson(json);
}

@freezed
class StoryShareListModel with _$StoryShareListModel {
  const factory StoryShareListModel({
    required List<StoryShareModel> items,
    required int total,
  }) = _StoryShareListModel;

  factory StoryShareListModel.fromJson(Map<String, dynamic> json) =>
      _$StoryShareListModelFromJson(json);
}
