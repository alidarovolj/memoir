import 'package:dio/dio.dart';
import 'package:memoir/features/ai_stories/data/models/ai_story_model.dart';

/// Remote datasource for AI Stories
abstract class AIStoryRemoteDataSource {
  /// Generate creative story from memories
  Future<StoryGenerationResponse> generateStory(StoryGenerationRequest request);

  /// Chat with past self
  Future<ChatWithPastResponse> chatWithPast(ChatWithPastRequest request);

  /// Generate year summary
  Future<YearSummaryResponse> generateYearSummary(YearSummaryRequest request);
}

/// Implementation of AIStoryRemoteDataSource
class AIStoryRemoteDataSourceImpl implements AIStoryRemoteDataSource {
  final Dio dio;

  AIStoryRemoteDataSourceImpl({required this.dio});

  @override
  Future<StoryGenerationResponse> generateStory(
    StoryGenerationRequest request,
  ) async {
    final response = await dio.post(
      '/api/v1/ai/generate-story',
      data: request.toJson(),
    );
    return StoryGenerationResponse.fromJson(response.data);
  }

  @override
  Future<ChatWithPastResponse> chatWithPast(ChatWithPastRequest request) async {
    final response = await dio.post(
      '/api/v1/ai/chat-with-past',
      data: request.toJson(),
    );
    return ChatWithPastResponse.fromJson(response.data);
  }

  @override
  Future<YearSummaryResponse> generateYearSummary(
    YearSummaryRequest request,
  ) async {
    final response = await dio.post(
      '/api/v1/ai/year-summary',
      data: request.toJson(),
    );
    return YearSummaryResponse.fromJson(response.data);
  }
}
