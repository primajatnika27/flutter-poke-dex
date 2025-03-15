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
