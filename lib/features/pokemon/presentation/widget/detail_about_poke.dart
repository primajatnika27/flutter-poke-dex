import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poke_dex/common/widgets/pokeball_loading.dart';
import 'package:poke_dex/features/pokemon/presentation/controllers/pokemon_detail_controller.dart';
import 'package:poke_dex/features/pokemon/presentation/widget/row_info_widget.dart';

class DetailAboutPoke extends GetView<PokemonDetailController> {
  final String name;
  const DetailAboutPoke({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    controller.getPokemonAbout(name);

    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(
          child: PokeballLoading(),
        );
      }

      return SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RowInfoWidget(
              label: 'Species',
              value: controller.pokemonAbout.value.species?.capitalizeFirst ?? '',
            ),
            RowInfoWidget(
              label: 'Height',
              value: '${controller.pokemonAbout.value.height} m',
            ),
            RowInfoWidget(
              label: 'Weight',
              value: '${controller.pokemonAbout.value.weight} lb',
            ),
            RowInfoWidget(
              label: 'Abilities',
              value: controller.pokemonAbout.value.abilities?.join(', ').capitalizeFirst ?? '',
            ),
            const SizedBox(height: 24),
            const Text(
              'Breeding',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            RowInfoWidget(
              label: 'Gender',
              value: controller.pokemonAbout.value.gender ?? '',
            ),
            RowInfoWidget(
              label: 'Egg Groups',
              value: controller.pokemonAbout.value.eggGroups?.join(', ').capitalizeFirst ?? '',
            ),
          ],
        ),
      );
    });
  }
}
