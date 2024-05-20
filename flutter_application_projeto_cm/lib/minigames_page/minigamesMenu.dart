import 'package:flutter/material.dart';
import 'package:flutter_application_projeto_cm/color_game/color_game.dart';


class MinigamesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mini Jogos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  final List<GameItem> games = [
    GameItem('Quiz', 'assets/quiz.png', QuizGame()),
    GameItem('Clean House', 'assets/clean_house.png', CleanHouseGame()),
    GameItem('Memory Game', 'assets/memory_game.png', MemoryGame()),
    GameItem('Color Game', 'assets/color_game.png', ColorGame()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(top: 16.0), // Ajuste a distância do topo conforme necessário
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              Expanded(
                child: Text(
                  'MiniGames',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20),
                ),
              ),
              const SizedBox(width: 48), // Espaçamento para equilibrar a largura do ícone
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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

  GameCard({required this.game});

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
                padding: const EdgeInsets.all(1.0), // Adiciona padding para diminuir a imagem
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                  child: Image.asset(
                    game.imagePath,
                    fit: BoxFit.contain, // Ajusta a imagem para conter dentro do espaço disponível
                    width: double.infinity,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                game.name,
                style: TextStyle(
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz Game'),
      ),
      body: Center(
        child: Text('Quiz Game Page'),
      ),
    );
  }
}

class CleanHouseGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clean House Game'),
      ),
      body: Center(
        child: Text('Clean House Game Page'),
      ),
    );
  }
}

class MemoryGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Memory Game'),
      ),
      body: Center(
        child: Text('Memory Game Page'),
      ),
    );
  }
}

