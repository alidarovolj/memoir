import 'package:dio/dio.dart';
import 'package:memoir/features/profile/data/models/user_stats_model.dart';

abstract class UserStatsRemoteDataSource {
  Future<UserStatsModel> getUserStats();
}

class UserStatsRemoteDataSourceImpl implements UserStatsRemoteDataSource {
  final Dio dio;

  UserStatsRemoteDataSourceImpl({required this.dio});

  @override
  Future<UserStatsModel> getUserStats() async {
    try {
      final response = await dio.get('/api/v1/users/me/stats');
      return UserStatsModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load user stats: $e');
    }
  }
}
