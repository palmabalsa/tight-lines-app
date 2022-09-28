// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:ttlines2/ui/views/weather_forecast.dart';

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
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          const Spacer(flex: 1),
          const Spacer(flex: 6),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => WeatherForecastView(
                          riverName: riverName,
                          lat: lat,
                          lon: lon,
                        )),
              );
            },
            icon: const Icon(Icons.sunny),
            label: Text("Weather", style: theme.textTheme.bodyText2),
          ),
          const Spacer(),
        ]);
  }
}
