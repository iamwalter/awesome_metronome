import 'package:awesome_metronome/blocs/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = PlayerCubit.instance;

    return BlocConsumer<PlayerCubit, PlayerState>(
      bloc: cubit,
      buildWhen: (oldState, newState) => newState is Data,
      listener: (context, state) {
        if (state is Data) {
          print("data!");
        }
      },
      builder: (context, state) {
        return switch (state) {
          Data data => Scaffold(
              appBar: AppBar(
                backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                title: const Text('Awesome Metronome'),
              ),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'BPM: ${data.bpm}',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    Slider(
                      value: data.bpm.toDouble(),
                      onChanged: (val) => cubit.setBpm(val),
                      min: 40,
                      max: 200,
                    )
                  ],
                ),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  if (cubit.running) {
                    cubit.stop();
                  } else {
                    cubit.play();
                  }

                },
                tooltip: 'Play/Pause',
                child: Icon(!data.isPlaying ? Icons.play_arrow : Icons.pause),
              ), // This trailing comma makes auto-formatting nicer for build methods.
            ),
          _ => Container(),
        };
      },
    );
  }
}
