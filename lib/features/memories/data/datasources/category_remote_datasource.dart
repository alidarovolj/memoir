import 'package:dio/dio.dart';
import 'package:memoir/core/config/api_config.dart';

abstract class CategoryRemoteDataSource {
  Future<List<Map<String, dynamic>>> getCategories();
}

class CategoryRemoteDataSourceImpl implements CategoryRemoteDataSource {
  final Dio dio;

  CategoryRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<Map<String, dynamic>>> getCategories() async {
    try {
      final response = await dio.get(ApiConfig.categories);
      return List<Map<String, dynamic>>.from(response.data as List);
    } catch (e) {
      rethrow;
    }
  }
}

