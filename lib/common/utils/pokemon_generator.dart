class PokemonGenerator {
  PokemonGenerator._();

  static final instance = PokemonGenerator._();

  String getGenderRatio(int genderRate) {
    if (genderRate == 0) {
      return '';
    }

    final femalePercentage = (genderRate * 12.5).toStringAsFixed(1);
    final malePercentage = (100 - (genderRate * 12.5)).toStringAsFixed(1);
    return '♀$femalePercentage%  ♂$malePercentage%';
  }

  String getTypeName(int total) {
    if (total >= 450) {
      return 'Attacker';
    } else if (total >= 300) {
      return 'Defender';
    } else if (total >= 200) {
      return 'Speedster';
    } else {
      return 'Utility';
    }
  }

  int getMinLevel(List<dynamic> evolutionDetails) {
    if (evolutionDetails.isEmpty) return 1;

    final minLevel = evolutionDetails[0].minLevel;
    return minLevel ?? 1;
  }
}