import '../models/pokemon_model.dart';

abstract class PokemonRemoteDataSource {
  Future<PokemonListResponse> getPokemonList({
    required int limit,
    required int offset,
  });
  Future<PokemonDetailResponse> getPokemonDetail(String url);
}
