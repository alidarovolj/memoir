import 'package:dio/dio.dart';
import 'package:memoir/features/achievements/data/models/achievement_model.dart';

/// Remote datasource for Achievements
abstract class AchievementRemoteDataSource {
  Future<AchievementList> getAchievements();
}

/// Implementation
class AchievementRemoteDataSourceImpl implements AchievementRemoteDataSource {
  final Dio dio;

  AchievementRemoteDataSourceImpl({required this.dio});

  @override
  Future<AchievementList> getAchievements() async {
    final response = await dio.get('/api/v1/achievements');
    return AchievementList.fromJson(response.data);
  }
}
