import 'dart:async';

import 'package:awesome_metronome/infra/sound_service_contract.dart';
import 'package:just_audio/just_audio.dart';

class SoundServiceJustAudio implements SoundServiceContract {
  static SoundServiceJustAudio? _instance;

  static SoundServiceJustAudio get instance {
    _instance ??= SoundServiceJustAudio._();

    return _instance!;
  }

  final players = List<AudioPlayer>.generate(
    3 * 4,
    (i) => AudioPlayer(userAgent: "audioplayer - $i"),
  );

  int audioPlayerIndex = 0;

  SoundServiceJustAudio._() {
    for (int i = 0; i < players.length; i++) {
      final player = players[i];

      if (i % 4 == 0) {
        player.setVolume(3.6);
        player.setPitch(0.4);
      }

      player.setAsset("assets/sounds/tik.mp3");
    }
  }

  Future<void> playStopSeek(AudioPlayer player) async {
    if (player.playing) {
      print("Need more players, $player .");

      return;
    }

    await player.play();
    await player.stop();
    await player.seek(Duration.zero);
  }

  @override
  void playTick() async {
    final audioPlayer = players[audioPlayerIndex];

    unawaited(playStopSeek(audioPlayer));

    audioPlayerIndex = (audioPlayerIndex + 1) % players.length;
  }

}
