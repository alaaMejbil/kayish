import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

class SoundController {
  static void playSound() {
    final assetsAudioPlayer = AssetsAudioPlayer();
    assetsAudioPlayer.open(Audio("audio/note1.wav"));
  }
}
