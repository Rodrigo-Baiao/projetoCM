// ignore_for_file: library_private_types_in_public_api

import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_projeto_cm/color_game/color_game_app_bar.dart';


class ColorGame extends StatelessWidget {


  final GlobalKey<_ColorGamePageState> _colorGamePageKey = GlobalKey<_ColorGamePageState>();
  ColorGame({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ColorAppBar(
        onBackClicked: () {
          _colorGamePageKey.currentState?._endGame();
        },
      ),
      body: ColorGamePage(key: _colorGamePageKey),
    );
  }
}

class ColorGamePage extends StatefulWidget {
  const ColorGamePage({super.key});

  @override
  _ColorGamePageState createState() => _ColorGamePageState();
}

class _ColorGamePageState extends State<ColorGamePage> {
  final List<Color> _colorArray = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
    Colors.orange,
    Colors.purple,
    Colors.teal,
    Colors.pink,
    Colors.amber,
    Colors.deepPurple,
  ];

  bool _timerInitialized = false;
  late Timer _timer;
  int _level = 1;
  final List<Color> _sequence = [];
  final List<Color> _userSequence = [];
  int _countdown = 5;
  bool _showSequence = false;
  bool _gameStarted = false;
  bool _playing = false;
  bool _tryAgain = false;

  void _endGame() {
    setState(() {
      _gameStarted = false;
      _level = 1;
      _countdown = 5;
      _showSequence = false;
      _playing = false;
      _tryAgain = false;
      if (_timerInitialized) {
        _timer.cancel();
      }
    });
  }

  void _startGame() {
    setState(() {
      _sequence.clear();
      _userSequence.clear();
      _gameStarted = true;
      _tryAgain = false;
      _generateSequence();
      _startTimer();
    });
    _timerInitialized = true;
  }

  void _generateSequence() {
    final random = Random();
    for (int i = 0; i < _level; i++) {
      final colorIndex = random.nextInt(_colorArray.length);
      _sequence.add(_colorArray[colorIndex]);
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _countdown--;
        if (_countdown == 0) {
          _timer.cancel();
          _showSequence = true;
          _gameStarted = false;
        }
      });
    });
  }

  void _checkSequence() {
    for (int i = 0; i < _sequence.length; i++) {
      if (_sequence[i] != _userSequence[i]) {
        setState(() {
          _playing = false;
          _tryAgain = true;
        });
        return;
      }
    }
    setState(() {
      _level++;
      _countdown = 5;
      _startGame();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Color Game',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            if (_tryAgain)
              const Text(
                "Try Again!",
                style: TextStyle(color: Colors.red),
              ),
            const SizedBox(height: 20),
            if (!_playing)
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _level = 1;
                    _countdown = 5;
                    _gameStarted = false;
                    _playing = true;
                  });
                  _startGame();
                },
                child: const Text('Play Game'),
              ),
            if (_gameStarted)
              Column(
                children: <Widget>[
                  Text('Level: $_level', style: const TextStyle(fontSize: 20)),
                  const SizedBox(height: 10),
                  Text('$_countdown', style: const TextStyle(fontSize: 40)),
                  const SizedBox(height: 10),
                  const Text('Time to memorize:', style: TextStyle(fontSize: 20)),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 10,
                    alignment: WrapAlignment.center,
                    children: _sequence
                        .map((color) => Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                color: color,
                              ),
                            ))
                        .toList(),
                  ),
                ],
              ),
            if (_showSequence)
              Column(
                children: <Widget>[
                  const Text('Guess The Sequence:', style: TextStyle(fontSize: 20)),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 2,
                    runSpacing: 2,
                    alignment: WrapAlignment.center,
                    children: _colorArray
                        .map((color) => GestureDetector(
                              onTap: () {
                                setState(() {
                                  _userSequence.add(color);
                                  if (_userSequence.length == _sequence.length) {
                                    _showSequence = false;
                                    _checkSequence();
                                  }
                                });
                              },
                              child: Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: color,
                                  border: Border.all(
                                    color: _userSequence.contains(color)
                                        ? Colors.green
                                        : Colors.transparent,
                                    width: 3,
                                  ),
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                ],
              ),
            if (_level > 10)
              const Text(
                "Ganhaste",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green),
              )
          ],
        ),
      ),
    );
  }
}
