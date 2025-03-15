import 'package:dartz/dartz.dart';
import 'package:poke_dex/core/error/failures.dart';
import 'package:poke_dex/features/pokemon/domain/entities/pokemon_move_entity.dart';
import 'package:poke_dex/features/pokemon/domain/repositories/pokemon_repository.dart';

class GetPokemonMoveUseCase {
  final PokemonRepository repository;

  GetPokemonMoveUseCase(this.repository);

  Future<Either<Failure, List<PokemonMoveEntity>>> execute(int id) async {
    return await repository.getPokemonMoves(id);
  }
}