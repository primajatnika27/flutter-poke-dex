import 'dart:ui';

class PokemonColors {
  PokemonColors._();

  static final instance = PokemonColors._();

  Color getTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'grass':
        return const Color(0xFF98D7A5); // Mint green
      case 'fire':
        return const Color(0xFFF4948E); // Soft red
      case 'water':
        return const Color(0xFF95B9E0); // Light blue
      case 'bug':
        return const Color(0xFF7A9A4F); // Olive green
      case 'dark':
        return const Color(0xFF7D6E6E); // Dark grayish brown
      case 'dragon':
        return const Color(0xFF6A5ACD); // Slate blue
      case 'electric':
        return const Color(0xFFFFD700); // Yellow
      case 'fairy':
        return const Color(0xFFFFC0CB); // Light pink
      case 'fighting':
        return const Color(0xFFD95D39); // Red-orange
      case 'flying':
        return const Color(0xFF82BFFF); // Sky blue
      case 'ghost':
        return const Color(0xFF8A7F95); // Lavender gray
      case 'ground':
        return const Color(0xFFC2B280); // Sand beige
      case 'ice':
        return const Color(0xFF66CCFF); // Ice blue
      case 'normal':
        return const Color(0xFFD8D8D8); // Light gray
      case 'poison':
        return const Color(0xFF9B4D99); // Purple
      case 'psychic':
        return const Color(0xFFFC8A85); // Light pinkish red
      case 'rock':
        return const Color(0xFFD7B57E); // Tan
      case 'steel':
        return const Color(0xFFB7B8B9); // Steel gray
      case 'water':
        return const Color(0xFF95B9E0); // Light blue
      default:
        return const Color(0xFFC0C0C0); // Gray for unknown types
    }
  }
}