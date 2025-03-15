import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poke_dex/di.dart';
import 'package:poke_dex/features/pokemon/domain/entities/pokemon_entity.dart';
import 'package:poke_dex/features/pokemon/domain/usecases/get_pokemon_list_usecase.dart';

class PokemonListController extends GetxController {
  final _getPokemonListUseCase = getIt<GetPokemonListUseCase>();

  final RxList<PokemonEntity> pokemons = <PokemonEntity>[].obs;
  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;

  int _currentOffset = 0;
  static const int _limit = 20;
  final RxBool canLoadMore = true.obs;
  bool _isFetching = false;

  @override
  void onInit() {
    super.onInit();
    fetchPokemons();
  }

  Future<void> fetchPokemons() async {
    if (isLoading.value || !canLoadMore.value || _isFetching) return;

    try {
      _isFetching = true;
      isLoading.value = true;
      error.value = '';

      final result = await _getPokemonListUseCase.execute(
        limit: _limit,
        offset: _currentOffset,
      );

      result.fold(
        (failure) {
          error.value = failure.message;
          canLoadMore.value = false;
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
    } finally {
      isLoading.value = false;
      _isFetching = false;
    }
  }

  void refreshList() {
    if (_isFetching) return;
    _currentOffset = 0;
    pokemons.clear();
    error.value = '';
    canLoadMore.value = true;
    fetchPokemons();
  }

  bool shouldLoadMore(ScrollNotification scrollInfo) {
    if (!canLoadMore.value || isLoading.value || _isFetching) return false;

    const threshold = 200.0;
    final maxScroll = scrollInfo.metrics.maxScrollExtent;
    final currentScroll = scrollInfo.metrics.pixels;

    return maxScroll - currentScroll <= threshold;
  }
}
