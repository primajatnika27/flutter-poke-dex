import 'package:dartz/dartz.dart';
import 'package:poke_dex/core/error/failures.dart';
import 'package:poke_dex/features/pokemon/domain/entities/pokemon_evolution_entity.dart';
import 'package:poke_dex/features/pokemon/domain/repositories/pokemon_repository.dart';

class GetPokemonEvolutionChainUseCase {
  final PokemonRepository repository;

  GetPokemonEvolutionChainUseCase(this.repository);

  Future<Either<Failure, PokemonEvolutionEntity>> execute(int id) async {
    return await repository.getPokemonEvolutionChain(id);
  }
}