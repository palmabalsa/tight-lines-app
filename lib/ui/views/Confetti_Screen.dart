// ignore_for_file: must_be_immutable
import 'dart:math';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

class ConfettiPlayer extends StatefulWidget {
  ConfettiPlayer({
    Key? key,
    this.fishSpecies,
  }) : super(key: key);

  String? fishSpecies;

  @override
  State<ConfettiPlayer> createState() => _ConfettiPlayerState();
}

class _ConfettiPlayerState extends State<ConfettiPlayer> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 10));
    _confettiController.play();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.teal.shade100,
        body: Stack(alignment: Alignment.topCenter, children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.pushReplacementNamed(context, '/fishinglog');
            },
          ),
          Align(
            alignment: Alignment.topCenter,
            // alignment: Alignment.center,
            child: ConfettiWidget(
              confettiController: _confettiController,
              numberOfParticles: 10,
              shouldLoop: false,
              emissionFrequency: 0.1,
              colors: [
                Colors.greenAccent.shade700,
                Colors.blueAccent,
                Colors.orangeAccent,
                Colors.yellowAccent,
                Colors.redAccent,
                Colors.purpleAccent,
              ],
              // blastDirectionality: BlastDirectionality.explosive,
              blastDirection: -pi / 2,
              maxBlastForce: 8,
              minBlastForce: 2,
              gravity: 0.2,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: SizedBox(
                height: 400,
                width: 300,
                child: Image.asset('assets/images/jumping_trout.png')),
          ),
          Align(
              alignment: Alignment(-0.01, -0.12),
              child: SizedBox(
                  width: 200,
                  child: TextButton(
                      style: ButtonStyle(
                          fixedSize: MaterialStateProperty.resolveWith(
                              (states) => Size.fromWidth(120)),
                          backgroundColor: MaterialStateProperty.resolveWith(
                              (states) => Colors.black)),
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/fishinglog');
                      },
                      child: widget.fishSpecies != null
                          ? Text('Nice ${widget.fishSpecies}!',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold))
                          : Text('Nice Fish!',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold))))),
        ]));
  }
}
