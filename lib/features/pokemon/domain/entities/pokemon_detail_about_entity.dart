import 'package:equatable/equatable.dart';

class PokemonDetailAboutEntity extends Equatable {
  final String? species;
  final int? height;
  final int? weight;
  final List<String>? abilities;
  final List<String>? eggGroups;
  final String? gender;

  const PokemonDetailAboutEntity({
    this.species,
    this.height,
    this.weight,
    this.abilities,
    this.eggGroups,
    this.gender
  });

  @override
  List<Object?> get props => [species, height, weight, abilities, eggGroups, gender];

}