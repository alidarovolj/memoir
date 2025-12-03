import 'package:dio/dio.dart';
import 'package:memoir/features/stories/data/models/story_model.dart';

abstract class StoryRemoteDataSource {
  Future<List<StoryModel>> getPublicStories();
  Future<List<StoryModel>> getMyStories();
  Future<void> createStory(String memoryId, bool isPublic);
  Future<void> deleteStory(String storyId);
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
        data: {
          'memory_id': memoryId,
          'is_public': isPublic,
        },
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
}

