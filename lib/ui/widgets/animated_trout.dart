import 'package:flutter/material.dart';

class AnimatedTrout extends StatefulWidget {
  const AnimatedTrout({Key? key}) : super(key: key);

  @override
  State<AnimatedTrout> createState() => _AnimatedTroutState();
}

class _AnimatedTroutState extends State<AnimatedTrout>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
          width: 300,
          height: 500,
          child: Column(
            children: [
              const Text('Nice Fish!',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 50,
              ),
              RotationTransition(
                turns: Tween(begin: 0.5, end: 2.0).animate(_controller),
                child: IconButton(
                    iconSize: 200,
                    icon: Image.asset('assets/images/jumping_trout.png'),
                    color: const Color.fromARGB(255, 11, 4, 10),
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/fishinglog');
                    }),
              ),
            ],
          )),
    );
  }
}
