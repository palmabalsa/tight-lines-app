// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_icons_null_safety/flutter_icons_null_safety.dart';
import 'package:ttlines2/ui/views/WeatherForecast.dart';

class RiverTitle extends StatelessWidget {
  RiverTitle({
    Key? key,
    required this.riverName,
    required this.lat,
    required this.lon,
  }) : super(key: key);

  String riverName;
  String lat;
  String lon;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    final ButtonStyle style =
        TextButton.styleFrom(primary: Theme.of(context).colorScheme.onPrimary);
    ElevatedButton.styleFrom(primary: Colors.amber);

    return Container(
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Spacer(flex: 1),
            Spacer(flex: 6),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  primary: Colors.amber.shade200,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(99))),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => weatherForecastView(
                            riverName: riverName,
                            lat: lat,
                            lon: lon,
                          )),
                );
              },
              icon: Icon(Icons.sunny),
              label: Text("Weather", style: theme.textTheme.bodyText2),
            ),
            Spacer(),
          ]),
    );
  }
}
