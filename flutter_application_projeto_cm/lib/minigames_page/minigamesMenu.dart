import 'package:flutter/material.dart';
import 'package:flutter_application_projeto_cm/color_game/color_game.dart';
import 'package:flutter_application_projeto_cm/memory_game/memory_game.dart';
import 'package:flutter_application_projeto_cm/quiz_game/quiz_game.dart';
import 'package:flutter_application_projeto_cm/minigames_page/minigame_app_bar.dart';
import 'package:flutter_application_projeto_cm/clean_game/cleaning_minigame.dart'; // Import the new file

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
    GameItem('Quiz', 'assets/quiz.png', QuizGame()),
    GameItem('Clean House', 'assets/clean_house.png', const CleaningMinigame()), // Update to new widget
    GameItem('Memory Game', 'assets/memory_game.png',  MemoryGame()),
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
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1.5,
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
                  fontSize: 16,
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

