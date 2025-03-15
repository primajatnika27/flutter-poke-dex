import 'package:equatable/equatable.dart';

class PokemonDetailStatsEntity extends Equatable {
  final int? total;
  final String? type;
  final String? descriptionOfType;
  final List<PokemonStats>? stats;


  const PokemonDetailStatsEntity({
    this.total,
    this.type,
    this.descriptionOfType,
    this.stats,
  });

  @override
  List<Object?> get props => [total, stats, type, descriptionOfType];
}

class PokemonStats extends Equatable {
  final String? name;
  final int? baseStat;

  const PokemonStats({this.name, this.baseStat});

  @override
  List<Object?> get props => [name, baseStat];
}