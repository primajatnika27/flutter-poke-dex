import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/pokemon_list_controller.dart';

class PokemonListPage extends StatelessWidget {
  const PokemonListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PokemonListController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokemon List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
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
            if (scrollInfo is ScrollEndNotification &&
                scrollInfo.metrics.extentAfter == 0 &&
                !controller.isLoading.value) {
              controller.fetchPokemons();
            }
            return true;
          },
          child: GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.4,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: controller.pokemons.length +
                (controller.canLoadMore.value ? 2 : 0),
            itemBuilder: (context, index) {
              if (index >= controller.pokemons.length) {
                if (controller.isLoading.value) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: CircularProgressIndicator(),
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

              return Card(
                elevation: 0,
                color: pokemon.color,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
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
                        width: 100,
                        height: 100,
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
                                .map((type) => Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color:
                                Colors.white.withOpacity(0.2),
                                borderRadius:
                                BorderRadius.circular(12),
                              ),
                              child: Text(
                                type,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                            ))
                                .toList(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
