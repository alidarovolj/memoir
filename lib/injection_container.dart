import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:memoir/core/network/api_client.dart';

final sl = GetIt.instance;

/// Initialize dependency injection
Future<void> init() async {
  //! Core
  // SharedPreferences
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  
  // API Client
  sl.registerLazySingleton(() => ApiClient(sl()));
  
  //! Features
  // Auth
  // TODO: Register auth dependencies
  
  // Memories
  // TODO: Register memory dependencies
}

