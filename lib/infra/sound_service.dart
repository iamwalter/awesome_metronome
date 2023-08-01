
import 'package:awesome_metronome/infra/sound_service_contract.dart';
import 'package:just_audio/just_audio.dart';

class SoundServiceJustAudio implements SoundServiceContract {
  late final players = [
    AudioPlayer(userAgent: '1'),
    AudioPlayer(userAgent: '2'),
    AudioPlayer(userAgent: '3'),
    AudioPlayer(userAgent: '4'),
    AudioPlayer(userAgent: '5'),
    AudioPlayer(userAgent: '6'),
    AudioPlayer(userAgent: '7'),
    AudioPlayer(userAgent: '8'),
    AudioPlayer(userAgent: '9'),
    AudioPlayer(userAgent: '10'),
    AudioPlayer(userAgent: '11'),
    AudioPlayer(userAgent: '12'),
    AudioPlayer(userAgent: '13'),
    AudioPlayer(userAgent: '14'),
    AudioPlayer(userAgent: '15'),
    AudioPlayer(userAgent: '16'),
    AudioPlayer(userAgent: '17'),
    AudioPlayer(userAgent: '18'),
    AudioPlayer(userAgent: '19'),
    AudioPlayer(userAgent: '20'),
  ];

  SoundServiceJustAudio._() {
    for (final player in players) {
      player.setAsset("assets/sounds/tik.mp3");
    }
  }

  static SoundServiceJustAudio? _instance;

  static SoundServiceJustAudio get instance {
    _instance ??= SoundServiceJustAudio._();

    return _instance!;
  }

  @override
  void playTick() {
    final firstNotPlaying =
        players.where((element) => !element.playing).firstOrNull;

    if (firstNotPlaying == null) return;


    playStopSeek(firstNotPlaying);
  }

  Future<void> playStopSeek(AudioPlayer player) async {
    await player.play();
    await player.stop();
    await player.seek(Duration.zero);
  }

  @override
  bool isPlaying() {
    return players.where((element) => element.playing).firstOrNull != null;
  }
}