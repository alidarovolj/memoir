import 'package:dio/dio.dart';
import 'package:memoir/features/pet/data/models/pet_model.dart';

/// Pet Remote Data Source - API calls for pet management
abstract class PetRemoteDataSource {
  /// Create a new pet for the user
  Future<PetModel> createPet(PetCreateRequest request);

  /// Get user's pet
  Future<PetModel?> getMyPet();

  /// Feed the pet (triggered when creating memory)
  Future<PetActionResponse> feedPet();

  /// Play with the pet (triggered when completing task)
  Future<PetActionResponse> playWithPet();

  /// Update pet name
  Future<PetModel> updatePetName(String name);

  /// Get pet statistics
  Future<PetStats> getPetStats();

  /// Get available pet types (NEW)
  Future<List<PetTypeInfo>> getAvailableTypes();
}

class PetRemoteDataSourceImpl implements PetRemoteDataSource {
  final Dio dio;

  PetRemoteDataSourceImpl({required this.dio});

  @override
  Future<PetModel> createPet(PetCreateRequest request) async {
    try {
      final response = await dio.post('/api/v1/pets', data: request.toJson());

      print('🐾 [PET_API] Created pet: ${response.data}');

      return PetModel.fromJson(response.data);
    } on DioException catch (e) {
      print('❌ [PET_API] Error creating pet: ${e.response?.data}');
      throw Exception('Failed to create pet: ${e.message}');
    }
  }

  @override
  Future<PetModel?> getMyPet() async {
    try {
      final response = await dio.get('/api/v1/pets/me');

      print('🐾 [PET_API] Got pet: ${response.data}');

      // API returns null if user doesn't have a pet
      if (response.data == null) {
        return null;
      }

      return PetModel.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        print('ℹ️ [PET_API] User has no pet yet');
        return null;
      }

      print('❌ [PET_API] Error getting pet: ${e.response?.data}');
      throw Exception('Failed to get pet: ${e.message}');
    }
  }

  @override
  Future<PetActionResponse> feedPet() async {
    try {
      final response = await dio.post('/api/v1/pets/feed');

      print('🍔 [PET_API] Fed pet: ${response.data}');

      return PetActionResponse.fromJson(response.data);
    } on DioException catch (e) {
      print('❌ [PET_API] Error feeding pet: ${e.response?.data}');
      throw Exception('Failed to feed pet: ${e.message}');
    }
  }

  @override
  Future<PetActionResponse> playWithPet() async {
    try {
      final response = await dio.post('/api/v1/pets/play');

      print('🎾 [PET_API] Played with pet: ${response.data}');

      return PetActionResponse.fromJson(response.data);
    } on DioException catch (e) {
      print('❌ [PET_API] Error playing with pet: ${e.response?.data}');
      throw Exception('Failed to play with pet: ${e.message}');
    }
  }

  @override
  Future<PetModel> updatePetName(String name) async {
    try {
      final response = await dio.put(
        '/api/v1/pets/name',
        data: PetUpdateNameRequest(name: name).toJson(),
      );

      print('✏️ [PET_API] Updated pet name: ${response.data}');

      return PetModel.fromJson(response.data);
    } on DioException catch (e) {
      print('❌ [PET_API] Error updating pet name: ${e.response?.data}');
      throw Exception('Failed to update pet name: ${e.message}');
    }
  }

  @override
  Future<PetStats> getPetStats() async {
    try {
      final response = await dio.get('/api/v1/pets/stats');

      print('📊 [PET_API] Got pet stats: ${response.data}');

      return PetStats.fromJson(response.data);
    } on DioException catch (e) {
      print('❌ [PET_API] Error getting pet stats: ${e.response?.data}');
      throw Exception('Failed to get pet stats: ${e.message}');
    }
  }

  @override
  Future<List<PetTypeInfo>> getAvailableTypes() async {
    try {
      final response = await dio.get('/api/v1/pets/available-types');

      print('🐾 [PET_API] Got available types: ${response.data}');

      final List<dynamic> data = response.data as List;
      return data.map((json) => PetTypeInfo.fromJson(json)).toList();
    } on DioException catch (e) {
      print('❌ [PET_API] Error getting available types: ${e.response?.data}');
      throw Exception('Failed to get available types: ${e.message}');
    }
  }
}
