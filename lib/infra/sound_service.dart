import 'dart:async';

import 'package:awesome_metronome/infra/sound_service_contract.dart';
import 'package:just_audio/just_audio.dart';

class SoundServiceJustAudio implements SoundServiceContract {
  static SoundServiceJustAudio? _instance;

  static SoundServiceJustAudio get instance {
    _instance ??= SoundServiceJustAudio._();

    return _instance!;
  }

  // final players = <AudioPlayer>[
  //   AudioPlayer(),
  //   AudioPlayer(),
  //   AudioPlayer(),
  //   AudioPlayer(),
  //   AudioPlayer(),
  //   AudioPlayer(),
  //   AudioPlayer(),
  //   AudioPlayer(),
  //   AudioPlayer(),
  //   AudioPlayer(),
  //   AudioPlayer(),
  //   AudioPlayer(),
  //   AudioPlayer(),
  //   AudioPlayer(),
  //   AudioPlayer(),
  //   AudioPlayer(),
  //   AudioPlayer(),
  // ];

  final players = List<AudioPlayer>.generate(50, (i) => AudioPlayer(userAgent: "audioplayer-$i"));

  int nextAudioPlayerIndex = 0;

  SoundServiceJustAudio._() {
    for (final player in players) {
      player.setAsset("assets/sounds/tik.mp3");
    }
  }

  Future<void> playStopSeek(AudioPlayer player) async {
    if (player.playing) {
      print("Need more players!");



      return;
    }

    await player.play();
    await player.stop();
    await player.seek(Duration.zero);
  }

  @override
  void playTick() async {
    final audioPlayer = players[nextAudioPlayerIndex];

    unawaited(playStopSeek(audioPlayer));

    nextAudioPlayerIndex = (nextAudioPlayerIndex + 1) % players.length;
  }

  @override
  bool isPlaying() {
    for (final player in players) {
      if (player.playing) return true;
    }

    return false;
  }
}
