// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_application_projeto_cm/settings_page/sound.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SoundNotificationSwitches extends StatefulWidget {
  const SoundNotificationSwitches({super.key});

  @override
  _SoundNotificationSwitchesState createState() => _SoundNotificationSwitchesState();
}

class _SoundNotificationSwitchesState extends State<SoundNotificationSwitches> {
  late bool _soundEnabled = false;
  bool _notificationsEnabled = false;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _soundEnabled = prefs.getBool('soundEnabled') ?? false;
      _notificationsEnabled = prefs.getBool('notificationsEnabled') ?? false;
    });
    if (_soundEnabled) {
      await Sound.playSound();
    }
  }

  Future<void> _savePreference(String key, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  void _toggleSound(bool value) async {
    setState(() {
      _soundEnabled = value;
    });
    if (_soundEnabled) {
      await Sound.playSound();
    } else {
      await Sound.stopSound();
    }
    await _savePreference('soundEnabled', _soundEnabled);
  }

  void _toggleNotifications(bool value) async {
    setState(() {
      _notificationsEnabled = value;
    });
    await _savePreference('notificationsEnabled', _notificationsEnabled);
  }

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
              onChanged: _toggleSound,
              activeColor: const Color.fromARGB(246, 179, 206, 222),
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
              onChanged: _toggleNotifications,
              activeColor: const Color.fromARGB(246, 179, 206, 222),
            ),
          ),
        ),
      ],
    );
  }
}
