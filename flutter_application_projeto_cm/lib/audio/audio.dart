import 'package:audioplayers/audioplayers.dart';

class PlayerAudio {
  static final player = AudioPlayer();


  static Future<void> playSound() async { 
    String audioPath = "/audio/background_music.mp3";
    await player.play(AssetSource(audioPath));
  }
}