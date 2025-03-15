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
      return GestureDetector(
        onTap: () => controller.changeTab(index),
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
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: args.color,
          ),
          Positioned(
            right: -130,
            top: 150,
            child: Image.asset(
              'assets/image/bg_pokeball.png',
              width: 400,
              height: 400,
              color: Colors.white.withOpacity(0.2),
            ),
          ),
          Column(
            children: [
              SafeArea(
                child: Column(
                  children: [
                    Row(
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
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
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
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      child: Row(
                        children: args.types
                            .map(
                              (e) => Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: BadgeCustom(type: e, size: 'large',),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    const SizedBox(height: 200),
                  ],
                ),
              ),

              // Tab navigation and content
              Expanded(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
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
                          const SizedBox(
                            height: 30,
                          ),
                          // Tabs
                          Padding(
                            padding: const EdgeInsets.only(top: 24, bottom: 16),
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
                          // Tab content
                          Expanded(
                            child: _buildTabContent(),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: -170,
                      left: 0,
                      right: 0,
                      child: Image.network(
                        args.imageUrl,
                        width: 220,
                        height: 220,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(
                          Icons.error_outline,
                          color: Colors.white,
                          size: 60,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
