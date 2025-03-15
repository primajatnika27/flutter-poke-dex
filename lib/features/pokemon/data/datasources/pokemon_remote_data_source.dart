import 'package:poke_dex/features/pokemon/data/models/pokemon_detail_model.dart';
import 'package:poke_dex/features/pokemon/data/models/pokemon_evolution_chain_model.dart';
import 'package:poke_dex/features/pokemon/data/models/pokemon_move_model.dart';
import 'package:poke_dex/features/pokemon/data/models/pokemon_species.dart';

import '../models/pokemon_model.dart';

abstract class PokemonRemoteDataSource {
  Future<PokemonListResponse> getPokemonList({
    required int limit,
    required int offset,
  });
  Future<PokemonDetail> getPokemonDetail(String url);
  Future<PokemonSpecies> getPokemonSpecies(String url);

  Future<PokemonEvolutionChain> getPokemonEvolutionChain(String url);
  Future<List<PokemonMove>> getPokemonMove(int id);
}
