import 'package:flutter/material.dart';
import 'package:flutter_application_projeto_cm/settings_page/sound.dart';

import 'package:shared_preferences/shared_preferences.dart';

class SoundNotificationSwitches extends StatefulWidget {
  const SoundNotificationSwitches({Key? key}) : super(key: key);

  @override
  _SoundNotificationSwitchesState createState() => _SoundNotificationSwitchesState();
}

class _SoundNotificationSwitchesState extends State<SoundNotificationSwitches> {
  late bool _soundEnabled = false;
  bool _notificationsEnabled = false;
  Sound _sound = Sound();

  @override
  void initState() {
    super.initState();
    _loadSoundEnabledState();
  }

  Future<void> _loadSoundEnabledState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _soundEnabled = prefs.getBool('soundEnabled') ?? false;
    });
  }

  Future<void> _saveSoundEnabledState(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('soundEnabled', value);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_soundEnabled) {
      Sound.playSound();
    } else {
      Sound.stopSound();
    }
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
              onChanged: (bool value) {
                setState(() {
                  _soundEnabled = value;
                  if (_soundEnabled) {
                    Sound.playSound();
                  } else {
                    Sound.stopSound();
                  }
                  _saveSoundEnabledState(_soundEnabled);
                });
              },
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
