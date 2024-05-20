// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class SoundNotificationSwitches extends StatefulWidget {
  const SoundNotificationSwitches({super.key});

  @override
  _SoundNotificationSwitchesState createState() => _SoundNotificationSwitchesState();
}

class _SoundNotificationSwitchesState extends State<SoundNotificationSwitches> {
  bool _soundEnabled = true;
  bool _notificationsEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        const Icon(Icons.volume_up),
        const SizedBox(width: 8),
        Expanded(
          child: Align(
            alignment: Alignment.centerLeft,
            child: Switch(
              value: _soundEnabled,
              onChanged: (bool value) {
                setState(() {
                  _soundEnabled = value;
                });
              },
              activeColor:const Color.fromARGB(246, 179, 206, 222),
            ),
          ),
        ),
        const Icon(Icons.notifications),
        const SizedBox(width: 8),
        Expanded(
          child: Align(
            alignment: Alignment.centerLeft,
            child: Switch(
              value: _notificationsEnabled,
              onChanged: (bool value) {
                setState(() {
                  _notificationsEnabled = value;
                });
              },
              activeColor: const Color.fromARGB(246, 179, 206, 222),
            ),
          ),
        ),
      ],
    );
  }
}
