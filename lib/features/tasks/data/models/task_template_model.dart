import 'package:freezed_annotation/freezed_annotation.dart';

part 'task_template_model.freezed.dart';
part 'task_template_model.g.dart';

@freezed
class TaskTemplateModel with _$TaskTemplateModel {
  const factory TaskTemplateModel({
    required String id,
    required String name,
    String? description,
    String? icon,
    required bool isSystem,
    String? userId,
    required Map<String, dynamic> taskData,
    String? categoryId,
    String? categoryName,
    @Default(0) int usageCount,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _TaskTemplateModel;

  factory TaskTemplateModel.fromJson(Map<String, dynamic> json) =>
      _$TaskTemplateModelFromJson(json);
}

@freezed
class UseTemplateRequest with _$UseTemplateRequest {
  const factory UseTemplateRequest({
    DateTime? dueDate,
    String? scheduledTime,
    Map<String, dynamic>? customFields,
  }) = _UseTemplateRequest;

  factory UseTemplateRequest.fromJson(Map<String, dynamic> json) =>
      _$UseTemplateRequestFromJson(json);
}
