import 'package:freezed_annotation/freezed_annotation.dart';

part 'task_group_model.freezed.dart';
part 'task_group_model.g.dart';

@freezed
class TaskGroupModel with _$TaskGroupModel {
  const factory TaskGroupModel({
    required String id,
    required String user_id,
    required String name,
    required String color,
    required String icon,
    required String notification_enabled,
    required int order_index,
    required DateTime created_at,
    required DateTime updated_at,
  }) = _TaskGroupModel;

  factory TaskGroupModel.fromJson(Map<String, dynamic> json) =>
      _$TaskGroupModelFromJson(json);
}
