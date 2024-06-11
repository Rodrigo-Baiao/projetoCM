import 'package:audioplayers/audioplayers.dart';

class Sound {
  static final player = AudioPlayer();
  static final click = AudioPlayer();
  static final buy = AudioPlayer();

  static bool soundActive = false;

  static Future<void> playSound() async {
    String audioPath = '/sound/music.mp3';
    soundActive = true;

    await player.play(AssetSource(audioPath), volume: 0.08); 
  }
  

  static Future<void> stopSound() async {
    await player.stop();
    await buy.stop();
    await click.stop();
    soundActive = false; 
  }

  static Future<void> clickSound() async {
    if (soundActive) {
      click.release(); // Liberar o player antes de iniciar a reprodução
      String audioPath = '/sound/click_sound.mp3';
      await click.play(AssetSource(audioPath), volume: 0.1);
    }
  }

  static Future<void> buySound() async {
    if (soundActive) {
      buy.release(); // Liberar o player antes de iniciar a reprodução
      String audioPath = '/sound/buy_sound.mp3';
      await buy.play(AssetSource(audioPath), volume: 0.1);
    }
  }
}
