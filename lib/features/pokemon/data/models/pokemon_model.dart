class PokemonListResponse {
  final List<PokemonBasicInfo> results;

  PokemonListResponse({
    required this.results,
  });

  factory PokemonListResponse.fromJson(Map<String, dynamic> json) {
    return PokemonListResponse(
      results: (json['results'] as List)
          .map((e) => PokemonBasicInfo.fromJson(e))
          .toList(),
    );
  }
}

class PokemonBasicInfo {
  final String name;
  final String url;

  PokemonBasicInfo({
    required this.name,
    required this.url,
  });

  factory PokemonBasicInfo.fromJson(Map<String, dynamic> json) {
    return PokemonBasicInfo(
      name: json['name'],
      url: json['url'],
    );
  }
}

class PokemonDetailResponse {
  final int id;
  final String name;
  final List<PokemonType> types;
  final Sprites sprites;

  PokemonDetailResponse({
    required this.id,
    required this.name,
    required this.types,
    required this.sprites,
  });

  factory PokemonDetailResponse.fromJson(Map<String, dynamic> json) {
    return PokemonDetailResponse(
      id: json['id'],
      name: json['name'],
      types:
          (json['types'] as List).map((e) => PokemonType.fromJson(e)).toList(),
      sprites: Sprites.fromJson(json['sprites']),
    );
  }
}

class PokemonType {
  final Type type;

  PokemonType({
    required this.type,
  });

  factory PokemonType.fromJson(Map<String, dynamic> json) {
    return PokemonType(
      type: Type.fromJson(json['type']),
    );
  }
}

class Type {
  final String name;

  Type({
    required this.name,
  });

  factory Type.fromJson(Map<String, dynamic> json) {
    return Type(
      name: json['name'],
    );
  }
}

class Sprites {
  final String frontDefault;

  Sprites({
    required this.frontDefault,
  });

  factory Sprites.fromJson(Map<String, dynamic> json) {
    return Sprites(
      frontDefault: json['front_default'],
    );
  }
}
