import 'package:dio/dio.dart';
import 'package:memoir/features/challenges/data/models/challenge_model.dart';

/// Remote datasource for Challenges
abstract class ChallengeRemoteDataSource {
  /// Get active challenges
  Future<List<ChallengeModel>> getActiveChallenges({
    int page = 1,
    int size = 20,
  });

  /// Get challenge by ID
  Future<ChallengeModel> getChallengeById(String id);

  /// Join a challenge
  Future<ChallengeParticipantModel> joinChallenge(String challengeId);

  /// Get user's progress in a challenge
  Future<ChallengeProgressModel> getChallengeProgress(String challengeId);

  /// Get challenge leaderboard
  Future<ChallengeLeaderboard> getChallengeLeaderboard(
    String challengeId, {
    int limit = 100,
  });

  /// Get user's active participations
  Future<List<ChallengeProgressModel>> getMyParticipations();
}

/// Implementation of ChallengeRemoteDataSource
class ChallengeRemoteDataSourceImpl implements ChallengeRemoteDataSource {
  final Dio dio;

  ChallengeRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<ChallengeModel>> getActiveChallenges({
    int page = 1,
    int size = 20,
  }) async {
    final response = await dio.get(
      '/api/v1/challenges/active',
      queryParameters: {'page': page, 'size': size},
    );

    final items = response.data['items'] as List;
    return items.map((json) => ChallengeModel.fromJson(json)).toList();
  }

  @override
  Future<ChallengeModel> getChallengeById(String id) async {
    final response = await dio.get('/api/v1/challenges/$id');
    return ChallengeModel.fromJson(response.data);
  }

  @override
  Future<ChallengeParticipantModel> joinChallenge(String challengeId) async {
    final response = await dio.post('/api/v1/challenges/$challengeId/join');
    return ChallengeParticipantModel.fromJson(response.data);
  }

  @override
  Future<ChallengeProgressModel> getChallengeProgress(
    String challengeId,
  ) async {
    final response = await dio.get('/api/v1/challenges/$challengeId/progress');
    return ChallengeProgressModel.fromJson(response.data);
  }

  @override
  Future<ChallengeLeaderboard> getChallengeLeaderboard(
    String challengeId, {
    int limit = 100,
  }) async {
    final response = await dio.get(
      '/api/v1/challenges/$challengeId/leaderboard',
      queryParameters: {'limit': limit},
    );
    return ChallengeLeaderboard.fromJson(response.data);
  }

  @override
  Future<List<ChallengeProgressModel>> getMyParticipations() async {
    final response = await dio.get('/api/v1/challenges/my/participations');
    final items = response.data as List;
    return items.map((json) => ChallengeProgressModel.fromJson(json)).toList();
  }
}
