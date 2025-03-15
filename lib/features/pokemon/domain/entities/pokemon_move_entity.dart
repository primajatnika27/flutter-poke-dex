import 'package:equatable/equatable.dart';

class PokemonMoveEntity extends Equatable {
  final String name;
  final String type;
  final int? power;
  final int? accuracy;
  final int pp;

  const PokemonMoveEntity({
    required this.name,
    required this.type,
    this.power,
    this.accuracy,
    required this.pp,
  });

  @override
  List<Object?> get props => [name, type, power, accuracy, pp];
}