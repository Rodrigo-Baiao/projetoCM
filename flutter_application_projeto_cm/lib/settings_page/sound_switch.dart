// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_application_projeto_cm/settings_page/sound.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SoundSwitch extends StatefulWidget {
  const SoundSwitch({super.key});

  @override
  _SoundSwitchState createState() => _SoundSwitchState();
}

class _SoundSwitchState extends State<SoundSwitch> {
  late bool _soundEnabled = false;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _soundEnabled = prefs.getBool('soundEnabled') ?? false;
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
      ],
    );
  }
}
