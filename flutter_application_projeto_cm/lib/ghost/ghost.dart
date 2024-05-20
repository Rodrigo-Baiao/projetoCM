import 'package:flutter/material.dart';

class GhostSettings extends ChangeNotifier {
  String ghostImage = '/colors/color_white.png';
  String hatImage = '';

  void updateGhostImage(String imagePath) {
    ghostImage = imagePath;
    notifyListeners();
  }

  void updateHatImage(String imagePath) {
    hatImage = imagePath;
    notifyListeners();
  }
}
