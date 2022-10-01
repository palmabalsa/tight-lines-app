import 'package:flutter/material.dart';
import 'package:ttlines2/ui/views/weather_forecast.dart';

// ignore: must_be_immutable
class RiverTitle extends StatefulWidget {
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
  State<RiverTitle> createState() => _RiverTitleState();
}

class _RiverTitleState extends State<RiverTitle> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          const Spacer(flex: 1),
          const Spacer(flex: 6),
          ElevatedButton.icon(
            style: theme.elevatedButtonTheme.style,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => WeatherForecastView(
                          riverName: widget.riverName,
                          lat: widget.lat,
                          lon: widget.lon,
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
