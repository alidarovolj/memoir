import 'package:dio/dio.dart';
import 'package:memoir/features/tasks/data/models/task_group_model.dart';
import 'package:memoir/core/config/api_config.dart';
import 'dart:developer';

abstract class TaskGroupRemoteDataSource {
  Future<List<TaskGroupModel>> getTaskGroups();
  Future<TaskGroupModel> createTaskGroup(Map<String, dynamic> groupData);
  Future<TaskGroupModel> updateTaskGroup(String groupId, Map<String, dynamic> groupData);
  Future<void> deleteTaskGroup(String groupId);
}

class TaskGroupRemoteDataSourceImpl implements TaskGroupRemoteDataSource {
  final Dio dio;

  TaskGroupRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<TaskGroupModel>> getTaskGroups() async {
    try {
      final response = await dio.get('${ApiConfig.apiV1}/task-groups');

      final items = response.data['items'] as List;
      final groups = items.map((item) => TaskGroupModel.fromJson(item)).toList();

      log('📁 [TASK_GROUPS] Fetched ${groups.length} task groups');
      return groups;
    } catch (e, stackTrace) {
      log(
        '❌ [TASK_GROUPS] Error fetching task groups: $e',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  @override
  Future<TaskGroupModel> createTaskGroup(Map<String, dynamic> groupData) async {
    try {
      final response = await dio.post(
        '${ApiConfig.apiV1}/task-groups',
        data: groupData,
      );
      log('✅ [TASK_GROUPS] Task group created: ${response.data['id']}');
      return TaskGroupModel.fromJson(response.data);
    } catch (e) {
      log('❌ [TASK_GROUPS] Error creating task group: $e');
      rethrow;
    }
  }

  @override
  Future<TaskGroupModel> updateTaskGroup(
    String groupId,
    Map<String, dynamic> groupData,
  ) async {
    try {
      final response = await dio.put(
        '${ApiConfig.apiV1}/task-groups/$groupId',
        data: groupData,
      );
      log('✅ [TASK_GROUPS] Task group updated: $groupId');
      return TaskGroupModel.fromJson(response.data);
    } catch (e) {
      log('❌ [TASK_GROUPS] Error updating task group $groupId: $e');
      rethrow;
    }
  }

  @override
  Future<void> deleteTaskGroup(String groupId) async {
    try {
      await dio.delete('${ApiConfig.apiV1}/task-groups/$groupId');
      log('✅ [TASK_GROUPS] Task group deleted: $groupId');
    } catch (e) {
      log('❌ [TASK_GROUPS] Error deleting task group $groupId: $e');
      rethrow;
    }
  }
}
