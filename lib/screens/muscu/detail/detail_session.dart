import 'dart:async';

import 'package:flutter/material.dart';

import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:todoapponline/screens/muscu/add_exercice/add_exercice.dart';

import '../start_train.dart/start_train.dart';

class DetailMuscuScreen extends StatefulWidget {
  const DetailMuscuScreen({super.key, required this.user, required this.train});

  final ParseUser user;
  final Map<String, dynamic> train;

  @override
  State<DetailMuscuScreen> createState() => _DetailMuscuScreenState();
}

class _DetailMuscuScreenState extends State<DetailMuscuScreen> {
  List<Map<String, dynamic>>? details = [];
  bool isStart = true;
  List timers = [];
  bool start = false;
  int indexTimer = 0;

  // function to play the session init the timer for each exercice
  void playsession() {
    List<dynamic> taches = widget.train['taches'];
    print('----------------- taches -----------------');
    print(taches);

    print(taches.length);

    for (var i = 0; i < taches.length; i++) {
      print('----------------- taches -----------------');
      print(widget.train['taches'][i]['timer']);
      timers.add(widget.train['taches'][i]['timer']);
    }

    setState(() {
      start = true;
    });
  }

  @override
  initState() {
    super.initState();
    Future currentUser = ParseUser.currentUser();
    print(currentUser.toString());
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> taches = widget.train['taches'];
    print('----------------- taches -----------------');
    print(taches);

    return Scaffold(
      appBar: AppBar(
        title: Text('Detail'),
        // action to alterne between the focus mode and the list mode ==>
        actions: [
          IconButton(
            onPressed: () {
              if (widget.train['taches'].isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                        'Aucun exercice appuyer sur (+) pour ajouter un exercice !'),
                  ),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StartTrainScreen(
                      user: widget.user,
                      train: widget.train,
                    ),
                  ),
                );
                setState(() {
                  isStart = false;
                });
              }
            },
            icon: const Icon(Icons.play_circle),
          )
        ],
      ),
      body: taches.isEmpty
          ? const Text(
              'Aucun exercice appuyer sur (+) pour ajouter un exercice !')
          : ListView.builder(
              itemCount: taches.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromARGB(255, 226, 225, 225),
                    boxShadow: const [
                      BoxShadow(
                        // color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 1,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: ListTile(
                    tileColor: Colors.blueGrey,
                    title: Text(taches[index]['titre'],
                        style: const TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                            fontSize: 20)),
                    subtitle: Text(taches[index]['description'],
                        style: const TextStyle(color: Colors.black54)),
                    leading: const Icon(Icons.fitness_center,
                        size: 40, color: Colors.black87),
                    // icon 3 points
                    trailing: PopupMenuButton(
                      itemBuilder: (context) => const [
                        PopupMenuItem(
                          value: "edit",
                          child: Text('Modifier'),
                        ),
                        PopupMenuItem(
                          value: "delete",
                          child: Text('Supprimer'),
                        ),
                      ],
                      onSelected: (value) {
                        if (value == "edit") {
                          print('edit');
                        } else if (value == "delete") {
                          print('delete');
                        }
                      },
                    ),
                  ),
                );
              }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // redirect to the add exercice screen ==>

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddExo(
                        user: widget.user,
                        train: widget.train,
                      )));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

// import 'dart:async';
// import 'package:flutter/material.dart';

class TimeCube extends StatefulWidget {
  @override
  _TimeCubeState createState() => _TimeCubeState();
}

class _TimeCubeState extends State<TimeCube> {
  late Timer _timer;
  late DateTime _dateTime;

  @override
  void initState() {
    super.initState();
    _dateTime = DateTime.now();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _dateTime = DateTime.now();
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 200,
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            spreadRadius: 5.0,
            offset: Offset(0.0, 0.0),
          ),
        ],
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              height: 140,
              width: 140,
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10.0,
                    spreadRadius: 5.0,
                    offset: Offset(0.0, 0.0),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Transform.rotate(
              angle: _dateTime.second * 6 * 0.0174533,
              child: Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(60),
                ),
                child: Center(
                  child: Text(
                    "${_dateTime.hour}:${_dateTime.minute}:${_dateTime.second}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
