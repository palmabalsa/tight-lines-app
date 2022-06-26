import 'package:flutter/material.dart';

class RiverAppBar extends StatelessWidget {
  const RiverAppBar({
    Key? key,
    required this.style,
  }) : super(key: key);

  final ButtonStyle style;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.teal,
      height: 35,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Spacer(),
          TextButton(
              style: style,
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/');
              },
              child: const Text('TONGARIRO')),
          TextButton(
              style: style,
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/taurangataupo');
              },
              child: const Text('TT')),
          TextButton(
              style: style,
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/lakeO');
              },
              child: const Text('LAKE O')),
          Spacer(flex: 6),
        ],
      ),
    );
  }
}
