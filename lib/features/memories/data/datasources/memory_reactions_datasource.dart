import 'package:dio/dio.dart';
import 'package:memoir/core/network/dio_client.dart';
import 'package:memoir/features/memories/data/models/memory_reactions_model.dart';

class MemoryReactionsDataSource {
  final Dio _dio;

  MemoryReactionsDataSource(DioClient dioClient) : _dio = DioClient.instance;

  /// Add reaction to memory
  Future<ReactionsSummary> addReaction({
    required String memoryId,
    required ReactionType reactionType,
  }) async {
    try {
      final response = await _dio.post(
        '/api/v1/memories/reactions',
        data: {'memory_id': memoryId, 'reaction_type': reactionType.name},
      );
      final data = response.data as Map<String, dynamic>;
      return ReactionsSummary.fromJson(
        data['reactions_summary'] as Map<String, dynamic>,
      );
    } catch (e) {
      throw Exception('Failed to add reaction: $e');
    }
  }

  /// Remove reaction from memory
  Future<ReactionsSummary> removeReaction(String memoryId) async {
    try {
      final response = await _dio.delete(
        '/api/v1/memories/reactions',
        data: {'memory_id': memoryId},
      );
      final data = response.data as Map<String, dynamic>;
      return ReactionsSummary.fromJson(
        data['reactions_summary'] as Map<String, dynamic>,
      );
    } catch (e) {
      throw Exception('Failed to remove reaction: $e');
    }
  }

  /// Get reactions summary
  Future<ReactionsSummary> getReactions(String memoryId) async {
    try {
      final response = await _dio.get('/api/v1/memories/$memoryId/reactions');
      return ReactionsSummary.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      throw Exception('Failed to get reactions: $e');
    }
  }

  /// Add comment
  Future<MemoryCommentModel> addComment({
    required String memoryId,
    required String text,
    int? parentId,
  }) async {
    try {
      final response = await _dio.post(
        '/api/v1/memories/comments',
        data: {
          'memory_id': memoryId,
          'text': text,
          if (parentId != null) 'parent_id': parentId,
        },
      );
      final data = response.data as Map<String, dynamic>;
      return MemoryCommentModel.fromJson(
        data['comment'] as Map<String, dynamic>,
      );
    } catch (e) {
      throw Exception('Failed to add comment: $e');
    }
  }

  /// Get comments
  Future<List<MemoryCommentModel>> getComments(String memoryId) async {
    try {
      final response = await _dio.get('/api/v1/memories/$memoryId/comments');
      final data = response.data as Map<String, dynamic>;
      final comments = data['comments'] as List;
      return comments
          .map(
            (json) => MemoryCommentModel.fromJson(json as Map<String, dynamic>),
          )
          .toList();
    } catch (e) {
      throw Exception('Failed to get comments: $e');
    }
  }

  /// Delete comment
  Future<void> deleteComment(int commentId) async {
    try {
      await _dio.delete('/api/v1/memories/comments/$commentId');
    } catch (e) {
      throw Exception('Failed to delete comment: $e');
    }
  }
}
