import 'package:dio/dio.dart';
import 'package:memoir/core/config/api_config.dart';

abstract class SmartSearchRemoteDataSource {
  Future<Map<String, dynamic>> smartSearch(String query, {String? forceIntent});
  Future<Map<String, dynamic>> getContentDetails({
    required String externalId,
    required String source,
    required String contentType,
  });
}

class SmartSearchRemoteDataSourceImpl implements SmartSearchRemoteDataSource {
  final Dio dio;

  SmartSearchRemoteDataSourceImpl({required this.dio});

  @override
  Future<Map<String, dynamic>> smartSearch(
    String query, {
    String? forceIntent,
  }) async {
    try {
      final queryParams = <String, dynamic>{'query': query};
      if (forceIntent != null) {
        queryParams['force_intent'] = forceIntent;
      }

      final response = await dio.post(
        '${ApiConfig.apiV1}/smart-search/smart-search',
        queryParameters: queryParams,
      );

      return response.data as Map<String, dynamic>;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> getContentDetails({
    required String externalId,
    required String source,
    required String contentType,
  }) async {
    try {
      final response = await dio.post(
        '${ApiConfig.apiV1}/smart-search/content-details',
        data: {
          'external_id': externalId,
          'source': source,
          'content_type': contentType,
        },
      );

      return response.data as Map<String, dynamic>;
    } catch (e) {
      rethrow;
    }
  }
}

