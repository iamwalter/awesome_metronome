import 'package:awesome_metronome/infra/sound_service_contract.dart';
import 'package:just_audio/just_audio.dart';

class SoundServiceJustAudio implements SoundServiceContract {
  final players = [];

  late var cachedNewPlayer = AudioPlayer();

  SoundServiceJustAudio._() {
    _initNewPlayer();
  }

  static SoundServiceJustAudio? _instance;

  static SoundServiceJustAudio get instance {
    _instance ??= SoundServiceJustAudio._();

    return _instance!;
  }

  AudioPlayer _initNewPlayer() {

    players.add(cachedNewPlayer);

    final player = AudioPlayer();
    player.setAsset("assets/sounds/tik.mp3");
    cachedNewPlayer = player;

    return cachedNewPlayer;
  }

  Future<void> playStopSeek(AudioPlayer player) async {
    await player.play();
    await player.stop();
    await player.seek(Duration.zero);
  }

  @override
  void playTick() async {
    var firstNotPlaying =
        players.where((element) => !element.playing).firstOrNull;

    firstNotPlaying ??= _initNewPlayer();

    playStopSeek(firstNotPlaying);
  }

  @override
  bool isPlaying() {
    return players.firstWhere((audioPlayer) => audioPlayer.playing).firstOrNull !=
        null;
  }
}
