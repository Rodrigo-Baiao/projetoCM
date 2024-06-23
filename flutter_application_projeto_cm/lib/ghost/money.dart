// ignore_for_file: library_private_types_in_public_api

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MoneyAnimation extends StatefulWidget {
  final int amount;

  const MoneyAnimation({super.key, required this.amount});

  @override
  _MoneyAnimationState createState() => _MoneyAnimationState();
}

class _MoneyAnimationState extends State<MoneyAnimation> with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<Offset>? _offsetAnimation;
  int _timesFed = 0;
  late SharedPreferences _prefs;
  DateTime? _lastFedTime;

  @override
  void initState() {
    super.initState();
    _initializePrefs();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..forward();
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.0),
      end: const Offset(0.0, -2.0),
    ).animate(CurvedAnimation(
      parent: _controller!,
      curve: Curves.easeOut,
    ));
  }

  Future<void> _initializePrefs() async {
    _prefs = await SharedPreferences.getInstance();
    _timesFed = _prefs.getInt('timesFed') ?? 0;
    int? lastFedTimestamp = _prefs.getInt('lastFedTime');
    _lastFedTime = lastFedTimestamp != null ? DateTime.fromMillisecondsSinceEpoch(lastFedTimestamp) : null;
  }

  Future<void> _updatePrefs() async {
    await _prefs.setInt('timesFed', _timesFed);
    await _prefs.setInt('lastFedTime', DateTime.now().millisecondsSinceEpoch);
  }

  Future<void> _feed() async {
    if (_timesFed < 3) {
      setState(() {
        _timesFed++;
      });
      await _updatePrefs();
      // Adicionar lógica de dar comida ao pet aqui
    } else {
      if (_lastFedTime != null && DateTime.now().difference(_lastFedTime!) > const Duration(minutes: 10)) {
        setState(() {
          _timesFed = 1;
          _lastFedTime = DateTime.now();
        });
        await _updatePrefs();
        // Adicionar lógica de dar comida ao pet aqui
      } else {
        // Lógica para lidar com a restrição de alimentação
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Limite de alimentação atingido'),
              content: const Text('Você só pode alimentar o pet 3 vezes a cada 10 minutos.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation!,
      child: Opacity(
        opacity: 1.0 - _controller!.value,
        child: InkWell(
          onTap: _feed,
          child: Row(
            children: [
              Text(
                '+${widget.amount}',
                style: const TextStyle(
                  fontSize: 24,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 5), // Espaço entre o texto e o ícone da moeda
              Image.asset('assets/coin.png', width: 20, height: 20), // Ícone de moeda
            ],
          ),
        ),
      ),
    );
  }
}
