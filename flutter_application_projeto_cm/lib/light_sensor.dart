import 'dart:async';
import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:light/light.dart';

class LightSensorr with ChangeNotifier {
  int _luxValue = 0;
  StreamSubscription<int>? _subscription;
  String _windowImage = 'assets/windows/window1.png';

  LightSensorProvider() {
    if (Platform.isAndroid || Platform.isIOS) {
      _initLightSensor();
    } else {
      print('Light sensor not supported on this platform');
    }
  }

  void _initLightSensor() {
    try {
      _subscription = Light().lightSensorStream.listen(
        (int lux) {
          _luxValue = lux;
          _updateWindowImage();
          notifyListeners();
        },
        onError: (e) {
          print("Error: $e");
        },
        cancelOnError: true,
      );
    } catch (e) {
      print("Error initializing light sensor: $e");
    }
  }

  void _updateWindowImage() {
    if (_luxValue > 10) {
      _windowImage = 'assets/windows/window1.png';
    } else {
      _windowImage = 'assets/windows/window2.png';
    }
  }

  int get luxValue => _luxValue;
  String get windowImage => _windowImage;

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
