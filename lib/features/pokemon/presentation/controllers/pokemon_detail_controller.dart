import 'package:get/get.dart';
import 'package:poke_dex/di.dart';
import 'package:poke_dex/features/pokemon/domain/entities/pokemon_detail_about_entity.dart';
import 'package:poke_dex/features/pokemon/domain/entities/pokemon_detail_stats_entity.dart';
import 'package:poke_dex/features/pokemon/domain/entities/pokemon_evolution_entity.dart';
import 'package:poke_dex/features/pokemon/domain/entities/pokemon_move_entity.dart';
import 'package:poke_dex/features/pokemon/domain/usecases/get_pokemon_detail_usecase.dart';
import 'package:poke_dex/features/pokemon/domain/usecases/get_pokemon_evolution_chain.dart';
import 'package:poke_dex/features/pokemon/domain/usecases/get_pokemon_move_usecase.dart';

class PokemonDetailController extends GetxController {
  final _getAboutPokemonUseCase = getIt<GetPokemonAboutUseCase>();
  final _getEvolutionChainUseCase = getIt<GetPokemonEvolutionChainUseCase>();
  final _getPokemonMoveUseCase = getIt<GetPokemonMoveUseCase>();

  final Rx<PokemonDetailAboutEntity> pokemonAbout =
      const PokemonDetailAboutEntity().obs;
  final Rx<PokemonDetailStatsEntity> pokemonStats =
      const PokemonDetailStatsEntity().obs;
  final Rx<PokemonEvolutionEntity> pokemonEvolution =
      const PokemonEvolutionEntity(evolutionChain: []).obs;
  final RxList<PokemonMoveEntity> pokemonMoves = <PokemonMoveEntity>[].obs;
  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;

  final _selectedTabIndex = 0.obs;
  final showProgress = false.obs;

  int get selectedTabIndex => _selectedTabIndex.value;

  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(milliseconds: 300), () {
      showProgress.value = true;
    });
  }

  void changeTab(int index) {
    _selectedTabIndex.value = index;
  }

  Future<void> getPokemonAbout(String name) async {
    isLoading.value = true;
    final result = await _getAboutPokemonUseCase.executeAbout(name);
    result.fold((l) => error.value = l.message, (r) => pokemonAbout.value = r);
    isLoading.value = false;
  }

  Future<void> getPokemonStats(String name) async {
    isLoading.value = true;
    final result = await _getAboutPokemonUseCase.executeStats(name);
    result.fold((l) => error.value = l.message, (r) => pokemonStats.value = r);
    isLoading.value = false;
  }

  Future<void> getPokemonEvolution(int id) async {
    isLoading.value = true;
    print("INI ID $id");
    final result = await _getEvolutionChainUseCase.execute(id);
    print("INI RESULT EVOLUTION $result");
    result.fold(
        (l) => error.value = l.message, (r) => pokemonEvolution.value = r);
    isLoading.value = false;
  }

  Future<void> getPokemonMoves(int id) async {
    isLoading.value = true;
    final result = await _getPokemonMoveUseCase.execute(id);
    result.fold(
          (failure) => error.value = failure.message,
          (moves) => pokemonMoves.value = moves,
    );
    isLoading.value = false;
  }
}
