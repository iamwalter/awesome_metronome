import 'package:awesome_metronome/data/metronome_controller.dart';
import 'package:awesome_metronome/infra/sound_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

sealed class PlayerState {}

class Data implements PlayerState {
  final int bpm;
  final bool isPlaying;

  Data({
    required this.bpm,
    required this.isPlaying,
  });
}

class OnTickEvent implements PlayerState {}

class PlayerCubit extends Cubit<PlayerState> {
  static PlayerCubit? _instance;

  static PlayerCubit get instance {
    _instance ??= PlayerCubit(Data(
      bpm: 80,
      isPlaying: false,
    ));

    return _instance!;
  }

  late final MetronomeController _controller;

  PlayerCubit(super.initialState) {
    _controller = MetronomeController(
      soundService: SoundServiceJustAudio.instance,
      bpm: 80,
      onTick: () => emit(OnTickEvent()),
    );

    _emitData();
  }

  void setBpm(double bpm) {
    _controller.bpm = bpm.round();

    _emitData();
  }

  void play() {
    _controller.start();

    _emitData();
  }

  void stop() {
    _controller.stop();

    _emitData();
  }

  void _emitData() {
    emit(
      Data(
        bpm: _controller.bpm,
        isPlaying: _controller.running,
      ),
    );
  }
}
