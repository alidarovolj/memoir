import 'package:dio/dio.dart';
import 'package:memoir/features/tasks/data/models/task_model.dart';
import 'package:memoir/features/tasks/data/models/task_suggestion_model.dart';
import 'package:memoir/features/tasks/data/models/subtask_model.dart';
import 'package:memoir/core/config/api_config.dart';
import 'dart:developer';

abstract class TaskRemoteDataSource {
  Future<Map<String, dynamic>> getTasks({
    TaskStatus? status,
    TimeScope? timeScope,
    TaskPriority? priority,
    String? categoryId,
    DateTime? date,
    int page = 1,
    int pageSize = 50,
  });

  Future<TaskModel> getTask(String taskId);
  Future<TaskModel> createTask(Map<String, dynamic> taskData);
  Future<TaskModel> updateTask(String taskId, Map<String, dynamic> taskData);
  Future<void> completeTask(String taskId);
  Future<void> uncompleteTask(String taskId);
  Future<void> deleteTask(String taskId);
  Future<Map<String, dynamic>> generateRecurringInstances(
    String taskId, {
    int daysAhead = 7,
  });
  Future<Map<String, dynamic>> analyzeTask(String title);
  Future<Map<String, dynamic>> analyzeHabit(String title, {int? subtasksCount});
  Future<Map<String, dynamic>> createHabitWithSubtasks(
    Map<String, dynamic> habitData,
  );
  Future<List<TaskSuggestionModel>> getSuggestedTasksFromMemory(
    String memoryId,
  );
  Future<Map<String, dynamic>> convertTaskToMemory(
    String taskId,
    Map<String, dynamic> conversionData,
  );

  // Subtasks
  Future<List<SubtaskModel>> getSubtasks(String taskId);
  Future<SubtaskModel> createSubtask(
    String taskId,
    Map<String, dynamic> subtaskData,
  );
  Future<SubtaskModel> updateSubtask(
    String taskId,
    String subtaskId,
    Map<String, dynamic> updates,
  );
  Future<void> deleteSubtask(String taskId, String subtaskId);
}

class TaskRemoteDataSourceImpl implements TaskRemoteDataSource {
  final Dio dio;

  TaskRemoteDataSourceImpl({required this.dio});

  @override
  Future<Map<String, dynamic>> getTasks({
    TaskStatus? status,
    TimeScope? timeScope,
    TaskPriority? priority,
    String? categoryId,
    DateTime? date,
    int page = 1,
    int pageSize = 50,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'page': page,
        'page_size': pageSize,
      };

      if (status != null) {
        queryParams['status'] = _statusToString(status);
      }
      if (timeScope != null) {
        queryParams['time_scope'] = _timeScopeToString(timeScope);
      }
      if (priority != null) {
        queryParams['priority'] = _priorityToString(priority);
      }
      if (categoryId != null) {
        queryParams['category_id'] = categoryId;
      }
      if (date != null) {
        // Format date as YYYY-MM-DD
        queryParams['date'] = 
            '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
      }

      final response = await dio.get(
        ApiConfig.tasks,
        queryParameters: queryParams,
      );

      log('📋 [TASKS] Fetched ${response.data['items'].length} tasks for date: ${date != null ? queryParams['date'] : 'all'}');
      
      // Логируем подзадачи для отладки
      for (var item in response.data['items']) {
        final subtasks = item['subtasks'] as List?;
        if (subtasks != null && subtasks.isNotEmpty) {
          log('📝 [TASKS] Task "${item['title']}" has ${subtasks.length} subtasks: ${subtasks.map((s) => s['title']).join(", ")}');
        }
      }
      
      return response.data;
    } catch (e, stackTrace) {
      log(
        '❌ [TASKS] Error fetching tasks: $e',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  @override
  Future<TaskModel> getTask(String taskId) async {
    try {
      final response = await dio.get('${ApiConfig.tasks}/$taskId');
      return TaskModel.fromJson(response.data);
    } catch (e) {
      log('❌ [TASKS] Error fetching task $taskId: $e');
      rethrow;
    }
  }

  @override
  Future<TaskModel> createTask(Map<String, dynamic> taskData) async {
    try {
      final response = await dio.post(ApiConfig.tasks, data: taskData);
      log('✅ [TASKS] Task created: ${response.data['id']}');
      return TaskModel.fromJson(response.data);
    } catch (e) {
      log('❌ [TASKS] Error creating task: $e');
      rethrow;
    }
  }

  @override
  Future<TaskModel> updateTask(
    String taskId,
    Map<String, dynamic> taskData,
  ) async {
    try {
      final response = await dio.put(
        '${ApiConfig.tasks}/$taskId',
        data: taskData,
      );
      log('✅ [TASKS] Task updated: $taskId');
      return TaskModel.fromJson(response.data);
    } catch (e) {
      log('❌ [TASKS] Error updating task $taskId: $e');
      rethrow;
    }
  }

  @override
  Future<void> completeTask(String taskId) async {
    try {
      await dio.post('${ApiConfig.tasks}/$taskId/complete');
      log('✅ [TASKS] Task completed: $taskId');
    } catch (e) {
      log('❌ [TASKS] Error completing task $taskId: $e');
      rethrow;
    }
  }

  @override
  Future<void> uncompleteTask(String taskId) async {
    try {
      await dio.post('${ApiConfig.tasks}/$taskId/uncomplete');
      log('✅ [TASKS] Task uncompleted: $taskId');
    } catch (e) {
      log('❌ [TASKS] Error uncompleting task $taskId: $e');
      rethrow;
    }
  }

  @override
  Future<void> deleteTask(String taskId) async {
    try {
      await dio.delete('${ApiConfig.tasks}/$taskId');
      log('✅ [TASKS] Task deleted: $taskId');
    } catch (e) {
      log('❌ [TASKS] Error deleting task $taskId: $e');
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> generateRecurringInstances(
    String taskId, {
    int daysAhead = 7,
  }) async {
    try {
      final response = await dio.post(
        '${ApiConfig.tasks}/$taskId/generate-instances',
        queryParameters: {'days_ahead': daysAhead},
      );
      log('✅ [TASKS] Generated recurring instances for task: $taskId');
      return response.data;
    } catch (e) {
      log('❌ [TASKS] Error generating recurring instances: $e');
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> analyzeTask(String title) async {
    try {
      final response = await dio.post(
        ApiConfig.tasksAnalyze,
        data: {'title': title},
      );
      log('✨ [TASKS_AI] Task analyzed: ${response.data}');
      return response.data;
    } catch (e) {
      log('❌ [TASKS_AI] Error analyzing task: $e');
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> analyzeHabit(String title, {int? subtasksCount}) async {
    try {
      final data = <String, dynamic>{'title': title};
      if (subtasksCount != null) {
        data['subtasks_count'] = subtasksCount;
      }
      final response = await dio.post(
        '${ApiConfig.tasksAI}/analyze-habit',
        data: data,
      );
      log('✨ [HABIT_AI] Habit analyzed: ${response.data}');
      return response.data;
    } catch (e) {
      log('❌ [HABIT_AI] Error analyzing habit: $e');
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> createHabitWithSubtasks(
    Map<String, dynamic> habitData,
  ) async {
    try {
      final response = await dio.post(
        '${ApiConfig.tasks}/create-habit',
        data: habitData,
      );
      log('✅ [HABIT] Habit created with ${response.data['subtasks_created']} subtasks');
      return response.data;
    } catch (e) {
      log('❌ [HABIT] Error creating habit: $e');
      rethrow;
    }
  }

  String _statusToString(TaskStatus status) {
    switch (status) {
      case TaskStatus.pending:
        return 'pending';
      case TaskStatus.inProgress:
        return 'in_progress';
      case TaskStatus.completed:
        return 'completed';
      case TaskStatus.cancelled:
        return 'cancelled';
    }
  }

  String _timeScopeToString(TimeScope scope) {
    switch (scope) {
      case TimeScope.daily:
        return 'daily';
      case TimeScope.weekly:
        return 'weekly';
      case TimeScope.monthly:
        return 'monthly';
      case TimeScope.longTerm:
        return 'long_term';
    }
  }

  String _priorityToString(TaskPriority priority) {
    switch (priority) {
      case TaskPriority.low:
        return 'low';
      case TaskPriority.medium:
        return 'medium';
      case TaskPriority.high:
        return 'high';
      case TaskPriority.urgent:
        return 'urgent';
    }
  }

  @override
  Future<List<TaskSuggestionModel>> getSuggestedTasksFromMemory(
    String memoryId,
  ) async {
    try {
      final response = await dio.post(
        '${ApiConfig.tasksAI}/memories/$memoryId/suggest-tasks',
      );

      final suggestions = (response.data as List)
          .map((json) => TaskSuggestionModel.fromJson(json))
          .toList();

      log(
        '✨ [TASKS_AI] Got ${suggestions.length} suggestions for memory $memoryId',
      );
      return suggestions;
    } catch (e) {
      log('❌ [TASKS_AI] Error getting suggestions: $e');
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> convertTaskToMemory(
    String taskId,
    Map<String, dynamic> conversionData,
  ) async {
    try {
      final response = await dio.post(
        '${ApiConfig.tasks}/$taskId/convert-to-memory',
        data: conversionData,
      );

      log('✅ [TASKS] Task converted to memory: $taskId');
      return response.data;
    } catch (e) {
      log('❌ [TASKS] Error converting task to memory: $e');
      rethrow;
    }
  }

  @override
  Future<List<SubtaskModel>> getSubtasks(String taskId) async {
    try {
      final response = await dio.get('${ApiConfig.tasks}/$taskId/subtasks');

      final subtasks = (response.data as List)
          .map((json) => SubtaskModel.fromJson(json))
          .toList();

      log('✅ [SUBTASKS] Fetched ${subtasks.length} subtasks for task $taskId');
      return subtasks;
    } catch (e) {
      log('❌ [SUBTASKS] Error fetching subtasks: $e');
      rethrow;
    }
  }

  @override
  Future<SubtaskModel> createSubtask(
    String taskId,
    Map<String, dynamic> subtaskData,
  ) async {
    try {
      final response = await dio.post(
        '${ApiConfig.tasks}/$taskId/subtasks',
        data: subtaskData,
      );

      final subtask = SubtaskModel.fromJson(response.data);
      log('✅ [SUBTASKS] Created subtask: ${subtask.title}');
      return subtask;
    } catch (e) {
      log('❌ [SUBTASKS] Error creating subtask: $e');
      rethrow;
    }
  }

  @override
  Future<SubtaskModel> updateSubtask(
    String taskId,
    String subtaskId,
    Map<String, dynamic> updates,
  ) async {
    try {
      final response = await dio.patch(
        '${ApiConfig.tasks}/$taskId/subtasks/$subtaskId',
        data: updates,
      );

      final subtask = SubtaskModel.fromJson(response.data);
      log('✅ [SUBTASKS] Updated subtask: ${subtask.id}');
      return subtask;
    } catch (e) {
      log('❌ [SUBTASKS] Error updating subtask: $e');
      rethrow;
    }
  }

  @override
  Future<void> deleteSubtask(String taskId, String subtaskId) async {
    try {
      await dio.delete('${ApiConfig.tasks}/$taskId/subtasks/$subtaskId');

      log('✅ [SUBTASKS] Deleted subtask: $subtaskId');
    } catch (e) {
      log('❌ [SUBTASKS] Error deleting subtask: $e');
      rethrow;
    }
  }
}
