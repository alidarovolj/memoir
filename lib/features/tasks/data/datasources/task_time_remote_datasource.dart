import 'package:dio/dio.dart';
import 'package:memoir/features/tasks/data/models/task_time_log_model.dart';
import 'package:memoir/core/config/api_config.dart';
import 'dart:developer';

abstract class TaskTimeRemoteDataSource {
  Future<TaskTimeLogModel> startTimeTracking(String taskId, {String? notes});
  Future<TaskTimeLogModel> stopTimeTracking(String taskId, {String? notes});
  Future<Map<String, dynamic>> getTaskTimeLogs(
    String taskId, {
    int page = 1,
    int pageSize = 50,
  });
  Future<TimeStatsResponse> getTimeStatistics({String period = 'month'});
  Future<TaskTimeLogModel> createTimeLogManual(
    String taskId,
    DateTime startTime,
    DateTime? endTime,
    String? notes,
  );
  Future<void> deleteTimeLog(String logId);
}

class TaskTimeRemoteDataSourceImpl implements TaskTimeRemoteDataSource {
  final Dio dio;

  TaskTimeRemoteDataSourceImpl({required this.dio});

  @override
  Future<TaskTimeLogModel> startTimeTracking(
    String taskId, {
    String? notes,
  }) async {
    try {
      log('⏱️ [TIME] Starting time tracking for task: $taskId');

      final response = await dio.post(
        '${ApiConfig.apiV1}/tasks/$taskId/time/start',
        data: {'notes': notes},
      );

      log('✅ [TIME] Time tracking started');
      return TaskTimeLogModel.fromJson(response.data);
    } catch (e) {
      log('❌ [TIME] Error starting time tracking: $e');
      rethrow;
    }
  }

  @override
  Future<TaskTimeLogModel> stopTimeTracking(
    String taskId, {
    String? notes,
  }) async {
    try {
      log('⏱️ [TIME] Stopping time tracking for task: $taskId');

      final response = await dio.post(
        '${ApiConfig.apiV1}/tasks/$taskId/time/stop',
        data: {'notes': notes},
      );

      log('✅ [TIME] Time tracking stopped');
      return TaskTimeLogModel.fromJson(response.data);
    } catch (e) {
      log('❌ [TIME] Error stopping time tracking: $e');
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> getTaskTimeLogs(
    String taskId, {
    int page = 1,
    int pageSize = 50,
  }) async {
    try {
      log('⏱️ [TIME] Fetching time logs for task: $taskId');

      final response = await dio.get(
        '${ApiConfig.apiV1}/tasks/$taskId/time/logs',
        queryParameters: {'skip': (page - 1) * pageSize, 'limit': pageSize},
      );

      log('✅ [TIME] Fetched ${response.data['total']} time logs');
      return response.data;
    } catch (e) {
      log('❌ [TIME] Error fetching time logs: $e');
      rethrow;
    }
  }

  @override
  Future<TimeStatsResponse> getTimeStatistics({String period = 'month'}) async {
    try {
      log('⏱️ [TIME] Fetching time statistics (period: $period)');

      final response = await dio.get(
        '${ApiConfig.apiV1}/tasks/time/stats',
        queryParameters: {'period': period},
      );

      log('✅ [TIME] Fetched time statistics');
      return TimeStatsResponse.fromJson(response.data);
    } catch (e) {
      log('❌ [TIME] Error fetching time statistics: $e');
      rethrow;
    }
  }

  @override
  Future<TaskTimeLogModel> createTimeLogManual(
    String taskId,
    DateTime startTime,
    DateTime? endTime,
    String? notes,
  ) async {
    try {
      log('⏱️ [TIME] Creating manual time log for task: $taskId');

      final response = await dio.post(
        '${ApiConfig.apiV1}/tasks/$taskId/time/logs',
        data: {
          'start_time': startTime.toIso8601String(),
          if (endTime != null) 'end_time': endTime.toIso8601String(),
          if (notes != null) 'notes': notes,
        },
      );

      log('✅ [TIME] Manual time log created');
      return TaskTimeLogModel.fromJson(response.data);
    } catch (e) {
      log('❌ [TIME] Error creating manual time log: $e');
      rethrow;
    }
  }

  @override
  Future<void> deleteTimeLog(String logId) async {
    try {
      log('⏱️ [TIME] Deleting time log: $logId');

      await dio.delete('${ApiConfig.apiV1}/time-logs/$logId');

      log('✅ [TIME] Time log deleted');
    } catch (e) {
      log('❌ [TIME] Error deleting time log: $e');
      rethrow;
    }
  }
}
