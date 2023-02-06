import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';

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
    List taches = widget.train['taches'];
    print('************************************');
    List timer = taches.map((e) => e['timer']).toList();

    for (var i = 0; i < timer.length; i++) {
      print(timer[i]);
    }

    int indexExo = 0;
    return Container(
      child: CircularCountDownTimer(
        duration: timer[indexExo],
        initialDuration: 0,
        controller: CountDownController(),
        width: MediaQuery.of(context).size.width / 2,
        height: MediaQuery.of(context).size.height / 2,
        ringColor: Colors.grey[300]!,
        ringGradient: null,
        fillColor: Colors.purpleAccent[100]!,
        fillGradient: null,
        backgroundColor: Colors.purple[500],
        backgroundGradient: null,
        strokeWidth: 20.0,
        strokeCap: StrokeCap.round,
        textStyle: TextStyle(
            fontSize: 33.0, color: Colors.white, fontWeight: FontWeight.bold),
        textFormat: CountdownTextFormat.MM_SS,
        isReverse: true,
        isReverseAnimation: false,
        isTimerTextShown: true,
        autoStart: true,
        // endTime: DateTime.now().millisecondsSinceEpoch + 10000,
        onStart: () {
          debugPrint('Countdown Started');
        },
        onComplete: () {
          debugPrint('Countdown Ended');
          indexExo++;
        },
        onChange: (String timeStamp) {
          debugPrint('Countdown Changed $timeStamp');
        },
        timeFormatterFunction: (defaultFormatterFunction, duration) {
          if (duration.inSeconds == 0) {
            return "Start";
          } else {
            return Function.apply(defaultFormatterFunction, [duration]);
          }
        },
      ),
    );
  }
}
