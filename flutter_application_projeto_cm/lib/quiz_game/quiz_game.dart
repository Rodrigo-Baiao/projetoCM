import 'package:flutter/material.dart';
import 'package:flutter_application_projeto_cm/quiz_game/quiz_game_app_bar.dart';
import 'package:flutter_application_projeto_cm/ghost/money.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_projeto_cm/ghost/ghost.dart';
import 'package:flutter_application_projeto_cm/settings_page/sound.dart';

class QuizGame extends StatelessWidget {
  final GlobalKey<_QuizGamePageState> _quizGamePageKey = GlobalKey<_QuizGamePageState>();

  QuizGame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: QuizGameAppBar(
        onBackClicked: () {
          _quizGamePageKey.currentState?._resetQuiz();
        },
      ),
      body: QuizGamePage(key: _quizGamePageKey),
    );
  }
}

class QuizGamePage extends StatefulWidget {
  const QuizGamePage({Key? key}) : super(key: key);

  @override
  _QuizGamePageState createState() => _QuizGamePageState();
}

class _QuizGamePageState extends State<QuizGamePage> {
  int _currentQuestionIndex = 0;
  bool _isAnswered = false;
  bool _isCorrect = false;
  bool _showMoneyAnimation = false;
  String _selectedAnswer = '';

  void _resetQuiz() {
    setState(() {
      _currentQuestionIndex = 0;
      _isAnswered = false;
      _isCorrect = false;
      _showMoneyAnimation = false;
      _selectedAnswer = '';
    });
  }

  void _checkAnswer(bool isCorrect, String answerText) {
    final ghostSettings = Provider.of<GhostSettings>(context, listen: false);

    setState(() {
      _isAnswered = true;
      _isCorrect = isCorrect;
      _selectedAnswer = answerText;

      if (isCorrect) {
        Sound.playLevelpassed(); // Reproduz o som de nível passado
        _showMoneyAnimation = true;
        ghostSettings.money += 10;

        Future.delayed(const Duration(seconds: 2), () {
          if (mounted) {
            setState(() {
              _showMoneyAnimation = false;
              _nextQuestion();
            });
          }
        });
      } else {
        Sound.playLevelFailed(); // Reproduz o som de nível falhado
      }
    });
  }

  void _nextQuestion() {
    setState(() {
      _currentQuestionIndex++;
      _isAnswered = false;
      _isCorrect = false;
      _selectedAnswer = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final questions = [
      {
        'question': 'Quem é o amigo fantasma de Wendy, a bruxa?',
        'answers': [
          {'text': 'Casper, o Fantasminha Brincalhão', 'isCorrect': true},
          {'text': 'Fantasmão', 'isCorrect': false},
          {'text': 'Gasparzinho', 'isCorrect': false},
          {'text': 'Zé Fantasminha', 'isCorrect': false},
        ],
      },
      {
        'question': 'Qual é o nome da casa assombrada onde Scooby-Doo e sua turma investigam?',
        'answers': [
          {'text': 'Mansão Assombrada', 'isCorrect': false},
          {'text': 'Casa Fantasma', 'isCorrect': false},
          {'text': 'Mansão do Mistério', 'isCorrect': true},
          {'text': 'Casa do Terror', 'isCorrect': false},
        ],
      },
      {
        'question': 'Qual é o nome do vampiro amigável que sempre está com seu amigo lobisomem?',
        'answers': [
          {'text': 'Drácula', 'isCorrect': false},
          {'text': 'Conde Drácula', 'isCorrect': false},
          {'text': 'Conde Dráculinho', 'isCorrect': true},
          {'text': 'Conde Lobinho', 'isCorrect': false},
        ],
      },
      {
        'question': 'Qual é o nome do fantasma que adora assustar mas é muito atrapalhado?',
        'answers': [
          {'text': 'Gasparzinho', 'isCorrect': false},
          {'text': 'Assustador', 'isCorrect': false},
          {'text': 'Buu', 'isCorrect': false},
          {'text': 'Boo', 'isCorrect': true},
        ],
      },
      {
        'question': 'Qual é o nome do pequeno monstro que vive embaixo da cama e é amigo das crianças?',
        'answers': [
          {'text': 'Monstrinho', 'isCorrect': false},
          {'text': 'Bob', 'isCorrect': true},
          {'text': 'Fred', 'isCorrect': false},
          {'text': 'Zé Monstro', 'isCorrect': false},
        ],
      },
    ];

    if (_currentQuestionIndex >= questions.length) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Você completou o quiz!', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _resetQuiz,
              child: const Text('Recomeçar'),
            ),
          ],
        ),
      );
    }

    final question = questions[_currentQuestionIndex];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(height: 20),
              Text(
                question['question'] as String,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              ...((question['answers'] as List<Map<String, dynamic>>).map((answer) {
                bool isCorrectAnswer = answer['isCorrect'] as bool;
                return ElevatedButton(
                  onPressed: _isAnswered
                      ? null
                      : () => _checkAnswer(isCorrectAnswer, answer['text'] as String),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: _isAnswered
                        ? isCorrectAnswer
                            ? Colors.green
                            : (_selectedAnswer == answer['text']
                                ? Colors.red
                                : Colors.white)
                        : Colors.white,
                    side: const BorderSide(color: Colors.black, width: 1),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(answer['text'] as String, textAlign: TextAlign.center),
                );
              }).toList()),
              const SizedBox(height: 40),
              if (_isAnswered)
                ElevatedButton(
                  onPressed: _nextQuestion,
                  child: const Text('Próxima Pergunta'),
                ),
            ],
          ),
          if (_showMoneyAnimation)
            const Positioned(
              top: 200,
              left: 100,
              child: MoneyAnimation(amount: 10),
            ),
        ],
      ),
    );
  }
}
