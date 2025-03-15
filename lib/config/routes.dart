import 'package:get/get.dart';
import 'package:poke_dex/features/pokemon/presentation/pages/pokemon_detail_page.dart';
import 'package:poke_dex/features/pokemon/presentation/pages/pokemon_list_page.dart';

class Routes {
  static const String home = '/';
  static const String pokemonDetail = '/pokemon-detail';
}

class AppRoutes {
  static final routes = [
    GetPage(
      name: Routes.home,
      page: () => const PokemonListPage(),
    ),
    GetPage(
      name: Routes.pokemonDetail,
      page: () => PokemonDetailPage(),
    ),
  ];
}
