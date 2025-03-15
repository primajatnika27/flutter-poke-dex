import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:poke_dex/core/error/failures.dart';
import 'package:poke_dex/features/pokemon/domain/entities/pokemon_detail_about_entity.dart';
import 'package:poke_dex/features/pokemon/domain/entities/pokemon_detail_stats_entity.dart';
import 'package:poke_dex/features/pokemon/domain/entities/pokemon_evolution_entity.dart';
import 'package:poke_dex/features/pokemon/domain/entities/pokemon_move_entity.dart';
import 'package:poke_dex/features/pokemon/presentation/controllers/pokemon_detail_controller.dart';
import '../../../../test_helpers/test_di.dart';

void main() {
  late PokemonDetailController controller;
  late MockPokemonRepository mockRepository;

  setUp(() {
    // Setup test dependencies
    setupTestDependencies();
    mockRepository = getMockRepository();

    // Setup GetX
    Get.testMode = true;
    controller = PokemonDetailController();
    Get.put(controller);
  });

  tearDown(() {
    // Reset GetX and GetIt
    Get.reset();
    getIt.reset();
  });

  group('PokemonDetailController', () {
    const testName = 'pikachu';
    const testId = 25;

    const testAboutEntity = PokemonDetailAboutEntity(
      species: 'Mouse Pokémon',
      height: 4,
      weight: 60,
      abilities: ['static', 'lightning-rod'],
      eggGroups: ['Field', 'Fairy'],
      gender: 'Male/Female',
    );

    const testStatsEntity = PokemonDetailStatsEntity(
      total: 320,
      type: 'Electric',
      descriptionOfType: 'Electric-type Pokémon',
      stats: [
        PokemonStats(name: 'HP', baseStat: 35),
        PokemonStats(name: 'Attack', baseStat: 55),
        PokemonStats(name: 'Defense', baseStat: 40),
        PokemonStats(name: 'Special Attack', baseStat: 50),
        PokemonStats(name: 'Special Defense', baseStat: 50),
        PokemonStats(name: 'Speed', baseStat: 90),
      ],
    );

    final testEvolutionChain = [
      const EvolutionChain(
        id: 25,
        name: 'pikachu',
        imageUrl:
            'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/25.png',
        minLevel: 16,
        evolvesTo: [],
      ),
      const EvolutionChain(
        id: 26,
        name: 'raichu',
        imageUrl:
            'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/26.png',
        minLevel: 30,
        evolvesTo: [],
      ),
    ];

    final testEvolutionEntity = PokemonEvolutionEntity(
      evolutionChain: testEvolutionChain,
    );

    final testMoveEntities = [
      const PokemonMoveEntity(
        name: 'thunder-shock',
        type: 'Electric',
        power: 40,
        accuracy: 100,
        pp: 30,
      ),
      const PokemonMoveEntity(
        name: 'quick-attack',
        type: 'Normal',
        power: 40,
        accuracy: 100,
        pp: 30,
      ),
    ];

    test('initial values should be correct', () {
      expect(controller.selectedTabIndex, 0);
      expect(controller.isLoading.value, false);
      expect(controller.error.value, '');
      expect(controller.pokemonAbout.value, const PokemonDetailAboutEntity());
      expect(controller.pokemonStats.value, const PokemonDetailStatsEntity());
      expect(controller.pokemonEvolution.value,
          const PokemonEvolutionEntity(evolutionChain: []));
      expect(controller.pokemonMoves, []);
    });

    test('changeTab should update selectedTabIndex', () {
      controller.changeTab(2);
      expect(controller.selectedTabIndex, 2);
    });

    group('getPokemonAbout', () {
      test('should get pokemon about data when use case is successful',
          () async {
        // Arrange
        mockRepository.aboutResult = Right(testAboutEntity);

        // Act
        await controller.getPokemonAbout(testName);

        // Assert
        expect(controller.pokemonAbout.value, testAboutEntity);
        expect(controller.isLoading.value, false);
        expect(controller.error.value, '');
      });

      test('should set error when use case fails', () async {
        // Arrange
        final failure = ServerFailure('Server error');
        mockRepository.aboutResult = Left(failure);

        // Act
        await controller.getPokemonAbout(testName);

        // Assert
        expect(controller.isLoading.value, false);
        expect(controller.error.value, 'Server error');
      });
    });

    group('getPokemonStats', () {
      test('should get pokemon stats when use case is successful', () async {
        // Arrange
        mockRepository.statsResult = Right(testStatsEntity);

        // Act
        await controller.getPokemonStats(testName);

        // Assert
        expect(controller.pokemonStats.value, testStatsEntity);
        expect(controller.isLoading.value, false);
        expect(controller.error.value, '');
      });

      test('should set error when use case fails', () async {
        // Arrange
        final failure = ServerFailure('Server error');
        mockRepository.statsResult = Left(failure);

        // Act
        await controller.getPokemonStats(testName);

        // Assert
        expect(controller.isLoading.value, false);
        expect(controller.error.value, 'Server error');
      });
    });

    group('getPokemonEvolution', () {
      test('should get pokemon evolution when use case is successful',
          () async {
        // Arrange
        mockRepository.evolutionResult = Right(testEvolutionEntity);

        // Act
        await controller.getPokemonEvolution(testId);

        // Assert
        expect(controller.pokemonEvolution.value, testEvolutionEntity);
        expect(controller.isLoading.value, false);
        expect(controller.error.value, '');
      });

      test('should set error when use case fails', () async {
        // Arrange
        final failure = ServerFailure('Server error');
        mockRepository.evolutionResult = Left(failure);

        // Act
        await controller.getPokemonEvolution(testId);

        // Assert
        expect(controller.isLoading.value, false);
        expect(controller.error.value, 'Server error');
      });
    });

    group('getPokemonMoves', () {
      test('should get pokemon moves when use case is successful', () async {
        // Arrange
        mockRepository.movesResult = Right(testMoveEntities);

        // Act
        await controller.getPokemonMoves(testId);

        // Assert
        expect(controller.pokemonMoves, testMoveEntities);
        expect(controller.isLoading.value, false);
        expect(controller.error.value, '');
      });

      test('should set error when use case fails', () async {
        // Arrange
        final failure = ServerFailure('Server error');
        mockRepository.movesResult = Left(failure);

        // Act
        await controller.getPokemonMoves(testId);

        // Assert
        expect(controller.isLoading.value, false);
        expect(controller.error.value, 'Server error');
      });
    });
  });
}
