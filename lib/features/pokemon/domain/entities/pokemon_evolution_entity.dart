import 'package:equatable/equatable.dart';

class PokemonEvolutionEntity extends Equatable {
  final List<EvolutionChain> evolutionChain;

  const PokemonEvolutionEntity({
    required this.evolutionChain,
  });

  @override
  List<Object?> get props => [evolutionChain];
}

class EvolutionChain extends Equatable {
  final int id;
  final String name;
  final String imageUrl;
  final int minLevel;
  final List<EvolutionChain> evolvesTo;

  const EvolutionChain({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.minLevel,
    required this.evolvesTo,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        imageUrl,
        minLevel,
        evolvesTo,
      ];
}
