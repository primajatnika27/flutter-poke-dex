import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:poke_dex/common/network/dio_client.dart';
import 'package:poke_dex/features/pokemon/data/datasources/pokemon_remote_data_source.dart';
import 'package:poke_dex/features/pokemon/data/datasources/pokemon_remote_data_source_impl.dart';
import 'package:poke_dex/features/pokemon/data/repositories/pokemon_repository_impl.dart';
import 'package:poke_dex/features/pokemon/domain/repositories/pokemon_repository.dart';
import 'package:poke_dex/features/pokemon/domain/usecases/get_pokemon_list_usecase.dart';

final getIt = GetIt.instance;

Future<void> initializeDependencies() async {
  // Network
  getIt.registerLazySingleton<Dio>(() => Dio());
  getIt.registerLazySingleton<DioClient>(() => DioClient(getIt<Dio>()));

  // Data Sources
  getIt.registerLazySingleton<PokemonRemoteDataSource>(
    () => PokemonRemoteDataSourceImpl(dioClient: getIt<DioClient>()),
  );

  // Repositories
  getIt.registerLazySingleton<PokemonRepository>(
    () => PokemonRepositoryImpl(
        remoteDataSource: getIt<PokemonRemoteDataSource>()),
  );

  // Use Cases
  getIt.registerLazySingleton(
    () => GetPokemonListUseCase(getIt<PokemonRepository>()),
  );
}
