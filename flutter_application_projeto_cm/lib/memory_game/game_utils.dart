import 'package:flutter/material.dart';

class Game {
  final Color hiddenCard = Colors.red;
  List<Color>? gameColors;
  List<String>? gameImg;
  List<Color> cards = [
    Colors.green,
    Colors.yellow,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.blue
  ];
  final String hiddenCardpath = "/hidden.png";
  List<String> cards_list = [
    "assets/hats/hat3.png", 
    "assets/hats/hat4.png",
    "assets/colors/color_blue.png",
    "assets/colors/color_white.png",
    "assets/colors/color_yellow.png",
    "assets/hats/hat2.png",
    "assets/hats/hat1.png",
    "assets/colors/color_light_pink.png",
    "assets/colors/color_yellow.png",
    "assets/hats/hat1.png",
    "assets/hats/hat2.png",
    "assets/colors/color_light_pink.png",
    "assets/colors/color_white.png",
    "assets/hats/hat3.png",
    "assets/colors/color_blue.png",
    "assets/hats/hat4.png",
  ];
  final int cardCount = 16;
  List<Map<int, String>> matchCheck = [];

  //methods
  void initGame() {
    gameColors = List.generate(cardCount, (index) => hiddenCard);
    gameImg = List.generate(cardCount, (index) => hiddenCardpath);
  }
}