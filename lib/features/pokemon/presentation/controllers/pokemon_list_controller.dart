import 'package:get/get.dart';
import '../../../../di.dart';
import '../../domain/entities/pokemon_entity.dart';
import '../../domain/usecases/get_pokemon_list_usecase.dart';

class PokemonListController extends GetxController {
  final _getPokemonListUseCase = getIt<GetPokemonListUseCase>();

  final RxList<PokemonEntity> pokemons = <PokemonEntity>[].obs;
  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;

  int _currentOffset = 0;
  static const int _limit = 20;
  final RxBool canLoadMore = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchPokemons();
  }

  Future<void> fetchPokemons() async {
    if (isLoading.value || !canLoadMore.value) return;

    isLoading.value = true;
    error.value = '';

    final result = await _getPokemonListUseCase.execute(
      limit: _limit,
      offset: _currentOffset,
    );

    result.fold(
      (failure) {
        error.value = failure.message;
      },
      (newPokemons) {
        if (newPokemons.isEmpty) {
          canLoadMore.value = false;
        } else {
          pokemons.addAll(newPokemons);
          _currentOffset += _limit;
        }
      },
    );

    isLoading.value = false;
  }

  void refreshList() {
    _currentOffset = 0;
    pokemons.clear();
    canLoadMore.value = true;
    fetchPokemons();
  }
}
