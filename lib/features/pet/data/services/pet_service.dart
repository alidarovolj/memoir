import 'package:memoir/features/pet/data/models/pet_model.dart';
import 'package:memoir/features/pet/data/datasources/pet_remote_datasource.dart';
import 'package:memoir/core/network/dio_client.dart';

/// Global Pet Service - Singleton for pet management across app
class PetService {
  static final PetService _instance = PetService._internal();
  factory PetService() => _instance;
  PetService._internal();

  PetRemoteDataSource? _dataSource;
  PetModel? _currentPet;

  void initialize() {
    _dataSource = PetRemoteDataSourceImpl(dio: DioClient.instance);
    print('🐾 [PET_SERVICE] Initialized with dataSource');
  }

  PetModel? get currentPet => _currentPet;

  Future<PetModel?> loadPet() async {
    print('🐾 [PET_SERVICE] loadPet() called');
    print('🐾 [PET_SERVICE] _dataSource initialized: ${_dataSource != null}');

    if (_dataSource == null) {
      print(
        '❌ [PET_SERVICE] DataSource not initialized! Call initialize() first',
      );
      return null;
    }

    try {
      _currentPet = await _dataSource!.getMyPet();
      print('🐾 [PET_SERVICE] Pet loaded from API: $_currentPet');
      print('🐾 [PET_SERVICE] Pet is null: ${_currentPet == null}');
      return _currentPet;
    } catch (e) {
      print('⚠️ [PET_SERVICE] Failed to load pet: $e');
      print('⚠️ [PET_SERVICE] Error type: ${e.runtimeType}');
      return null;
    }
  }

  Future<PetActionResponse?> feedPet() async {
    if (_currentPet == null || _dataSource == null) return null;

    try {
      final result = await _dataSource!.feedPet();
      _currentPet = result.pet;
      return result;
    } catch (e) {
      print('⚠️ [PET_SERVICE] Failed to feed pet: $e');
      return null;
    }
  }

  Future<PetActionResponse?> playWithPet() async {
    if (_currentPet == null || _dataSource == null) return null;

    try {
      final result = await _dataSource!.playWithPet();
      _currentPet = result.pet;
      return result;
    } catch (e) {
      print('⚠️ [PET_SERVICE] Failed to play with pet: $e');
      return null;
    }
  }

  void updatePet(PetModel pet) {
    _currentPet = pet;
  }
}
