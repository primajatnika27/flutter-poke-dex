class PokemonMove {
  final String name;
  final String type;
  final int? power;
  final int? accuracy;
  final int pp;

  PokemonMove({
    required this.name,
    required this.type,
    this.power,
    this.accuracy,
    required this.pp,
  });

  factory PokemonMove.fromJson(Map<String, dynamic> json) {
    return PokemonMove(
      name: json['name'] as String,
      type: json['type']['name'] as String,
      power: json['power'] as int?,
      accuracy: json['accuracy'] as int?,
      pp: json['pp'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'type': type,
    'power': power,
    'accuracy': accuracy,
    'pp': pp,
  };
}