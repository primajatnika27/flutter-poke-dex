import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poke_dex/common/widgets/pokeball_loading.dart';
import 'package:poke_dex/config/routes.dart';
import 'package:poke_dex/features/pokemon/presentation/widget/poke_card_widget.dart';
import '../controllers/pokemon_list_controller.dart';

class PokemonListPage extends StatelessWidget {
  const PokemonListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PokemonListController());

    return OrientationBuilder(
      builder: (context, orientation) {
        final crossAxisCount = orientation == Orientation.portrait ? 2 : 4;
        final childAspectRatio =
            orientation == Orientation.portrait ? 1.4 : 1.6;

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: Image(
              height: orientation == Orientation.portrait ? 40 : 30,
              image: const AssetImage('assets/image/title.png'),
              color: Colors.redAccent,
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.refresh),
                color: Colors.black,
                onPressed: controller.refreshList,
              ),
            ],
          ),
          body: Obx(() {
            if (controller.error.isNotEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(controller.error.value),
                    ElevatedButton(
                      onPressed: controller.refreshList,
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            return NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollInfo) {
                if (scrollInfo is ScrollEndNotification) {
                  if (controller.shouldLoadMore(scrollInfo)) {
                    controller.fetchPokemons();
                  }
                }
                return true;
              },
              child: GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  childAspectRatio: childAspectRatio,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: controller.pokemons.length +
                    (controller.canLoadMore.value ? 2 : 0),
                itemBuilder: (context, index) {
                  if (index >= controller.pokemons.length) {
                    if (controller.isLoading.value) {
                      return const Center(
                        child: SizedBox(
                          height: 24,
                          width: 24,
                          child: PokeballLoading(),
                        ),
                      );
                    }
                    if (!controller.canLoadMore.value) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text('No more Pokemon'),
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  }

                  final pokemon = controller.pokemons[index];

                  return PokeCardWidget(
                    pokemon: pokemon,
                    onTapped: () {
                      Get.toNamed(
                        Routes.pokemonDetail,
                        arguments: pokemon,
                      );
                    },
                  );
                },
              ),
            );
          }),
        );
      },
    );
  }
}
