import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poke_dex/config/routes.dart';
import 'di.dart';
import 'features/pokemon/presentation/pages/pokemon_list_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Pokedex',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.redAccent),
        useMaterial3: true,
      ),
      getPages: AppRoutes.routes,
      initialRoute: Routes.home,
      home: const PokemonListPage(),
    );
  }
}
