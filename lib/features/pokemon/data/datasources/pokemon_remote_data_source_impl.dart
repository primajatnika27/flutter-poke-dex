import 'package:poke_dex/common/network/dio_client.dart';
import 'package:poke_dex/core/error/failures.dart';
import 'package:poke_dex/features/pokemon/data/models/pokemon_detail_model.dart';
import 'package:poke_dex/features/pokemon/data/models/pokemon_evolution_chain_model.dart';
import 'package:poke_dex/features/pokemon/data/models/pokemon_model.dart';
import 'package:poke_dex/features/pokemon/data/models/pokemon_move_model.dart';
import 'package:poke_dex/features/pokemon/data/models/pokemon_species.dart';
import 'pokemon_remote_data_source.dart';

class PokemonRemoteDataSourceImpl implements PokemonRemoteDataSource {
  final DioClient dioClient;

  PokemonRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<PokemonListResponse> getPokemonList({
    required int limit,
    required int offset,
  }) async {
    final response = await dioClient.get(
      'pokemon',
      queryParameters: {
        'limit': limit,
        'offset': offset,
      },
    );
    return PokemonListResponse.fromJson(response.data);
  }

  @override
  Future<PokemonDetail> getPokemonDetail(String url) async {
    final pokemonId = url.split('/').where((e) => e.isNotEmpty).last;
    final response = await dioClient.get('pokemon/$pokemonId');
    return PokemonDetail.fromJson(response.data);
  }

  @override
  Future<PokemonSpecies> getPokemonSpecies(String url) async {
    final pokemonId = url.split('/').where((e) => e.isNotEmpty).last;
    final response = await dioClient.get('pokemon-species/$pokemonId');
    return PokemonSpecies.fromJson(response.data);
  }

  @override
  Future<PokemonEvolutionChain> getPokemonEvolutionChain(String url) async {
    final pokemonId = url.split('/').where((e) => e.isNotEmpty).last;
    final response = await dioClient.get('evolution-chain/$pokemonId');
    return PokemonEvolutionChain.fromJson(response.data);
  }

  @override
  Future<List<PokemonMove>> getPokemonMove(int id) async {
    try {
      final response = await dioClient.get('pokemon/$id');
      final List<dynamic> movesList = response.data['moves'];

      List<PokemonMove> moves = [];
      for (int i = 0; i < 5; i++) {
        final moveUrl = movesList[i]['move']['url'];
        final moveResponse = await dioClient.get(moveUrl);

        moves.add(PokemonMove.fromJson(moveResponse.data));
      }

      return moves;
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }
}
