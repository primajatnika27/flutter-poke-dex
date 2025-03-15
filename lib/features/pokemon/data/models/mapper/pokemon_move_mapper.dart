import 'package:poke_dex/features/pokemon/data/models/pokemon_move_model.dart';
import 'package:poke_dex/features/pokemon/domain/entities/pokemon_move_entity.dart';

extension PokemonMoveMapper on PokemonMove {
  PokemonMoveEntity toEntity() {
    return PokemonMoveEntity(
      name: name,
      type: type,
      power: power,
      accuracy: accuracy,
      pp: pp,
    );
  }
}