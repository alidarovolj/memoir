import 'package:dio/dio.dart';
import 'package:memoir/features/stories/data/models/story_model.dart';
import 'package:memoir/features/stories/data/models/story_comment_model.dart';
import 'package:memoir/features/stories/data/models/story_like_model.dart';
import 'package:memoir/features/stories/data/models/story_share_model.dart';

abstract class StoryRemoteDataSource {
  Future<List<StoryModel>> getPublicStories();
  Future<List<StoryModel>> getMyStories();
  Future<void> createStory(String memoryId, bool isPublic);
  Future<void> deleteStory(String storyId);

  // Likes
  Future<void> likeStory(String storyId);
  Future<void> unlikeStory(String storyId);
  Future<StoryLikeListModel> getStoryLikes(
    String storyId, {
    int skip = 0,
    int limit = 50,
  });

  // Comments
  Future<StoryCommentModel> createComment(String storyId, String content);
  Future<StoryCommentModel> updateComment(String commentId, String content);
  Future<void> deleteComment(String commentId);
  Future<StoryCommentListModel> getStoryComments(
    String storyId, {
    int skip = 0,
    int limit = 50,
  });

  // Shares
  Future<void> shareStory(String storyId, String recipientId);
  Future<StoryShareListModel> getReceivedShares({int skip = 0, int limit = 20});
  Future<void> markShareAsViewed(String shareId);

  // Reposts
  Future<StoryModel> repostStory(String storyId, bool isPublic);
}

class StoryRemoteDataSourceImpl implements StoryRemoteDataSource {
  final Dio dio;

  StoryRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<StoryModel>> getPublicStories() async {
    try {
      final response = await dio.get('/api/v1/stories');
      final items = response.data['items'] as List;
      print('📖 [STORIES] Parsing ${items.length} stories...');

      final stories = <StoryModel>[];
      for (var i = 0; i < items.length; i++) {
        try {
          final item = items[i];
          print('📖 [STORIES] Parsing story $i: ${item['id']}');
          final story = StoryModel.fromJson(item);
          stories.add(story);
        } catch (e) {
          print('❌ [STORIES] Error parsing story $i: $e');
          print('📦 [STORIES] Story data: ${items[i]}');
          rethrow;
        }
      }
      return stories;
    } catch (e) {
      print('❌ [STORIES] Error fetching public stories: $e');
      rethrow;
    }
  }

  @override
  Future<List<StoryModel>> getMyStories() async {
    try {
      final response = await dio.get('/api/v1/stories/my');
      final items = response.data['items'] as List;
      return items.map((item) => StoryModel.fromJson(item)).toList();
    } catch (e) {
      print('❌ [STORIES] Error fetching my stories: $e');
      rethrow;
    }
  }

  @override
  Future<void> createStory(String memoryId, bool isPublic) async {
    try {
      await dio.post(
        '/api/v1/stories',
        data: {'memory_id': memoryId, 'is_public': isPublic},
      );
      print('✅ [STORIES] Story created successfully');
    } catch (e) {
      print('❌ [STORIES] Error creating story: $e');
      rethrow;
    }
  }

  @override
  Future<void> deleteStory(String storyId) async {
    try {
      await dio.delete('/api/v1/stories/$storyId');
    } catch (e) {
      print('❌ [STORIES] Error deleting story: $e');
      rethrow;
    }
  }

  // ==================== LIKES ====================

  @override
  Future<void> likeStory(String storyId) async {
    try {
      await dio.post('/api/v1/stories/$storyId/like');
      print('✅ [STORIES] Story liked');
    } catch (e) {
      print('❌ [STORIES] Error liking story: $e');
      rethrow;
    }
  }

  @override
  Future<void> unlikeStory(String storyId) async {
    try {
      await dio.delete('/api/v1/stories/$storyId/like');
      print('✅ [STORIES] Story unliked');
    } catch (e) {
      print('❌ [STORIES] Error unliking story: $e');
      rethrow;
    }
  }

  @override
  Future<StoryLikeListModel> getStoryLikes(
    String storyId, {
    int skip = 0,
    int limit = 50,
  }) async {
    try {
      final response = await dio.get(
        '/api/v1/stories/$storyId/likes',
        queryParameters: {'skip': skip, 'limit': limit},
      );
      return StoryLikeListModel.fromJson(response.data);
    } catch (e) {
      print('❌ [STORIES] Error fetching story likes: $e');
      rethrow;
    }
  }

  // ==================== COMMENTS ====================

  @override
  Future<StoryCommentModel> createComment(
    String storyId,
    String content,
  ) async {
    try {
      final response = await dio.post(
        '/api/v1/stories/$storyId/comments',
        data: {'content': content},
      );
      print('✅ [STORIES] Comment created');
      return StoryCommentModel.fromJson(response.data);
    } catch (e) {
      print('❌ [STORIES] Error creating comment: $e');
      rethrow;
    }
  }

  @override
  Future<StoryCommentModel> updateComment(
    String commentId,
    String content,
  ) async {
    try {
      final response = await dio.put(
        '/api/v1/stories/comments/$commentId',
        data: {'content': content},
      );
      print('✅ [STORIES] Comment updated');
      return StoryCommentModel.fromJson(response.data);
    } catch (e) {
      print('❌ [STORIES] Error updating comment: $e');
      rethrow;
    }
  }

  @override
  Future<void> deleteComment(String commentId) async {
    try {
      await dio.delete('/api/v1/stories/comments/$commentId');
      print('✅ [STORIES] Comment deleted');
    } catch (e) {
      print('❌ [STORIES] Error deleting comment: $e');
      rethrow;
    }
  }

  @override
  Future<StoryCommentListModel> getStoryComments(
    String storyId, {
    int skip = 0,
    int limit = 50,
  }) async {
    try {
      final response = await dio.get(
        '/api/v1/stories/$storyId/comments',
        queryParameters: {'skip': skip, 'limit': limit},
      );
      return StoryCommentListModel.fromJson(response.data);
    } catch (e) {
      print('❌ [STORIES] Error fetching comments: $e');
      rethrow;
    }
  }

  // ==================== SHARES ====================

  @override
  Future<void> shareStory(String storyId, String recipientId) async {
    try {
      await dio.post(
        '/api/v1/stories/$storyId/share',
        data: {'recipient_id': recipientId},
      );
      print('✅ [STORIES] Story shared');
    } catch (e) {
      print('❌ [STORIES] Error sharing story: $e');
      rethrow;
    }
  }

  @override
  Future<StoryShareListModel> getReceivedShares({
    int skip = 0,
    int limit = 20,
  }) async {
    try {
      final response = await dio.get(
        '/api/v1/stories/shared/received',
        queryParameters: {'skip': skip, 'limit': limit},
      );
      return StoryShareListModel.fromJson(response.data);
    } catch (e) {
      print('❌ [STORIES] Error fetching received shares: $e');
      rethrow;
    }
  }

  @override
  Future<void> markShareAsViewed(String shareId) async {
    try {
      await dio.put('/api/v1/stories/shared/$shareId/view');
      print('✅ [STORIES] Share marked as viewed');
    } catch (e) {
      print('❌ [STORIES] Error marking share as viewed: $e');
      rethrow;
    }
  }

  // ==================== REPOSTS ====================

  @override
  Future<StoryModel> repostStory(String storyId, bool isPublic) async {
    try {
      final response = await dio.post(
        '/api/v1/stories/$storyId/repost',
        data: {'is_public': isPublic},
      );
      print('✅ [STORIES] Story reposted');
      return StoryModel.fromJson(response.data);
    } catch (e) {
      print('❌ [STORIES] Error reposting story: $e');
      rethrow;
    }
  }
}
