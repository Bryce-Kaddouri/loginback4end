import 'dart:async';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

import '../../../components/slidecard.dart';

class FocusModeDetailMuscu extends StatefulWidget {
  const FocusModeDetailMuscu(
      {super.key, required this.user, required this.train});

  final ParseUser user;
  final Map<String, dynamic> train;

  @override
  State<FocusModeDetailMuscu> createState() => _FocusModeDetailMuscuState();
}

class _FocusModeDetailMuscuState extends State<FocusModeDetailMuscu> {
  List<Map<String, dynamic>> details = [];

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
    // List taches = widget.train['taches'];
    // print('************************************');
    // List timer = taches.map((e) => e['timer']).toList();
    // print(timer);

    // for (var i = 0; i < timer.length; i++) {
    //   print(timer[i]);
    // }

    int indexExo = 0;
    return Container(
      // child: MyCustomWidget(
      //   user: widget.user,
      //   train: widget.train,
      // ),
      child: Text('test'),
    );
  }
}
