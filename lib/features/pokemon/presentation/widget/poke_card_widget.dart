import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poke_dex/common/widgets/badge_custom.dart';
import 'package:poke_dex/features/pokemon/domain/entities/pokemon_entity.dart';

class PokeCardWidget extends StatelessWidget {
  final PokemonEntity pokemon;
  final Function() onTapped;
  const PokeCardWidget({super.key, required this.pokemon, required this.onTapped});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: pokemon.color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: onTapped,
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            Positioned(
              right: -70,
              bottom: -50,
              child: Image.asset(
                'assets/image/bg_pokeball.png',
                width: 200,
                height: 200,
                color: Colors.white.withOpacity(0.2),
              ),
            ),
            Positioned(
              right: 0,
              bottom: 10,
              child: Image.network(
                pokemon.imageUrl,
                width: 70,
                height: 70,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.error, color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pokemon.name.capitalize ?? pokemon.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Wrap(
                    direction: Axis.vertical,
                    spacing: 4,
                    children: pokemon.types
                        .map(
                          (type) => BadgeCustom(type: type),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
