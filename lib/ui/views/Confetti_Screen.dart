// ignore_for_file: must_be_immutable, prefer_const_constructors
// import 'dart:math';
// // import 'package:confetti/confetti.dart';
// import 'package:flutter/material.dart';
// // import 'package:ttlines2/ui/widgets/animated_trout.dart';
// import 'package:lottie/lottie.dart';

// class ConfettiPlayer extends StatefulWidget {
//   ConfettiPlayer({
//     Key? key,
//     // this.fishSpecies,
//   }) : super(key: key);

//   // String? fishSpecies;

//   @override
//   State<ConfettiPlayer> createState() => _ConfettiPlayerState();
// }

// class _ConfettiPlayerState extends State<ConfettiPlayer>
//     with TickerProviderStateMixin {
//   late final AnimationController _controller;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _controller = AnimationController(vsync: this);
//   }

//   @override
//   void dispose() {
//     // TODO: implement dispose
//     _controller.dispose();
//     super.dispose();
//   }

//   // late ConfettiController _confettiController;

//   // @override
//   // void initState() {
//   //   super.initState();
//   //   _confettiController =
//   //       ConfettiController(duration: const Duration(seconds: 3));
//   //   _confettiController.play();
//   // }

//   // @override
//   // void dispose() {
//   //   _confettiController.dispose();
//   //   super.dispose();
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         // backgroundColor: Colors.teal.shade100,
//         backgroundColor: Colors.white,
//         body: GestureDetector(
//             onTap: () {
//               Navigator.pushReplacementNamed(context, '/fishinglog');
//             },
//             child: Center(
//                 child: Column(
//               children: [
//                 SizedBox(height: 100, width: 200),
//                 SizedBox(
//                     height: 50,
//                     width: 200,
//                     child: Text('Nice Fish!',
//                         style: TextStyle(
//                             color: Colors.black,
//                             fontSize: 25,
//                             fontWeight: FontWeight.bold))),
//                 // Load a Lottie file from your assets
//                 // Lottie.asset('assets/images/jumping_fish_animation.json',
//                 Transform(
//                     alignment: FractionalOffset.center,
//                     transform: Matrix4(
//                       1,
//                       0,
//                       0,
//                       0,
//                       0,
//                       1,
//                       0,
//                       0,
//                       0,
//                       0,
//                       1,
//                       0,
//                       0,
//                       0,
//                       0,
//                       1,
//                     )..rotateY(180),
//                     child: Transform.rotate(
//                         angle: pi / 1,
//                         child: Lottie.asset('assets/images/7458-fish.json',
//                             height: 500,
//                             width: 300,
//                             // fit: BoxFit.fill,
//                             controller: _controller, onLoaded: (composition) {
//                           _controller
//                             ..duration = composition.duration
//                             // ..reverse();
//                             ..forward();
//                         })))
//                 // )
//               ],
//             )
//                 // child: AnimatedTrout()),

//                 // return Scaffold(
//                 //     backgroundColor: Colors.teal.shade100,
//                 //     body: GestureDetector(
//                 //         onTap: () {
//                 //           Navigator.pushReplacementNamed(context, '/fishinglog');
//                 //         },

//                 //         // SafeArea(
//                 //         child: Stack(children: <Widget>[
//                 //           Align(
//                 //             alignment: Alignment.topCenter,
//                 //             //   // alignment: Alignment.center,
//                 //             child: ConfettiWidget(
//                 //               confettiController: _confettiController,
//                 //               numberOfParticles: 3,
//                 //               shouldLoop: false,
//                 //               emissionFrequency: 0.1,
//                 //               colors: [
//                 //                 // Colors.greenAccent.shade700,
//                 //                 // Colors.blueAccent,
//                 //                 // Colors.orangeAccent,
//                 //                 // Colors.yellowAccent,
//                 //                 // Colors.redAccent,
//                 //                 Colors.purpleAccent,
//                 //               ],
//                 //               //     // blastDirectionality: BlastDirectionality.explosive,
//                 //               blastDirection: -pi / 2,
//                 //               maxBlastForce: 3,
//                 //               minBlastForce: 2,
//                 //               gravity: 0.2,
//                 //             ),
//                 //           ),
//                 // Align(
//                 //     alignment: Alignment.center,
//                 //     child: Column(
//                 //       children: <Widget>[
//                 //         SizedBox(height: 50),
//                 //         SizedBox(
//                 //             height: 50,
//                 //             width: 200,
//                 //             child: Text('Nice Fish!',
//                 //                 style: TextStyle(
//                 //                     color: Colors.black,
//                 //                     fontSize: 25,
//                 //                     fontWeight: FontWeight.bold))),
//                 //         SizedBox(
//                 //             width: 250,
//                 //             height: 400,
//                 //             child: Image.asset(
//                 //               'assets/images/jumping_trout.png',
//                 //               color: Color.fromARGB(255, 11, 4, 10),
//                 //             ))
//                 //       ],
//                 //     ))
//                 // ]
//                 )));
//     // Align(
//     //     alignment: Alignment(0.4, -0.5),
//     //     child: SizedBox(
//     //         width: 200,
//     //         child: Text('Nice Fish!',
//     //             style: TextStyle(
//     //                 color: Colors.black,
//     //                 fontSize: 25,
//     //                 fontWeight: FontWeight.bold)))),
//     // ));
//   }
// }
