import 'dart:convert';

PokemonSpecies pokemonSpeciesFromJson(String str) => PokemonSpecies.fromJson(json.decode(str));

String pokemonSpeciesToJson(PokemonSpecies data) => json.encode(data.toJson());

class PokemonSpecies {
  int baseHappiness;
  int captureRate;
  Color color;
  List<Color> eggGroups;
  EvolutionChain evolutionChain;
  int genderRate;
  int hatchCounter;

  PokemonSpecies({
    required this.baseHappiness,
    required this.captureRate,
    required this.color,
    required this.eggGroups,
    required this.evolutionChain,
    required this.genderRate,
    required this.hatchCounter,
  });

  factory PokemonSpecies.fromJson(Map<String, dynamic> json) => PokemonSpecies(
    baseHappiness: json["base_happiness"],
    captureRate: json["capture_rate"],
    color: Color.fromJson(json["color"]),
    eggGroups: List<Color>.from(json["egg_groups"].map((x) => Color.fromJson(x))),
    evolutionChain: EvolutionChain.fromJson(json["evolution_chain"]),
    genderRate: json["gender_rate"],
    hatchCounter: json["hatch_counter"],
  );

  Map<String, dynamic> toJson() => {
    "base_happiness": baseHappiness,
    "capture_rate": captureRate,
    "color": color.toJson(),
    "egg_groups": List<dynamic>.from(eggGroups.map((x) => x.toJson())),
    "evolution_chain": evolutionChain.toJson(),
    "gender_rate": genderRate,
    "hatch_counter": hatchCounter,
  };
}

class Color {
  String name;
  String url;

  Color({
    required this.name,
    required this.url,
  });

  factory Color.fromJson(Map<String, dynamic> json) => Color(
    name: json["name"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "url": url,
  };
}

class EvolutionChain {
  String url;

  EvolutionChain({
    required this.url,
  });

  factory EvolutionChain.fromJson(Map<String, dynamic> json) => EvolutionChain(
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
  };
}

class FlavorTextEntry {
  String flavorText;
  Color language;
  Color version;

  FlavorTextEntry({
    required this.flavorText,
    required this.language,
    required this.version,
  });

  factory FlavorTextEntry.fromJson(Map<String, dynamic> json) => FlavorTextEntry(
    flavorText: json["flavor_text"],
    language: Color.fromJson(json["language"]),
    version: Color.fromJson(json["version"]),
  );

  Map<String, dynamic> toJson() => {
    "flavor_text": flavorText,
    "language": language.toJson(),
    "version": version.toJson(),
  };
}

class FormDescription {
  String description;
  Color language;

  FormDescription({
    required this.description,
    required this.language,
  });

  factory FormDescription.fromJson(Map<String, dynamic> json) => FormDescription(
    description: json["description"],
    language: Color.fromJson(json["language"]),
  );

  Map<String, dynamic> toJson() => {
    "description": description,
    "language": language.toJson(),
  };
}

class Genus {
  String genus;
  Color language;

  Genus({
    required this.genus,
    required this.language,
  });

  factory Genus.fromJson(Map<String, dynamic> json) => Genus(
    genus: json["genus"],
    language: Color.fromJson(json["language"]),
  );

  Map<String, dynamic> toJson() => {
    "genus": genus,
    "language": language.toJson(),
  };
}

class Name {
  Color language;
  String name;

  Name({
    required this.language,
    required this.name,
  });

  factory Name.fromJson(Map<String, dynamic> json) => Name(
    language: Color.fromJson(json["language"]),
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "language": language.toJson(),
    "name": name,
  };
}

class PokedexNumber {
  int entryNumber;
  Color pokedex;

  PokedexNumber({
    required this.entryNumber,
    required this.pokedex,
  });

  factory PokedexNumber.fromJson(Map<String, dynamic> json) => PokedexNumber(
    entryNumber: json["entry_number"],
    pokedex: Color.fromJson(json["pokedex"]),
  );

  Map<String, dynamic> toJson() => {
    "entry_number": entryNumber,
    "pokedex": pokedex.toJson(),
  };
}

class Variety {
  bool isDefault;
  Color pokemon;

  Variety({
    required this.isDefault,
    required this.pokemon,
  });

  factory Variety.fromJson(Map<String, dynamic> json) => Variety(
    isDefault: json["is_default"],
    pokemon: Color.fromJson(json["pokemon"]),
  );

  Map<String, dynamic> toJson() => {
    "is_default": isDefault,
    "pokemon": pokemon.toJson(),
  };
}
