import 'package:dartz/dartz.dart';
import 'package:poke_dex/features/pokemon/data/models/pokemon_evolution_chain_model.dart';
import 'package:poke_dex/features/pokemon/domain/entities/pokemon_detail_about_entity.dart';
import 'package:poke_dex/features/pokemon/domain/entities/pokemon_detail_stats_entity.dart';
import 'package:poke_dex/features/pokemon/domain/entities/pokemon_evolution_entity.dart';
import 'package:poke_dex/features/pokemon/domain/entities/pokemon_move_entity.dart';
import '../../../../core/error/failures.dart';
import '../entities/pokemon_entity.dart';

abstract class PokemonRepository {
  Future<Either<Failure, List<PokemonEntity>>> getPokemonList({
    required int limit,
    required int offset,
  });

  Future<Either<Failure, PokemonDetailAboutEntity>> getPokemonDetail({
    required String name,
  });

  Future<Either<Failure, PokemonDetailStatsEntity>> getPokemonStats({
    required String name,
  });

  Future<Either<Failure, PokemonEvolutionEntity>> getPokemonEvolutionChain(int id);

  Future<Either<Failure, List<PokemonMoveEntity>>> getPokemonMoves(int id);
}
