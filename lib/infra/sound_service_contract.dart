import 'package:just_audio/just_audio.dart';

abstract class SoundServiceContract {
  void playTick();

  bool isPlaying();
}

