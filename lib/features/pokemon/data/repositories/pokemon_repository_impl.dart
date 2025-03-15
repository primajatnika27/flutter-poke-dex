import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:poke_dex/common/utils/pokemon_colors.dart';
import 'package:poke_dex/common/utils/pokemon_generator.dart';
import 'package:poke_dex/core/error/failures.dart';
import 'package:poke_dex/features/pokemon/data/datasources/pokemon_remote_data_source.dart';
import 'package:poke_dex/features/pokemon/data/models/mapper/pokemon_move_mapper.dart';
import 'package:poke_dex/features/pokemon/data/models/pokemon_detail_model.dart';
import 'package:poke_dex/features/pokemon/domain/entities/pokemon_detail_about_entity.dart';
import 'package:poke_dex/features/pokemon/domain/entities/pokemon_detail_stats_entity.dart';
import 'package:poke_dex/features/pokemon/domain/entities/pokemon_entity.dart';
import 'package:poke_dex/features/pokemon/domain/entities/pokemon_evolution_entity.dart';
import 'package:poke_dex/features/pokemon/domain/entities/pokemon_move_entity.dart';
import 'package:poke_dex/features/pokemon/domain/repositories/pokemon_repository.dart';

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

      final List<Future<PokemonDetail>> detailFutures = pokemonListResponse
          .results
          .map((pokemon) => remoteDataSource.getPokemonDetail(pokemon.url))
          .toList();

      final List<PokemonDetail> pokemonDetails =
          await Future.wait(detailFutures);

      final List<PokemonEntity> pokemonList = pokemonDetails
          .map(
            (detail) => PokemonEntity(
              id: detail.id,
              name: detail.name,
              imageUrl: detail.sprites.other.officialArtwork.frontDefault,
              color: PokemonColors.instance
                  .getTypeColor(detail.types.first.type.name),
              types: detail.types.map((type) => type.type.name).toList(),
            ),
          )
          .toList();

      return Right(pokemonList);
    } on DioException catch (e) {
      return Left(ServerFailure(e.message ?? 'Failed to fetch Pokemon data'));
    } catch (e) {
      return const Left(ServerFailure('An unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, PokemonDetailAboutEntity>> getPokemonDetail(
      {required String name}) async {
    try {
      final pokemonDetail = await remoteDataSource.getPokemonDetail(name);
      final pokemonSpecies =
          await remoteDataSource.getPokemonSpecies(pokemonDetail.species.url);
      final PokemonDetailAboutEntity pokemonDetailAboutEntity =
          PokemonDetailAboutEntity(
        height: pokemonDetail.height,
        weight: pokemonDetail.weight,
        species: pokemonDetail.species.name,
        abilities: pokemonDetail.abilities
            .map((ability) => ability.ability.name)
            .toList(),
        eggGroups:
            pokemonSpecies.eggGroups.map((eggGroup) => eggGroup.name).toList(),
        gender:
            PokemonGenerator.instance.getGenderRatio(pokemonSpecies.genderRate),
      );
      return Right(pokemonDetailAboutEntity);
    } on DioException catch (e) {
      return Left(ServerFailure(e.message ?? 'Failed to fetch Pokemon data'));
    } catch (e) {
      return const Left(ServerFailure('An unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, PokemonDetailStatsEntity>> getPokemonStats(
      {required String name}) async {
    try {
      final pokemonDetail = await remoteDataSource.getPokemonDetail(name);
      final stats = PokemonDetailStatsEntity(
        total: pokemonDetail.stats
            .map((stat) => stat.baseStat)
            .reduce((a, b) => a + b),
        type: PokemonGenerator.instance.getTypeName(pokemonDetail.stats
            .map((stat) => stat.baseStat)
            .reduce((a, b) => a + b)),
        descriptionOfType:
            'The type of ${pokemonDetail.name} is ${PokemonGenerator.instance.getTypeName(pokemonDetail.stats.map((stat) => stat.baseStat).reduce((a, b) => a + b))}.',
        stats: pokemonDetail.stats
            .map(
              (stat) => PokemonStats(
                name: stat.stat.name,
                baseStat: stat.baseStat,
              ),
            )
            .toList(),
      );

      return Right(stats);
    } on DioException catch (e) {
      return Left(ServerFailure(e.message ?? 'Failed to fetch Pokemon data'));
    } catch (e) {
      return const Left(ServerFailure('An unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, PokemonEvolutionEntity>> getPokemonEvolutionChain(
      int id) async {
    try {
      final pokemonSpecies = await remoteDataSource.getPokemonSpecies('$id');
      final evolutionChainUrl = pokemonSpecies.evolutionChain.url;

      final evolutionChain =
          await remoteDataSource.getPokemonEvolutionChain(evolutionChainUrl);

      List<EvolutionChain> chain =
          await _parseEvolutionChain(evolutionChain.chain);

      return Right(
        PokemonEvolutionEntity(evolutionChain: chain),
      );
    } on DioException catch (e) {
      return Left(
        ServerFailure(e.message ?? 'Failed to fetch Pokemon evolution data'),
      );
    } catch (e) {
      return const Left(
        ServerFailure('An unexpected error occurred'),
      );
    }
  }

  Future<List<EvolutionChain>> _parseEvolutionChain(dynamic chain) async {
    List<EvolutionChain> evolutionChain = [];

    final pokemonDetail =
        await remoteDataSource.getPokemonDetail(chain.species.name);

    EvolutionChain currentEvolution = EvolutionChain(
      id: pokemonDetail.id,
      name: chain.species.name,
      imageUrl: pokemonDetail.sprites.other.officialArtwork.frontDefault,
      minLevel: PokemonGenerator.instance.getMinLevel(chain.evolutionDetails),
      evolvesTo: [],
    );

    if (chain.evolvesTo.isNotEmpty) {
      for (var evolution in chain.evolvesTo) {
        List<EvolutionChain> nextEvolutions =
            await _parseEvolutionChain(evolution);
        currentEvolution.evolvesTo.addAll(nextEvolutions);
      }
    }

    evolutionChain.add(currentEvolution);
    return evolutionChain;
  }

  @override
  Future<Either<Failure, List<PokemonMoveEntity>>> getPokemonMoves(
      int id) async {
    try {
      final moveModels = await remoteDataSource.getPokemonMove(id);
      final moveEntities = moveModels.map((model) => model.toEntity()).toList();
      return Right(moveEntities);
    } on DioException catch (e) {
      return Left(
        ServerFailure(e.message ?? 'Failed to fetch Pokemon moves'),
      );
    }
  }
}
