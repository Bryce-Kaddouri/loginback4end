import 'dart:async';

import 'package:flutter/material.dart';

import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:todoapponline/components/timer.dart';
import 'package:todoapponline/screens/muscu/add_exercice/add_exercice.dart';

import '../start_train.dart/start_train.dart';

class StartTrainScreen extends StatefulWidget {
  const StartTrainScreen({super.key, required this.user, required this.train});

  final ParseUser user;
  final Map<String, dynamic> train;

  @override
  State<StartTrainScreen> createState() => _StartTrainScreenState();
}

class _StartTrainScreenState extends State<StartTrainScreen> {
  List<Map<String, dynamic>>? details = [];
  bool isStart = true;

  List timers = [];
  bool start = false;
  // convertir les timers en int
  // utiliser la fonction toInt() pour convertir les timers en int
  int indexTimer = 0;
  final CountdownController controller = CountdownController(autoStart: true);

  @override
  initState() {
    super.initState();
    Future currentUser = ParseUser.currentUser();
    List test = widget.train['taches'];
    for (var i = 0; i < test.length; i++) {
      print('----------------- test -----------------');
      print(test[i]['timer']);
      String timer = test[i]['timer'];
      timers.add(int.parse(timer));
    }
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
          color: Colors.grey[900],
          child: Column(children: [
            Text('Titre : ${widget.train['taches'][indexTimer]['titre']}'),
            Text(
                'Description : ${widget.train['taches'][indexTimer]['description']}'),
            TimerCustom(
              title: 'test',
              timer: timers[indexTimer],
              controller: controller,
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  child: const Icon(Icons.skip_previous_rounded),
                  onPressed: () {
                    if (indexTimer > 0) {
                      setState(() {
                        indexTimer--;
                      });
                    } else {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              icon: const Icon(Icons.warning, size: 50),
                              iconColor: Colors.red,
                              iconPadding: const EdgeInsets.all(10),
                              title:
                                  const Text('Vous êtes au début de la liste'),
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
                      });
                    } else {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              icon: const Icon(Icons.warning, size: 50),
                              iconColor: Colors.red,
                              iconPadding: const EdgeInsets.all(10),
                              title:
                                  const Text('Vous êtes à la fin de la liste'),
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
          ]),
        ),
      ),
    );
  }
}
