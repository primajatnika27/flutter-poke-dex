import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poke_dex/common/widgets/pokeball_loading.dart';
import 'package:poke_dex/features/pokemon/presentation/controllers/pokemon_detail_controller.dart';

class DetailBaseStatsPoke extends GetView<PokemonDetailController> {
  final String name;
  const DetailBaseStatsPoke({super.key, required this.name});

  Color _getStatColor(int value) {
    if (value < 50) return Colors.red.shade400;
    return Colors.green.shade400;
  }

  Widget _buildStatRow(String label, int value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(
            width: 30,
            child: Text(
              value.toString(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                Container(
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.easeInOut,
                  height: 4,
                  width: (value / 100) * Get.size.width * 0.5,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    controller.getPokemonStats(name);

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 24,
      ),
      child: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: PokeballLoading(),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            controller.pokemonStats.value.stats != null
                ? Column(
                    children: controller.pokemonStats.value.stats!
                        .map(
                          (e) => _buildStatRow(
                            e.name ?? '',
                            e.baseStat ?? 0,
                            _getStatColor(e.baseStat ?? 0),
                          ),
                        )
                        .toList(),
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
            _buildStatRow(
              'Total',
              controller.pokemonStats.value.total ?? 0,
              Colors.green.shade400,
            ),
            const SizedBox(height: 16),
            Text(
              'Type ${controller.pokemonStats.value.type ?? ''}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              controller.pokemonStats.value.descriptionOfType ?? '',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
          ],
        );
      }),
    );
  }
}
