import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poke_dex/common/widgets/pokeball_loading.dart';
import 'package:poke_dex/features/pokemon/domain/entities/pokemon_evolution_entity.dart';
import 'package:poke_dex/features/pokemon/presentation/controllers/pokemon_detail_controller.dart';

class DetailEvolutionPoke extends GetView<PokemonDetailController> {
  final int id;

  const DetailEvolutionPoke({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    controller.getPokemonEvolution(id);
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 16,
      ),
      child: Obx(() {
        final evolution = controller.pokemonEvolution.value;

        if (evolution.evolutionChain.isEmpty && !controller.isLoading.value) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.catching_pokemon,
                  size: 64,
                  color: Colors.grey[400],
                ),
                const SizedBox(height: 16),
                Text(
                  'No Evolution Chain',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'This Pokemon does not evolve',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          );
        }

        if (controller.isLoading.value) {
          return const Center(
            child: PokeballLoading(),
          );
        }

        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Evolution Chain',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            _buildEvolutionChain(evolution.evolutionChain[0]),
          ],
        );
      }),
    );
  }

  Widget _buildEvolutionChain(EvolutionChain pokemon) {
    if (pokemon.evolvesTo.isEmpty) {
      return _buildPokemonEvolution(
        pokemon.name,
        pokemon.imageUrl,
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildPokemonEvolution(
                pokemon.name,
                pokemon.imageUrl,
              ),
              _buildEvolutionArrow('Lvl ${pokemon.evolvesTo[0].minLevel}'),
              _buildPokemonEvolution(
                pokemon.evolvesTo[0].name,
                pokemon.evolvesTo[0].imageUrl,
              ),
            ],
          ),
          if (pokemon.evolvesTo[0].evolvesTo.isNotEmpty) ...[
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildPokemonEvolution(
                  pokemon.evolvesTo[0].name,
                  pokemon.evolvesTo[0].imageUrl,
                ),
                _buildEvolutionArrow(
                  'Lvl ${pokemon.evolvesTo[0].evolvesTo[0].minLevel}',
                ),
                _buildPokemonEvolution(
                  pokemon.evolvesTo[0].evolvesTo[0].name,
                  pokemon.evolvesTo[0].evolvesTo[0].imageUrl,
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildPokemonEvolution(String name, String imageUrl) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(50),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.error),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          name.capitalize ?? name,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildEvolutionArrow(String level) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.arrow_forward,
            color: Colors.grey,
            size: 24,
          ),
          const SizedBox(height: 4),
          Text(
            level,
            style: const TextStyle(
              fontSize: 13,
              color: Colors.black54,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
