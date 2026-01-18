import 'package:dio/dio.dart';
import 'package:memoir/core/network/dio_client.dart';
import 'package:memoir/features/memories/data/models/memory_sharing_model.dart';

class MemorySharingDataSource {
  final Dio _dio;

  MemorySharingDataSource(DioClient dioClient) : _dio = DioClient.instance;

  /// Share memory with specific users
  Future<Map<String, dynamic>> shareMemory({
    required String memoryId,
    required List<String> userIds,
    bool canComment = true,
    bool canReact = true,
  }) async {
    try {
      final response = await _dio.post(
        '/api/v1/memories/sharing/share',
        data: {
          'memory_id': memoryId,
          'user_ids': userIds,
          'can_comment': canComment,
          'can_react': canReact,
        },
      );
      return response.data as Map<String, dynamic>;
    } catch (e) {
      throw Exception('Failed to share memory: $e');
    }
  }

  /// Unshare memory from specific users
  Future<Map<String, dynamic>> unshareMemory({
    required String memoryId,
    required List<String> userIds,
  }) async {
    try {
      final response = await _dio.post(
        '/api/v1/memories/sharing/unshare',
        data: {'memory_id': memoryId, 'user_ids': userIds},
      );
      return response.data as Map<String, dynamic>;
    } catch (e) {
      throw Exception('Failed to unshare memory: $e');
    }
  }

  /// Update memory privacy level
  Future<Map<String, dynamic>> updatePrivacy({
    required String memoryId,
    required PrivacyLevel privacyLevel,
  }) async {
    try {
      final response = await _dio.put(
        '/api/v1/memories/sharing/privacy',
        data: {
          'memory_id': memoryId,
          'privacy_level': privacyLevel.name.replaceAll(
            'friendsOnly',
            'friends_only',
          ),
        },
      );
      return response.data as Map<String, dynamic>;
    } catch (e) {
      throw Exception('Failed to update privacy: $e');
    }
  }

  /// Get memory share info
  Future<MemoryShareInfo> getShareInfo(String memoryId) async {
    try {
      final response = await _dio.get(
        '/api/v1/memories/sharing/$memoryId/info',
      );
      return MemoryShareInfo.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      throw Exception('Failed to get share info: $e');
    }
  }

  /// Get memories shared with current user
  Future<List<SharedMemoryItem>> getSharedMemories() async {
    try {
      final response = await _dio.get('/api/v1/memories/sharing/received');
      final data = response.data as Map<String, dynamic>;
      final memories = data['memories'] as List;
      return memories
          .map(
            (json) => SharedMemoryItem.fromJson(json as Map<String, dynamic>),
          )
          .toList();
    } catch (e) {
      throw Exception('Failed to load shared memories: $e');
    }
  }
}
