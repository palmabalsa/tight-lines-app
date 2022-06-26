// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
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
            Text(
              riverName,
              style: theme.textTheme.headline4,
            ),
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
                label: SizedBox(
                  width: 60,
                  height: 50,
                  child: Text("Weather Forecast",
                      style: theme.textTheme.bodyText2),
                ))
          ]),
    );
  }
}
