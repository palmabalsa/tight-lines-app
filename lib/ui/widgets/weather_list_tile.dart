// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class WeatherListTile extends StatelessWidget {
  WeatherListTile({
    Key? key,
    required this.hour,
    required this.hourlyTemperature,
    required this.hourlyWindIcon,
    required this.hourlyWindSpeed,
    required this.hourlyWeatherIcon,
  }) : super(key: key);
  String hour;
  String hourlyTemperature;
  Icon hourlyWindIcon;
  String hourlyWindSpeed;
  String hourlyWeatherIcon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      contentPadding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
      leading: Text(hour),
      title: SizedBox(
          width: 5,
          child: Row(children: <Widget>[
            const Spacer(),
            Image.network(
                'http://openweathermap.org/img/w/$hourlyWeatherIcon.png'),
            Text(
              '$hourlyTemperature °C',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const Spacer(flex: 10),
            Text(hourlyWindSpeed,
                style: const TextStyle(
                    color: Colors.blueGrey, fontWeight: FontWeight.bold)),
            hourlyWindIcon,
          ])),
    );
  }
}
