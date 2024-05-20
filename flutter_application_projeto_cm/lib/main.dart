import 'package:flutter/material.dart';
import 'package:flutter_application_projeto_cm/minigamesMenu.dart';
import 'package:flutter_application_projeto_cm/shop.dart';

void main() {

  runApp(MinigamesApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Hello World!'),
        ),
      ),
    );
  }
}
