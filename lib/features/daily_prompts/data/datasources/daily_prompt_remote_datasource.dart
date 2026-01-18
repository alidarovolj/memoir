import 'package:dio/dio.dart';
import 'package:memoir/features/daily_prompts/data/models/daily_prompt_model.dart';

/// Remote datasource for Daily Prompts
abstract class DailyPromptRemoteDataSource {
  /// Get prompt of the day
  Future<DailyPromptModel> getPromptOfTheDay({PromptCategory? category});

  /// Answer a prompt
  Future<PromptAnswerResponse> answerPrompt({
    required String promptId,
    required String answer,
  });

  /// Get all prompts
  Future<List<DailyPromptModel>> getAllPrompts({bool activeOnly = true});
}

/// Prompt Answer Response
class PromptAnswerResponse {
  final String memoryId;
  final int xpGained;
  final String message;

  PromptAnswerResponse({
    required this.memoryId,
    required this.xpGained,
    required this.message,
  });

  factory PromptAnswerResponse.fromJson(Map<String, dynamic> json) {
    return PromptAnswerResponse(
      memoryId: json['memory_id'] as String,
      xpGained: json['xp_gained'] as int,
      message: json['message'] as String,
    );
  }
}

/// Implementation of DailyPromptRemoteDataSource
class DailyPromptRemoteDataSourceImpl implements DailyPromptRemoteDataSource {
  final Dio dio;

  DailyPromptRemoteDataSourceImpl({required this.dio});

  @override
  Future<DailyPromptModel> getPromptOfTheDay({PromptCategory? category}) async {
    try {
      final queryParams = <String, dynamic>{};

      if (category != null) {
        queryParams['category'] = category.name.toUpperCase();
      }

      final response = await dio.get(
        '/api/v1/daily-prompts/today',
        queryParameters: queryParams,
      );

      return DailyPromptModel.fromJson(response.data);
    } on DioException catch (e) {
      // Если промпт не найден (404), выбрасываем понятное исключение
      if (e.response?.statusCode == 404) {
        throw Exception('No active prompts available');
      }
      rethrow;
    }
  }

  @override
  Future<PromptAnswerResponse> answerPrompt({
    required String promptId,
    required String answer,
  }) async {
    final response = await dio.post(
      '/api/v1/daily-prompts/answer',
      data: {'prompt_id': promptId, 'answer': answer},
    );

    return PromptAnswerResponse.fromJson(response.data);
  }

  @override
  Future<List<DailyPromptModel>> getAllPrompts({bool activeOnly = true}) async {
    final response = await dio.get(
      '/api/v1/daily-prompts',
      queryParameters: {'active_only': activeOnly},
    );

    final items = response.data as List;
    return items.map((json) => DailyPromptModel.fromJson(json)).toList();
  }
}
