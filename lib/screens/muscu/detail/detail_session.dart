import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:todoapponline/screens/muscu/detail/focus_mode.dart';
import 'package:todoapponline/screens/muscu/detail/list_mode.dart';

class DetailMuscuScreen extends StatefulWidget {
  const DetailMuscuScreen({super.key, required this.user, required this.train});

  final ParseUser user;
  final Map<String, dynamic> train;

  @override
  State<DetailMuscuScreen> createState() => _DetailMuscuScreenState();
}

class _DetailMuscuScreenState extends State<DetailMuscuScreen> {
  List<Map<String, dynamic>> details = [];
  bool isListView = true;

  @override
  initState() {
    super.initState();
    Future currentUser = ParseUser.currentUser();
    print(currentUser.toString());

    currentUser.then((value) {
      var query = QueryBuilder<ParseObject>(ParseObject('Training'))
        ..whereEqualTo('objectId', widget.train['objectId']);

      query.query().then((value) {
        setState(() {
          details.insertAll(0, value.results!.map((e) => e.toJson()));
        });
      });

      if (value == null) {
        Navigator.pushReplacementNamed(context, '/login');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Detail'),
          // action to alterne between the focus mode and the list mode ==>
          actions: [
            isListView
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        isListView = false;
                      });
                    },
                    icon: Icon(Icons.grid_view),
                  )
                : IconButton(
                    onPressed: () {
                      setState(() {
                        isListView = true;
                      });
                    },
                    icon: Icon(Icons.list),
                  ),
          ],
        ),
        body: [
          ListModeDetailMuscu(
            user: widget.user,
            train: widget.train,
          ),
          FocusModeDetailMuscu(
            user: widget.user,
            train: widget.train,
          ),
        ][isListView ? 0 : 1],
        bottomNavigationBar: // botom nav bar to start the exercice ==>
            Container(
          height: 50,
          child: BottomAppBar(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onPressed: () async {
                    // start the exercice ==>
                    List timers = [];
                    final taches = widget.train['taches'];
                    print(taches);
                    for (var i = 0; i < taches.length; i++) {
                      timers.insert(
                          i,
                          taches[i]['timer'].runtimeType == int
                              ? taches[i]['timer']
                              : int.parse(taches[i]['timer']));
                    }

                    // boucle for pour lancer les timers

                    for (var j = 0; j < timers.length; j++) {
                      // change border of the current exercice in the listview
                      // to green ==>
                      int time = timers[j] as int;
                      print('****************************************');
                      print(timers[j]);
                      Timer.periodic(Duration(seconds: 1), (timer) {
                        if (time == 0) {
                          timer.cancel();
                          print("Time's up for item $j!");
                        } else {
                          time--;
                          print("Time left for item $j: $time");
                        }
                      });
                      // start a timer with the timer (secondes) in parameter ==>
                      // if the timer is finish ==>
                      // change border of the current exercice in the listview
                      // to red ==>

                    }
                  },
                  icon: Icon(Icons.play_arrow),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.pause),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.stop),
                ),
              ],
            ),
          ),
        ),
        // add exercice button ==>
        floatingActionButton:
            FloatingActionButton(onPressed: () {}, child: Icon(Icons.add)));
  }
}
