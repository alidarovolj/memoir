import 'package:dio/dio.dart';
import 'package:memoir/features/analytics/data/models/analytics_model.dart';

abstract class AnalyticsRemoteDataSource {
  Future<AnalyticsDashboard> getAnalyticsDashboard();
}

class AnalyticsRemoteDataSourceImpl implements AnalyticsRemoteDataSource {
  final Dio dio;

  AnalyticsRemoteDataSourceImpl({required this.dio});

  @override
  Future<AnalyticsDashboard> getAnalyticsDashboard() async {
    try {
      final response = await dio.get('/api/v1/analytics/dashboard');
      return AnalyticsDashboard.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load analytics dashboard: $e');
    }
  }
}
