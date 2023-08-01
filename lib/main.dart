import 'package:awesome_metronome/data/metronome_controller.dart';
import 'package:flutter/material.dart';

import 'infra/sound_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Awesome Metronome'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final controller = MetronomeController(
    soundService: SoundServiceJustAudio.instance,
    bpm: 80,
    onTick: () => print("Tick!"),
  );

  late int bpm;
  late bool isRunning;

  @override
  void initState() {
    super.initState();

    bpm = controller.bpm;
    isRunning = controller.running;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'BPM: $bpm',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Slider(
              value: bpm.toDouble(),
              onChanged: (val) => setState(() {
                bpm = val.toInt();
                controller.bpm = bpm;
              }),
              min: 40,
              max: 200,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            if (!controller.running) {
              controller.start();
            } else {
              controller.stop();
            }

            isRunning = controller.running;
          });
        },
        tooltip: 'Play/Pause',
        child: Icon(!isRunning ? Icons.play_arrow : Icons.pause),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
