// import 'package:circular_countdown_timer/circular_countdown_timer.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
// import 'package:slide_countdown/slide_countdown.dart';

// class MyCustomWidget extends StatefulWidget {
//   final ParseUser user;
//   final Map<String, dynamic> train;
//   const MyCustomWidget({super.key, required this.user, required this.train});
//   @override
//   _MyCustomWidgetState createState() => _MyCustomWidgetState();
// }

// class _MyCustomWidgetState extends State<MyCustomWidget>
//     with SingleTickerProviderStateMixin {
//   late AnimationController controller;

//   // function to start the timer
//   void indexForTimer(int index) {
//     print('index for timer: $index');
//     print('timer: ${widget.train['taches'][index]['timer']}');
//     setState(() {
//       controller.duration =
//           Duration(seconds: widget.train['taches'][index]['timer']);
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     controller = AnimationController(
//       vsync: this,
//       duration: Duration(milliseconds: 300),
//     );

//     // List Timer = widget.train['taches'].map((e) => e['timer']).toList();
//     // print('*****************timer *******************');
//     // for (var i = 0; i < Timer.length; i++) {
//     //   print(Timer[i]);
//     // }
//   }

//   @override
//   void dispose() {
//     controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     int index = 0;
//     return Scaffold(
//       body: GestureDetector(
//         onLongPress: () {
//           setState(() {
//             index++;
//             controller.forward();
//             indexForTimer(index);
//             // controller.duration =
//             //     Duration(seconds: widget.train['taches'][indexExo]['timer']);
// // print the timer of the current exercise (indexExo = 0 at the beginning

//             // start timer for the next exercise

//             // controller.reverse();
//             // controller.reset();
//             // controller.stop();
//             // controller.repeat();
//             // controller.repeat(reverse: true);
//             // controller.repeat(min: 0.0, max: 1.0, reverse: true);
//           });
//           indexForTimer(0);
//         },
//         child: CardStack(controller),
//       ),
//     );
//   }
// }

// class CardStack extends StatefulWidget {
//   final AnimationController controller;

//   CardStack(this.controller);

//   @override
//   _CardStackState createState() => _CardStackState();
// }

// class _CardStackState extends State<CardStack> {
//   late Animation<Offset> slideAnimation;
//   late List<SlideCard> cardList;
//   List timers = [20, 10, 20, 20, 20];

//   @override
//   void initState() {
//     super.initState();
//     cardList = List.generate(
//       timers.length,
//       (index) => SlideCard(index),
//     );
//     slideAnimation = Tween<Offset>(
//       begin: Offset.zero,
//       end: const Offset(1, 0.0),
//     ).animate(
//       CurvedAnimation(
//         parent: widget.controller,
//         curve: Curves.ease,
//       ),
//     );
//     widget.controller.addStatusListener((status) {
//       if (status == AnimationStatus.completed) {
//         widget.controller.reset();

//         setState(
//           () => cardList.removeLast(),
//         );
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: cardList.map(
//         (item) {
//           return Transform.translate(
//             offset: Offset(0, -item.index * 5.0),
//             child: SlideTransition(
//               position: getSlideOffset(item.index),
//               child: item,
//             ),
//           );
//         },
//       ).toList(),
//     );
//   }

//   getSlideOffset(
//     int cardIndex,
//   ) {
//     if (cardIndex == cardList.length - 1) {
//       return slideAnimation;
//     } else {
//       return AlwaysStoppedAnimation(Offset.zero);
//     }
//   }
// }

// class SlideCard extends StatelessWidget {
//   int index;

//   SlideCard(this.index);

//   @override
//   Widget build(BuildContext context) {
//     List timers = [20, 10, 20, 20, 20];

//     return Center(
//         child: Container(
//       height: 400,
//       width: 300,
//       decoration: BoxDecoration(
//           color: Color(0xffFF5050),
//           borderRadius: BorderRadius.all(
//             Radius.circular(20),
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.2),
//               blurRadius: 20,
//               offset: Offset(0, 10),
//             )
//           ]),
//       child: SlideCountdown(
//         streamDuration: StreamDuration(
//           Duration(seconds: timers[index]),
//           onDone: () {
//             index++;
//             print('done');
//           },
//           autoPlay: true,
//         ),
//         showZeroValue: true,
//         // duration: Duration(seconds: timers[index]),
//         // seconds: start ? timers[indexTimer] : 0
//       ),
//     ));
//   }
// }
