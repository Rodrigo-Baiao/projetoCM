// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class FingerprintWidget extends StatefulWidget {
  const FingerprintWidget({super.key});

  @override
  _FingerprintWidgetState createState() => _FingerprintWidgetState();
}

class _FingerprintWidgetState extends State<FingerprintWidget> {
  bool _showFingerprintIcon = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: <Widget>[
            const Icon(Icons.fingerprint),
            const SizedBox(width: 8),
            const Text('Change fingerprint',
                style: TextStyle(fontSize: 14),
            ),
            const SizedBox(width: 20),
            const Spacer(),
            GestureDetector(
              onTap: () {
                setState(() {
                  _showFingerprintIcon = !_showFingerprintIcon;
                });
              },
              child: Icon(_showFingerprintIcon ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up),
            ),
          ],
        ),
        if (_showFingerprintIcon)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 106.0, vertical: 20),
            child: ElevatedButton(
              onPressed: () {

              },
              child: const Text('Add Fingerprint'),
            ),
          ),
      ],
    );
  }
}
