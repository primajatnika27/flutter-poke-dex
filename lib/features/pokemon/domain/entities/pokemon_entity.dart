import 'dart:ui';

import 'package:equatable/equatable.dart';

class PokemonEntity extends Equatable {
  final int id;
  final String name;
  final String imageUrl;
  final Color color;
  final List<String> types;

  const PokemonEntity({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.color,
    required this.types,
  });

  @override
  List<Object?> get props => [id, name, imageUrl, color, types];
}
