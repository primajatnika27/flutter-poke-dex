import 'package:dio/dio.dart';
import '../../../../common/network/dio_client.dart';
import '../models/pokemon_model.dart';
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
  Future<PokemonDetailResponse> getPokemonDetail(String url) async {
    // Extract the ID from the full URL
    final pokemonId = url.split('/').where((e) => e.isNotEmpty).last;
    final response = await dioClient.get('pokemon/$pokemonId');
    return PokemonDetailResponse.fromJson(response.data);
  }
}
