// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class RiverLevelCard extends StatelessWidget {
  RiverLevelCard({
    Key? key,
    required this.theme,
    required this.measuringSiteName,
    required this.measuringSiteUrl,
    required this.graphValue,
  }) : super(key: key);

  final ThemeData theme;
  String measuringSiteName;
  String measuringSiteUrl;
  final String graphValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 210,
      margin: EdgeInsets.fromLTRB(8.0, 5.0, 8.0, 0.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: Colors.white,
        child: Column(children: [
          SizedBox(
            height: 6,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Spacer(),
            Text(measuringSiteName, style: theme.textTheme.bodyText2),
            Spacer(flex: 6),
          ]),
          SizedBox(
            height: 1,
          ),
          Image.network(
              'https://gesakentico.blob.core.windows.net/genesis/WebGraphs/$measuringSiteUrl$graphValue.gif'),
          SizedBox(
            height: 2,
          ),
        ]),
      ),
    );
  }
}
