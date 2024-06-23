import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ShakeDetectionScreen(),
    );
  }
}

class ShakeDetectionScreen extends StatefulWidget {
  const ShakeDetectionScreen({super.key});

  @override
  _ShakeDetectionScreenState createState() => _ShakeDetectionScreenState();
}

class _ShakeDetectionScreenState extends State<ShakeDetectionScreen> {
  final double _threshold = 15.0; // Set a threshold value for shake detection
  bool _aux = false;
  String displayImage = 'assets/sleeping.png';
  StreamSubscription<AccelerometerEvent>? _streamSubscription;

  @override
  void initState() {
    super.initState();
    _streamSubscription = SensorsPlatform.instance.accelerometerEvents
        .listen(_handleAccelerometerEvent);
  }

  void _handleAccelerometerEvent(AccelerometerEvent event) {
    double acceleration =
        sqrt(event.x * event.x + event.y * event.y + event.z * event.z);
    if (acceleration > _threshold) {
      setState(() {
        displayImage = 'assets/awake.png';
        _aux = true;
      });
      // Handle the shake event here
      print("Device is shaking!");
    }
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shake Detection'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              displayImage,
              width: 200,
              height: 200,
            ),
            const SizedBox(height: 20),
            Text(
              !_aux
                  ? "Spook is asleep,\nshake the device to\n wake him up!"
                  : "Spook is awake!",
              style: const TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
