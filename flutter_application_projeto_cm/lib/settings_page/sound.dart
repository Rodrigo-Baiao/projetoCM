// ignore_for_file: non_constant_identifier_names

import 'package:audioplayers/audioplayers.dart';

class Sound {
  static final player = AudioPlayer();
  static final click = AudioPlayer();
  static final buy = AudioPlayer();
  static final lick = AudioPlayer();
  static final clock = AudioPlayer();
  static final level_passed = AudioPlayer();
  static final level_failed = AudioPlayer();

  static bool soundActive = false;

  static Future<void> playSound() async {
    String audioPath = 'sound/music.mp3';
    soundActive = true;

    await player.play(AssetSource(audioPath), volume: 0.08); 
  }
  

  static Future<void> stopSound() async {
    await player.stop();
    await buy.stop();
    await click.stop();
    await lick.stop();
    soundActive = false; 
  }

  static Future<void> clickSound() async {
    if (soundActive) {
      click.release(); 
      String audioPath = 'sound/click_sound.mp3';
      await click.play(AssetSource(audioPath), volume: 0.1);
    }
  }

  static Future<void> lickSound() async {
    if (soundActive) {
      lick.release(); 
      String audioPath = 'sound/lollipop_licking.mp3';
      await lick.play(AssetSource(audioPath), volume: 0.4);
    }
  }

  static Future<void> buySound() async {
    if (soundActive) {
      buy.release(); 
      String audioPath = 'sound/buy_sound.mp3';
      await buy.play(AssetSource(audioPath), volume: 0.1);
    }
  }

  static Future<void> clockSound() async {
    if (soundActive) {
      clock.release(); 
      String audioPath = 'sound/clock.mp3';
      await clock.play(AssetSource(audioPath), volume: 0.4);
    }
  }

  static Future<void> stopClockSound() async {
    await clock.stop();
  }

  static Future<void> playLevelFailed() async{
    String audioPath = 'sound/level_failed.mp3';

    await level_failed.play(AssetSource(audioPath), volume: 0.04);
  }

  static Future<void> playLevelpassed() async{
    String audioPath = 'sound/level_passed.mp3';

    await level_passed.play(AssetSource(audioPath), volume: 0.04);
  }
}
