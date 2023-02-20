import 'dart:async';

import 'package:flutter/material.dart';

import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:todoapponline/components/timer.dart';
import 'package:todoapponline/screens/muscu/add_exercice/add_exercice.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../start_train.dart/start_train.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

class StartTrainScreen extends StatefulWidget {
  const StartTrainScreen({super.key, required this.user, required this.train});

  final ParseUser user;
  final Map<String, dynamic> train;

  @override
  State<StartTrainScreen> createState() => _StartTrainScreenState();
}

enum TtsState { playing, stopped, paused, continued }

class _StartTrainScreenState extends State<StartTrainScreen> {
  List<Map<String, dynamic>>? details = [];
  bool isStart = true;

  List timers = [];
  bool start = false;
  // convertir les timers en int
  // utiliser la fonction toInt() pour convertir les timers en int
  int indexTimer = 0;
  final CountdownController controller = CountdownController(autoStart: true);

  late FlutterTts flutterTts;
  String? language;
  String? engine;
  double volume = 0.6;
  double pitch = 1.1;
  double rate = 0.6;
  bool isCurrentLanguageInstalled = false;

  String? _newVoiceText;
  int? _inputLength;

  TtsState ttsState = TtsState.stopped;

  get isPlaying => ttsState == TtsState.playing;
  get isStopped => ttsState == TtsState.stopped;
  get isPaused => ttsState == TtsState.paused;
  get isContinued => ttsState == TtsState.continued;

  bool get isIOS => !kIsWeb && Platform.isIOS;
  bool get isAndroid => !kIsWeb && Platform.isAndroid;
  bool get isWindows => !kIsWeb && Platform.isWindows;
  bool get isWeb => kIsWeb;

  @override
  initState() {
    super.initState();
    initTts();

    Future currentUser = ParseUser.currentUser();
    List test = widget.train['taches'];
    for (var i = 0; i < test.length; i++) {
      print('----------------- test -----------------');
      print(test[i]['timer']);
      String timer = test[i]['timer'];
      timers.add(int.parse(timer));
    }

    // speak with a text
    _speakWithText('hello world how are you today ?');
  }

  initTts() {
    flutterTts = FlutterTts();

    _setAwaitOptions();

    if (isAndroid) {
      _getDefaultEngine();
      _getDefaultVoice();
    }

    flutterTts.setStartHandler(() {
      setState(() {
        print("Playing");
        ttsState = TtsState.playing;
      });
    });

    if (isAndroid) {
      flutterTts.setInitHandler(() {
        setState(() {
          print("TTS Initialized");
        });
      });
    }

    flutterTts.setCompletionHandler(() {
      setState(() {
        print("Complete");
        ttsState = TtsState.stopped;
      });
    });

    flutterTts.setCancelHandler(() {
      setState(() {
        print("Cancel");
        ttsState = TtsState.stopped;
      });
    });

    flutterTts.setPauseHandler(() {
      setState(() {
        print("Paused");
        ttsState = TtsState.paused;
      });
    });

    flutterTts.setContinueHandler(() {
      setState(() {
        print("Continued");
        ttsState = TtsState.continued;
      });
    });

    flutterTts.setErrorHandler((msg) {
      setState(() {
        print("error: $msg");
        ttsState = TtsState.stopped;
      });
    });
  }

  Future<dynamic> _getLanguages() async => await flutterTts.getLanguages;

  Future<dynamic> _getEngines() async => await flutterTts.getEngines;

  Future _getDefaultEngine() async {
    var engine = await flutterTts.getDefaultEngine;
    if (engine != null) {
      print(engine);
    }
  }

  Future _getDefaultVoice() async {
    var voice = await flutterTts.getDefaultVoice;
    if (voice != null) {
      print(voice);
    }
  }

  Future _speak() async {
    await flutterTts.setVolume(volume);
    await flutterTts.setSpeechRate(rate);
    await flutterTts.setPitch(pitch);

    if (_newVoiceText != null) {
      if (_newVoiceText!.isNotEmpty) {
        await flutterTts.speak(_newVoiceText!);
      }
    }
  }

  Future _setAwaitOptions() async {
    await flutterTts.awaitSpeakCompletion(true);
  }

  Future _stop() async {
    var result = await flutterTts.stop();
    if (result == 1) setState(() => ttsState = TtsState.stopped);
  }

  Future _pause() async {
    var result = await flutterTts.pause();
    if (result == 1) setState(() => ttsState = TtsState.paused);
  }

  // function to speak with a text in parameter
  Future _speakWithText(String text) async {
    await flutterTts.setVolume(volume);
    await flutterTts.setSpeechRate(rate);
    await flutterTts.setPitch(pitch);

    if (text != null) {
      if (text.isNotEmpty) {
        await flutterTts.speak(text);
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    flutterTts.stop();
  }

  Function toInt() {
    return (e) => e['timer'].toInt();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail'),
        // action to alterne between the focus mode and the list mode ==>
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isStart = true;
              });
            },
            icon: const Icon(Icons.pause_circle),
          )
        ],
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(20),
          height: MediaQuery.of(context).size.height * 0.5,
          color: Colors.grey[900],
          child: Column(children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              'Titre : ${widget.train['taches'][indexTimer]['titre']}',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
                'Description : ${widget.train['taches'][indexTimer]['description']}',
                style: const TextStyle(fontSize: 16)),
            Container(
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TimerCustom(
                title: 'test',
                timer: timers[indexTimer],
                controller: controller,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ]),
        ),
      ),
      floatingActionButton: Container(
        width: MediaQuery.of(context).size.width - 40,
        color: Colors.grey[900],
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              child: const Icon(Icons.skip_previous_rounded),
              onPressed: () {
                if (indexTimer > 0) {
                  setState(() {
                    indexTimer--;
                    _speakWithText(
                        widget.train['taches'][indexTimer]['description']);
                  });
                } else {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          icon: const Icon(Icons.warning, size: 50),
                          iconColor: Colors.red,
                          iconPadding: const EdgeInsets.all(10),
                          title: const Text('Vous êtes au début de la liste'),
                          actions: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Ok'),
                            )
                          ],
                        );
                      });
                }
              },
            ),
            !isStart
                ? ElevatedButton(
                    onPressed: () {
                      controller.resume();
                      setState(() {
                        isStart = !isStart;
                      });
                    },
                    child: Icon(Icons.play_arrow),
                  )
                : ElevatedButton(
                    onPressed: () {
                      controller.pause();

                      setState(() {
                        isStart = !isStart;
                      });
                    },
                    child: Icon(Icons.pause),
                  ),
            ElevatedButton(
              child: Icon(Icons.skip_next_rounded),
              onPressed: () {
                if (indexTimer < widget.train['taches'].length - 1) {
                  setState(() {
                    indexTimer++;
                    _speakWithText(
                        widget.train['taches'][indexTimer]['description']);
                  });
                } else {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          icon: const Icon(Icons.warning, size: 50),
                          iconColor: Colors.red,
                          iconPadding: const EdgeInsets.all(10),
                          title: const Text('Vous êtes à la fin de la liste'),
                          actions: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Ok'),
                            )
                          ],
                        );
                      });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
