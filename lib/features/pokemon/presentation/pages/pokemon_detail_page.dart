import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poke_dex/common/widgets/badge_custom.dart';
import 'package:poke_dex/features/pokemon/domain/entities/pokemon_entity.dart';
import 'package:poke_dex/features/pokemon/presentation/controllers/pokemon_detail_controller.dart';
import 'package:poke_dex/features/pokemon/presentation/widget/detail_about_poke.dart';
import 'package:poke_dex/features/pokemon/presentation/widget/detail_base_stats_poke.dart';
import 'package:poke_dex/features/pokemon/presentation/widget/detail_evolution_poke.dart';
import 'package:poke_dex/features/pokemon/presentation/widget/detail_moves_poke.dart';

class PokemonDetailPage extends StatelessWidget {
  PokemonDetailPage({super.key});

  final controller = Get.put(PokemonDetailController());
  final args = Get.arguments as PokemonEntity;

  Widget _buildTabContent() {
    return Obx(() {
      switch (controller.selectedTabIndex) {
        case 0:
          return DetailAboutPoke(name: args.name);
        case 1:
          return DetailBaseStatsPoke(name: args.name);
        case 2:
          return DetailEvolutionPoke(id: args.id);
        case 3:
          return DetailMovesPoke(id: args.id);
        default:
          return DetailAboutPoke(name: args.name);
      }
    });
  }

  Widget _buildTab(String title, int index) {
    return Obx(() {
      final isSelected = controller.selectedTabIndex == index;
      return OutlinedButton(
        onPressed: () => controller.changeTab(index),
        style: ButtonStyle(
          side: MaterialStateProperty.all(BorderSide.none),
          overlayColor: MaterialStateProperty.all(Colors.transparent),
          shadowColor: MaterialStateProperty.all(Colors.transparent),
          backgroundColor: MaterialStateProperty.all(Colors.transparent),
          shape: MaterialStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide.none,
            ),
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.black : Colors.black38,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            fontSize: 16,
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape = Get.mediaQuery.orientation == Orientation.landscape;

    return Scaffold(
      body: Stack(
        children: [
          // Background color
          Container(
            color: args.color,
          ),
          // Background pokeball
          Positioned(
            right: -130,
            top: isLandscape ? 0 : 150,
            child: Image.asset(
              'assets/image/bg_pokeball.png',
              width: 400,
              height: 400,
              color: Colors.white.withOpacity(0.2),
            ),
          ),
          // Main content
          Column(
            children: [
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 56,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                              onPressed: () => Navigator.pop(context),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.favorite_border,
                                color: Colors.white,
                              ),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              args.name.capitalizeFirst ?? '',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '#00${args.id}',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.8),
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          children: args.types
                              .map(
                                (e) => Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: BadgeCustom(type: e, size: 'large'),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: isLandscape ? 20 : 170),
              // Content section with tabs
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: isLandscape ? 20 : 30),
                      // Tabs
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: isLandscape ? 8 : 16,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildTab('About', 0),
                            _buildTab('Base Stats', 1),
                            _buildTab('Evolution', 2),
                            _buildTab('Moves', 3),
                          ],
                        ),
                      ),
                      const Divider(),
                      // Tab content with scroll
                      Expanded(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: _buildTabContent(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          // Pokemon image on top
          Positioned(
            top: isLandscape ? 60 : 120,
            left: 0,
            right: 0,
            child: Padding(
              padding: EdgeInsets.only(
                top: isLandscape ? 0 : MediaQuery.of(context).padding.top,
              ),
              child: Hero(
                tag: 'pokemon-image-${args.id}',
                child: Image.network(
                  args.imageUrl,
                  width: isLandscape ? 150 : 220,
                  height: isLandscape ? 150 : 220,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.error_outline,
                    color: Colors.white,
                    size: 60,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
