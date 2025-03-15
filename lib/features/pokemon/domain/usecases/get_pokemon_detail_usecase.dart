import 'package:dartz/dartz.dart';
import 'package:poke_dex/core/error/failures.dart';
import 'package:poke_dex/features/pokemon/domain/entities/pokemon_detail_about_entity.dart';
import 'package:poke_dex/features/pokemon/domain/entities/pokemon_detail_stats_entity.dart';
import 'package:poke_dex/features/pokemon/domain/repositories/pokemon_repository.dart';

class GetPokemonAboutUseCase {
  final PokemonRepository repository;

  GetPokemonAboutUseCase(this.repository);

  Future<Either<Failure, PokemonDetailAboutEntity>> executeAbout(String name) {
    return repository.getPokemonDetail(name: name);
  }

  Future<Either<Failure, PokemonDetailStatsEntity>> executeStats(String name) {
    return repository.getPokemonStats(name: name);
  }

  
}