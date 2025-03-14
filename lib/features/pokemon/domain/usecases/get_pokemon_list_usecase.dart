import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/pokemon_entity.dart';
import '../repositories/pokemon_repository.dart';

class GetPokemonListUseCase {
  final PokemonRepository repository;

  GetPokemonListUseCase(this.repository);

  Future<Either<Failure, List<PokemonEntity>>> execute({
    required int limit,
    required int offset,
  }) {
    return repository.getPokemonList(
      limit: limit,
      offset: offset,
    );
  }
}
