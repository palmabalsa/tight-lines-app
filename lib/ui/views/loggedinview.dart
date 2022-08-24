import 'package:flutter/material.dart';

class playtime extends StatefulWidget {
  const playtime({Key? key}) : super(key: key);

  @override
  State<playtime> createState() => _playtimeState();
}

class _playtimeState extends State<playtime> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('just playing'),
    );
  }
}
