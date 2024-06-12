// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_application_projeto_cm/color_game/color_game.dart';
import 'package:flutter_application_projeto_cm/minigames_page/minigame_app_bar.dart';


class MinigamesApp extends StatelessWidget {
  const MinigamesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MinigameAppBar(),
      body: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  final List<GameItem> games = [
    GameItem('Quiz', 'assets/quiz.png', const QuizGame()),
    GameItem('Clean House', 'assets/clean_house.png', const CleanHouseGame()),
    GameItem('Memory Game', 'assets/memory_game.png', const MemoryGame()),
    GameItem('Color Game', 'assets/color_game.png', ColorGame()),
  ];

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Ajuste o número de colunas conforme necessário
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1.5, // Ajuste a proporção de aspecto para diminuir o tamanho dos cartões
          ),
          itemCount: games.length,
          itemBuilder: (context, index) {
            return GameCard(game: games[index]);
          },
        ),
      ),
    );
  }
}

class GameItem {
  final String name;
  final String imagePath;
  final Widget gameWidget;

  GameItem(this.name, this.imagePath, this.gameWidget);
}

class GameCard extends StatelessWidget {
  final GameItem game;

  const GameCard({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => game.gameWidget),
        );
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(1.0), 
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                  child: Image.asset(
                    game.imagePath,
                    fit: BoxFit.contain, 
                    width: double.infinity,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                game.name,
                style: const TextStyle(
                  fontSize: 16, // Tamanho do texto ajustado
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class QuizGame extends StatelessWidget {
  const QuizGame({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Game'),
      ),
      body: const Center(
        child: Text('Quiz Game Page'),
      ),
    );
  }
}

class CleanHouseGame extends StatelessWidget {
  const CleanHouseGame({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clean House Game'),
      ),
      body: const Center(
        child: Text('Clean House Game Page'),
      ),
    );
  }
}

class MemoryGame extends StatelessWidget {
  const MemoryGame({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Memory Game'),
      ),
      body: const Center(
        child: Text('Memory Game Page'),
      ),
    );
  }
}

