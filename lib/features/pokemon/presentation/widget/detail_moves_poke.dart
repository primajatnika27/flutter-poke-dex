import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poke_dex/common/utils/pokemon_colors.dart';
import 'package:poke_dex/common/widgets/pokeball_loading.dart';
import 'package:poke_dex/features/pokemon/domain/entities/pokemon_move_entity.dart';
import 'package:poke_dex/features/pokemon/presentation/controllers/pokemon_detail_controller.dart';

class DetailMovesPoke extends GetView<PokemonDetailController> {
  final int id;

  const DetailMovesPoke({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    controller.getPokemonMoves(id);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: PokeballLoading(),
          );
        }

        if (controller.pokemonMoves.isEmpty && !controller.isLoading.value) {
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
                  'No Moves Available',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'This Pokemon has no moves yet',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Moves',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            ListView.separated(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.pokemonMoves.length,
              separatorBuilder: (context, index) =>
              const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final move = controller.pokemonMoves[index];
                return _buildMoveCard(move);
              },
            ),
          ],
        );
      }),
    );
  }

  Widget _buildMoveCard(PokemonMoveEntity move) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: PokemonColors.instance.getTypeColor(move.type).withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color:
          PokemonColors.instance.getTypeColor(move.type).withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  move.name.capitalize ?? move.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: PokemonColors.instance.getTypeColor(move.type),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  move.type.toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildMoveInfo('Power', move.power?.toString() ?? '-'),
                const SizedBox(width: 24),
                _buildMoveInfo('Accuracy', '${move.accuracy ?? '-'}%'),
                const SizedBox(width: 24),
                _buildMoveInfo('PP', move.pp.toString()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMoveInfo(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
