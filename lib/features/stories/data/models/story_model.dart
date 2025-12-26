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

    // Social features
    // ignore: non_constant_identifier_names
    @Default(0) int likes_count,
    // ignore: non_constant_identifier_names
    @Default(0) int comments_count,
    // ignore: non_constant_identifier_names
    @Default(0) int shares_count,
    // ignore: non_constant_identifier_names
    @Default(0) int reposts_count,
    // ignore: non_constant_identifier_names
    @Default(false) bool is_liked,

    // For reposts
    // ignore: non_constant_identifier_names
    StoryOriginalModel? original_story,
  }) = _StoryModel;

  factory StoryModel.fromJson(Map<String, dynamic> json) =>
      _$StoryModelFromJson(json);
}

@freezed
class StoryUserModel with _$StoryUserModel {
  // ignore: invalid_annotation_target
  const factory StoryUserModel({
    required String id,
    String? username,
    String? email,
    // ignore: non_constant_identifier_names
    String? first_name,
    // ignore: non_constant_identifier_names
    String? last_name,
    // ignore: non_constant_identifier_names
    String? avatar_url,
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

@freezed
class StoryOriginalModel with _$StoryOriginalModel {
  // ignore: invalid_annotation_target
  const factory StoryOriginalModel({required String id, StoryUserModel? user}) =
      _StoryOriginalModel;

  factory StoryOriginalModel.fromJson(Map<String, dynamic> json) =>
      _$StoryOriginalModelFromJson(json);
}
