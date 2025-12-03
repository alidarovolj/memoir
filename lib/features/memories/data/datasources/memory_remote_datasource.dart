import 'package:dio/dio.dart';
import 'package:memoir/core/config/api_config.dart';

abstract class MemoryRemoteDataSource {
  Future<Map<String, dynamic>> createMemory(Map<String, dynamic> memoryData);
  Future<List<Map<String, dynamic>>> getMemories();
  Future<Map<String, dynamic>> getMemory(String id);
  Future<Map<String, dynamic>> updateMemory(String id, Map<String, dynamic> memoryData);
  Future<void> deleteMemory(String id);
  Future<List<Map<String, dynamic>>> searchMemories({required String query, bool isSemanticSearch = false});
}

class MemoryRemoteDataSourceImpl implements MemoryRemoteDataSource {
  final Dio dio;

  MemoryRemoteDataSourceImpl({required this.dio});

  @override
  Future<Map<String, dynamic>> createMemory(Map<String, dynamic> memoryData) async {
    try {
      final response = await dio.post(
        ApiConfig.memories,
        data: memoryData,
      );
      return response.data as Map<String, dynamic>;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getMemories() async {
    try {
      final response = await dio.get(ApiConfig.memories);
      
      // Backend возвращает {items: [...], total: 1, page: 1, ...}
      // Нам нужен только массив items
      if (response.data is Map && response.data.containsKey('items')) {
        final items = response.data['items'] as List;
        return List<Map<String, dynamic>>.from(items);
      }
      
      // Если вдруг вернулся просто массив
      if (response.data is List) {
        return List<Map<String, dynamic>>.from(response.data as List);
      }
      
      return [];
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> getMemory(String id) async {
    try {
      final response = await dio.get('${ApiConfig.memories}/$id');
      return response.data as Map<String, dynamic>;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> updateMemory(
    String id,
    Map<String, dynamic> memoryData,
  ) async {
    try {
      final response = await dio.put(
        '${ApiConfig.memories}/$id',
        data: memoryData,
      );
      return response.data as Map<String, dynamic>;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteMemory(String id) async {
    try {
      await dio.delete('${ApiConfig.memories}/$id');
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Map<String, dynamic>>> searchMemories({
    required String query,
    bool isSemanticSearch = false,
  }) async {
    try {
      final Response response;
      
      if (isSemanticSearch) {
        // Semantic search uses POST
        response = await dio.post(
          '${ApiConfig.search}/semantic',
          queryParameters: {'q': query},
        );
      } else {
        // Text search uses GET
        response = await dio.get(
          ApiConfig.search,
          queryParameters: {'q': query},
        );
      }
      
      if (response.data is List) {
        return List<Map<String, dynamic>>.from(response.data as List);
      }
      
      return [];
    } catch (e) {
      rethrow;
    }
  }
}

