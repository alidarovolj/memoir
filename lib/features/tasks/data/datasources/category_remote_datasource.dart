import 'package:dio/dio.dart';
import 'package:memoir/features/tasks/data/models/category_model.dart';
import 'package:memoir/core/config/api_config.dart';
import 'dart:developer';

abstract class CategoryRemoteDataSource {
  Future<List<CategoryModel>> getCategories();
}

class CategoryRemoteDataSourceImpl implements CategoryRemoteDataSource {
  final Dio dio;

  CategoryRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<CategoryModel>> getCategories() async {
    try {
      final response = await dio.get(ApiConfig.categories);

      final categories = (response.data as List)
          .map((json) => CategoryModel.fromJson(json))
          .toList();

      log('📁 [CATEGORIES] Fetched ${categories.length} categories');
      return categories;
    } catch (e, stackTrace) {
      log(
        '❌ [CATEGORIES] Error fetching categories: $e',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }
}
