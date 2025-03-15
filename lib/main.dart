import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
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
        useMaterial3: false,
      ),
      getPages: AppRoutes.routes,
      initialRoute: Routes.home,
      home: FlutterSplashScreen.fadeIn(
        backgroundColor: Colors.red,
        childWidget: Image.asset(
          'assets/image/splash.png',
          fit: BoxFit.fitWidth,
        ),
        duration: const Duration(seconds: 2),
        nextScreen: const PokemonListPage(),
      ),
    );
  }
}
