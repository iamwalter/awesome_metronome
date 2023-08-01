import 'dart:async';
import 'dart:ui';

import 'package:awesome_metronome/infra/sound_service_contract.dart';

class MetronomeController {
  SoundServiceContract soundService;
  VoidCallback? onTick;

  bool get running => _isRunning;

  int get bpm => _bpm;

  set bpm(int bpm) {
    _bpm = bpm;

    _setMillisecondsPerBeat(_bpm);
  }

  MetronomeController({
    required this.soundService,
    required this.onTick,
    required int bpm,
  }) : _bpm = bpm {
    _setMillisecondsPerBeat(_bpm);
  }

  int _bpm;
  bool _isRunning = false;
  late int _milliSecondsPerBeat;

  void _setMillisecondsPerBeat(int bpm) {
    _milliSecondsPerBeat = (60000 / bpm).round();
  }

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

  void _startMetronome() async {
    if (_isRunning) {
      // Play the tick sound using the SoundServiceContract.
      soundService.playTick();

      // Notify the onTick callback, if provided.
      onTick?.call();

      // Schedule the next tick.
      await Future.delayed(
        Duration(milliseconds: _milliSecondsPerBeat),
        _startMetronome,
      );
    }
  }
}
