import 'dart:ui';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:poke_dex/common/utils/pokemon_colors.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/pokemon_entity.dart';
import '../../domain/repositories/pokemon_repository.dart';
import '../datasources/pokemon_remote_data_source.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  final PokemonRemoteDataSource remoteDataSource;

  PokemonRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<PokemonEntity>>> getPokemonList({
    required int limit,
    required int offset,
  }) async {
    try {
      final pokemonListResponse = await remoteDataSource.getPokemonList(
        limit: limit,
        offset: offset,
      );
      final List<PokemonEntity> pokemonList = [];

      for (var pokemon in pokemonListResponse.results) {
        final pokemonDetail =
            await remoteDataSource.getPokemonDetail(pokemon.url);

        pokemonList.add(
          PokemonEntity(
            id: pokemonDetail.id,
            name: pokemonDetail.name,
            imageUrl: pokemonDetail.sprites.frontDefault,
            color: PokemonColors.instance.getTypeColor(pokemonDetail.types.first.type.name),
            types: pokemonDetail.types.map((type) => type.type.name).toList(),
          ),
        );
      }

      return Right(pokemonList);
    } on DioException catch (e) {
      return Left(ServerFailure(e.message ?? 'Failed to fetch Pokemon data'));
    } catch (e) {
      return const Left(ServerFailure('An unexpected error occurred'));
    }
  }
}
