import 'package:flutter/material.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';

///
/// Home page
///
class TimerCustom extends StatefulWidget {
  ///
  /// AppBar title
  ///
  final String title;
  final int timer;
  final CountdownController controller;

  /// Home page
  TimerCustom({
    Key? key,
    required this.title,
    required this.timer,
    required this.controller,
  }) : super(key: key);

  @override
  _TimerCustomState createState() => _TimerCustomState();
}

///
/// Page state
///
class _TimerCustomState extends State<TimerCustom> {
  // int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    // widget.controller.start();
    // print(widget.timers);
  }

  // // Controller
  // final CountdownController _controller =
  //     new CountdownController(autoStart: true);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceAround,
          //   children: [
          //     ElevatedButton(
          //       onPressed: () {
          //         widget.controller.pause();
          //       },
          //       child: Icon(Icons.pause),
          //     ),
          //     ElevatedButton(
          //       onPressed: () {
          //         widget.controller.resume();
          //       },
          //       child: Icon(Icons.play_arrow),
          //     ),
          //     ElevatedButton(
          //       child: Icon(Icons.skip_next_rounded),
          //       onPressed: () {
          //         widget.controller.start();
          //       },
          //     ),
          //   ],
          // ),
          Countdown(
            controller: widget.controller,
            seconds: widget.timer,
            build: (_, double time) => Text(
              time.toString(),
              style: const TextStyle(
                fontSize: 100,
              ),
            ),
            interval: const Duration(milliseconds: 100),
            onFinished: () {
              // setState(() {
              //   currentIndex++;
              // });
              // print('$currentIndex');
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Timer is done!'),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
