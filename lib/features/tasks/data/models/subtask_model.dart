import 'package:freezed_annotation/freezed_annotation.dart';

part 'subtask_model.freezed.dart';
part 'subtask_model.g.dart';

@freezed
class SubtaskModel with _$SubtaskModel {
  const factory SubtaskModel({
    required String id,
    required String task_id,
    required String title,
    @Default(false) bool is_completed,
    @Default(0) int order,
    required DateTime created_at,
    required DateTime updated_at,
    DateTime? completed_at,
  }) = _SubtaskModel;

  factory SubtaskModel.fromJson(Map<String, dynamic> json) =>
      _$SubtaskModelFromJson(json);
}

@freezed
class SubtaskCreate with _$SubtaskCreate {
  const factory SubtaskCreate({
    required String title,
    @Default(false) bool is_completed,
    @Default(0) int order,
  }) = _SubtaskCreate;

  factory SubtaskCreate.fromJson(Map<String, dynamic> json) =>
      _$SubtaskCreateFromJson(json);
}

@freezed
class SubtaskUpdate with _$SubtaskUpdate {
  const factory SubtaskUpdate({String? title, bool? is_completed, int? order}) =
      _SubtaskUpdate;

  factory SubtaskUpdate.fromJson(Map<String, dynamic> json) =>
      _$SubtaskUpdateFromJson(json);
}
