import 'package:dio/dio.dart';
import 'package:memoir/core/network/dio_client.dart';
import 'package:memoir/features/time_capsule/data/models/time_capsule_model.dart';
import 'package:memoir/features/memories/data/models/memory_model.dart';

/// Remote datasource for Time Capsules
abstract class TimeCapsuleRemoteDataSource {
  /// Get throwback memory (N years ago)
  Future<MemoryModel?> getThrowbackMemory({int yearsAgo = 1});

  /// Create time capsule
  Future<TimeCapsuleModel> createTimeCapsule({
    required String title,
    required String content,
    required DateTime openDate,
  });

  /// Get list of time capsules
  Future<List<TimeCapsuleModel>> getTimeCapsules({
    CapsuleStatus? status,
    int page = 1,
    int size = 20,
  });

  /// Get ready to open capsules
  Future<List<TimeCapsuleModel>> getReadyCapsules();

  /// Get capsule by ID
  Future<TimeCapsuleModel> getTimeCapsule(String id);

  /// Open time capsule
  Future<TimeCapsuleModel> openTimeCapsule(String id);

  /// Update time capsule
  Future<TimeCapsuleModel> updateTimeCapsule(
    String id, {
    String? title,
    String? content,
    DateTime? openDate,
  });

  /// Delete time capsule
  Future<void> deleteTimeCapsule(String id);
}

/// Implementation of TimeCapsuleRemoteDataSource
class TimeCapsuleRemoteDataSourceImpl implements TimeCapsuleRemoteDataSource {
  final Dio dio;

  TimeCapsuleRemoteDataSourceImpl({required this.dio});

  @override
  Future<MemoryModel?> getThrowbackMemory({int yearsAgo = 1}) async {
    try {
      final response = await dio.get(
        '/api/v1/memories/throwback',
        queryParameters: {'years_ago': yearsAgo},
      );

      if (response.statusCode == 200) {
        return MemoryModel.fromJson(response.data);
      }
      return null;
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        return null; // No memory found
      }
      rethrow;
    }
  }

  @override
  Future<TimeCapsuleModel> createTimeCapsule({
    required String title,
    required String content,
    required DateTime openDate,
  }) async {
    final response = await dio.post(
      '/api/v1/time-capsules',
      data: {
        'title': title,
        'content': content,
        'open_date': openDate.toIso8601String(),
      },
    );

    return TimeCapsuleModel.fromJson(response.data);
  }

  @override
  Future<List<TimeCapsuleModel>> getTimeCapsules({
    CapsuleStatus? status,
    int page = 1,
    int size = 20,
  }) async {
    final queryParams = <String, dynamic>{'page': page, 'size': size};

    if (status != null) {
      queryParams['status'] = status.name.toUpperCase();
    }

    final response = await dio.get(
      '/api/v1/time-capsules',
      queryParameters: queryParams,
    );

    final items = response.data['items'] as List;
    return items.map((json) => TimeCapsuleModel.fromJson(json)).toList();
  }

  @override
  Future<List<TimeCapsuleModel>> getReadyCapsules() async {
    final response = await dio.get('/api/v1/time-capsules/ready');

    final items = response.data as List;
    return items.map((json) => TimeCapsuleModel.fromJson(json)).toList();
  }

  @override
  Future<TimeCapsuleModel> getTimeCapsule(String id) async {
    final response = await dio.get('/api/v1/time-capsules/$id');
    return TimeCapsuleModel.fromJson(response.data);
  }

  @override
  Future<TimeCapsuleModel> openTimeCapsule(String id) async {
    final response = await dio.post('/api/v1/time-capsules/$id/open');
    return TimeCapsuleModel.fromJson(response.data);
  }

  @override
  Future<TimeCapsuleModel> updateTimeCapsule(
    String id, {
    String? title,
    String? content,
    DateTime? openDate,
  }) async {
    final data = <String, dynamic>{};
    if (title != null) data['title'] = title;
    if (content != null) data['content'] = content;
    if (openDate != null) data['open_date'] = openDate.toIso8601String();

    final response = await dio.patch('/api/v1/time-capsules/$id', data: data);

    return TimeCapsuleModel.fromJson(response.data);
  }

  @override
  Future<void> deleteTimeCapsule(String id) async {
    await dio.delete('/api/v1/time-capsules/$id');
  }
}
