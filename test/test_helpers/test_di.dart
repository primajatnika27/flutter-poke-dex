import 'package:dartz/dartz.dart';
import 'package:get_it/get_it.dart';
import 'package:poke_dex/core/error/failures.dart';
import 'package:poke_dex/features/pokemon/domain/entities/pokemon_detail_about_entity.dart';
import 'package:poke_dex/features/pokemon/domain/entities/pokemon_detail_stats_entity.dart';
import 'package:poke_dex/features/pokemon/domain/entities/pokemon_entity.dart';
import 'package:poke_dex/features/pokemon/domain/entities/pokemon_evolution_entity.dart';
import 'package:poke_dex/features/pokemon/domain/entities/pokemon_move_entity.dart';
import 'package:poke_dex/features/pokemon/domain/repositories/pokemon_repository.dart';
import 'package:poke_dex/features/pokemon/domain/usecases/get_pokemon_detail_usecase.dart';
import 'package:poke_dex/features/pokemon/domain/usecases/get_pokemon_evolution_chain.dart';
import 'package:poke_dex/features/pokemon/domain/usecases/get_pokemon_move_usecase.dart';

final getIt = GetIt.instance;

// Mock repository untuk testing
class MockPokemonRepository implements PokemonRepository {
  Either<Failure, PokemonDetailAboutEntity> aboutResult =
      const Right(PokemonDetailAboutEntity());
  Either<Failure, PokemonDetailStatsEntity> statsResult =
      const Right(PokemonDetailStatsEntity());
  Either<Failure, PokemonEvolutionEntity> evolutionResult =
      const Right(PokemonEvolutionEntity(evolutionChain: []));
  Either<Failure, List<PokemonMoveEntity>> movesResult = const Right([]);
  Either<Failure, List<PokemonEntity>> listResult = const Right([]);

  @override
  Future<Either<Failure, PokemonDetailAboutEntity>> getPokemonDetail(
      {required String name}) async {
    return aboutResult;
  }

  @override
  Future<Either<Failure, PokemonDetailStatsEntity>> getPokemonStats(
      {required String name}) async {
    return statsResult;
  }

  @override
  Future<Either<Failure, PokemonEvolutionEntity>> getPokemonEvolutionChain(
      int id) async {
    return evolutionResult;
  }

  @override
  Future<Either<Failure, List<PokemonMoveEntity>>> getPokemonMoves(
      int id) async {
    return movesResult;
  }

  @override
  Future<Either<Failure, List<PokemonEntity>>> getPokemonList(
      {required int limit, required int offset}) async {
    return listResult;
  }
}

void setupTestDependencies() {
  // Reset GetIt instance
  getIt.reset();

  // Register mock repository
  final mockRepository = MockPokemonRepository();

  // Register use cases with mock repository
  getIt.registerSingleton<GetPokemonAboutUseCase>(
      GetPokemonAboutUseCase(mockRepository));
  getIt.registerSingleton<GetPokemonEvolutionChainUseCase>(
      GetPokemonEvolutionChainUseCase(mockRepository));
  getIt.registerSingleton<GetPokemonMoveUseCase>(
      GetPokemonMoveUseCase(mockRepository));

  // Return the mock repository for test to use
  getIt.registerSingleton<MockPokemonRepository>(mockRepository);
}

// Helper untuk mendapatkan mock repository
MockPokemonRepository getMockRepository() {
  return getIt<MockPokemonRepository>();
}
