import 'package:freezed_annotation/freezed_annotation.dart';

part 'story_model.freezed.dart';
part 'story_model.g.dart';

@freezed
class StoryModel with _$StoryModel {
  // ignore: invalid_annotation_target
  const factory StoryModel({
    required String id,
    // ignore: non_constant_identifier_names
    required String user_id,
    // ignore: non_constant_identifier_names
    required String memory_id,
    // ignore: non_constant_identifier_names
    required bool is_public,
    // ignore: non_constant_identifier_names
    required DateTime created_at,
    // ignore: non_constant_identifier_names
    required DateTime expires_at,
    StoryUserModel? user,
    StoryMemoryModel? memory,
  }) = _StoryModel;

  factory StoryModel.fromJson(Map<String, dynamic> json) =>
      _$StoryModelFromJson(json);
}

@freezed
class StoryUserModel with _$StoryUserModel {
  const factory StoryUserModel({
    required String id,
    String? username,
    String? email,
  }) = _StoryUserModel;

  factory StoryUserModel.fromJson(Map<String, dynamic> json) =>
      _$StoryUserModelFromJson(json);
}

@freezed
class StoryMemoryModel with _$StoryMemoryModel {
  // ignore: invalid_annotation_target
  const factory StoryMemoryModel({
    required String id,
    String? title,
    String? content,
    // ignore: non_constant_identifier_names
    String? image_url,
    // ignore: non_constant_identifier_names
    String? backdrop_url,
    // ignore: non_constant_identifier_names
    String? source_type,
  }) = _StoryMemoryModel;

  factory StoryMemoryModel.fromJson(Map<String, dynamic> json) =>
      _$StoryMemoryModelFromJson(json);
}

