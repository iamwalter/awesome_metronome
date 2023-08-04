import 'package:awesome_metronome/blocs/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final backgroundColors = [
    Colors.orange,
    Colors.blue,
    Colors.amber,
    Colors.teal,
    Colors.red,
    Colors.green,
    Colors.purple,
  ];

  var currentBgColorIndex = 0;

  @override
  Widget build(BuildContext context) {
    final cubit = PlayerCubit.instance;

    return BlocConsumer<PlayerCubit, PlayerState>(
      bloc: cubit,
      buildWhen: (oldState, newState) => newState is Data,
      listener: (context, state) {
        if (state is OnTickEvent) {
          setState(() {
            currentBgColorIndex =
                (currentBgColorIndex + 1) % backgroundColors.length;
          });
        }
      },
      builder: (context, state) {
        return switch (state) {
          Data data => Scaffold(
              appBar: AppBar(
                backgroundColor: backgroundColors[currentBgColorIndex],
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
                      max: 500,
                    )
                  ],
                ),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  if (data.isPlaying) {
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
