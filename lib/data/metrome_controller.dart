import 'dart:async';
import 'dart:ui';

import 'package:awesome_metronome/infra/sound_service_contract.dart';

class  MetronomeController {
  int bpm;
  bool _isRunning = false;

  bool get isRunning => _isRunning;

  void setBpm(int bpm) {
    this.bpm = bpm;
  }

  VoidCallback? onTick;

  SoundServiceContract soundService;

  MetronomeController({
    required this.soundService,
    required this.onTick,
    this.bpm = 60,
  });

  void start() {
    if (!_isRunning) {
      _isRunning = true;
      _startMetronome();
    }
  }

  void stop() {
    if (_isRunning) {
      _isRunning = false;
    }
  }

  void _startMetronome() {
    if (_isRunning) {
      final int millisecondsPerBeat = (60000 / bpm).round();

      // Play the tick sound using the SoundServiceContract.
      soundService.playTick();

      // Notify the onTick callback, if provided.
      onTick?.call();

      // Schedule the next tick.
      Future.delayed(
        Duration(milliseconds: millisecondsPerBeat),
        _startMetronome,
      );
    }
  }
}
