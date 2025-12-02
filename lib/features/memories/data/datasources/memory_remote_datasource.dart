import 'package:dio/dio.dart';
import 'package:memoir/core/config/api_config.dart';

abstract class MemoryRemoteDataSource {
  Future<Map<String, dynamic>> createMemory(Map<String, dynamic> memoryData);
  Future<List<Map<String, dynamic>>> getMemories();
  Future<Map<String, dynamic>> getMemory(String id);
  Future<Map<String, dynamic>> updateMemory(String id, Map<String, dynamic> memoryData);
  Future<void> deleteMemory(String id);
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
      return List<Map<String, dynamic>>.from(response.data as List);
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
}

