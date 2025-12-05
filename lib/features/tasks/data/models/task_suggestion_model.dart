import 'package:freezed_annotation/freezed_annotation.dart';

part 'task_suggestion_model.freezed.dart';
part 'task_suggestion_model.g.dart';

@freezed
class TaskSuggestionModel with _$TaskSuggestionModel {
  const factory TaskSuggestionModel({
    required String title,
    required String description,
    @JsonKey(name: 'time_scope') required String timeScope,
    required String priority,
    required double confidence,
    required String reasoning,
    String? category,
  }) = _TaskSuggestionModel;

  factory TaskSuggestionModel.fromJson(Map<String, dynamic> json) =>
      _$TaskSuggestionModelFromJson(json);
}
