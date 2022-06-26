// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class weatherListTile extends StatelessWidget {
  weatherListTile({
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
      contentPadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
      leading: Text(hour),
      title: Container(
          width: 5,
          child: Row(children: <Widget>[
            Spacer(),
            Image.network(
                'http://openweathermap.org/img/w/$hourlyWeatherIcon.png'),
            // Spacer(),
            Text(
              '$hourlyTemperature °C',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Spacer(flex: 10),
            Text(hourlyWindSpeed,
                style: TextStyle(
                    color: Colors.blueGrey, fontWeight: FontWeight.bold)),
            hourlyWindIcon,
          ])),
    );
  }
}
