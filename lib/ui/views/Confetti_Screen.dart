// // ignore_for_file: must_be_immutable

// import 'dart:math';
// import 'package:confetti/confetti.dart';
// import 'package:flutter/material.dart';

// class ConfettiPlayer extends StatefulWidget {
//   ConfettiPlayer({
//     Key? key,
//     required this.confettiPlaying,
//   }) : super(key: key);

//   bool confettiPlaying;

//   @override
//   State<ConfettiPlayer> createState() => _ConfettiPlayerState();
// }

// class _ConfettiPlayerState extends State<ConfettiPlayer> {
//   bool ConfettiIsPlaying = false;
//   final confettiControl = ConfettiController();

//   @override
//   void initState() {
//     super.initState();
//     confettiControl.play();
//   }

//   @override
//   void dispose() {
//     confettiControl.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) =>

//       Stack(alignment: Alignment.topCenter, children: [
//         Scaffold(
//             backgroundColor: Colors.black,
//             body: Center(
//                 child: ListView(children: [
//               ConfettiWidget(
//                 confettiController: confettiControl,
//                 numberOfParticles: 20,
//                 shouldLoop: false,
//                 emissionFrequency: 0.00,
//                 blastDirection: -pi / 2,
//                 minBlastForce: 5,
//                 gravity: 0.2,
//               ),
//               confettiControl.play();
//               Padding(
//                   padding: EdgeInsets.all(100),
//                   child: SizedBox(
//                       height: 50, width: 100, child: Text('Nice Catch!'))),
//               GestureDetector(
//                 onTap: () {
//                   // confettiControl.stop();
//                   Navigator.pushReplacementNamed(context, '/fishinglog');
//                 },
//               )
//             ])))
//       ]);
// }
