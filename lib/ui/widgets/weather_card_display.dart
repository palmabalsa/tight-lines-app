// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';

class WeatherReportCard extends StatelessWidget {
  WeatherReportCard({
    Key? key,
    required this.isInitialCard,
    this.hourlyListView,
    required this.weekday,
    required this.month,
    required this.date,
    required this.weathericon,
    required this.temperature,
    required this.windSpeed,
    required this.windIcon,
    required this.description,
  }) : super(key: key);
  bool isInitialCard;
  ListView? hourlyListView;
  // ScrollablePositionedList? hourlyListView;

  String weekday;
  String month;
  String date;

  String weathericon;
  String temperature;
  String windSpeed;
  Icon windIcon;
  String description;
  final ScrollController _hourlyWeatherScroller = ScrollController();
  // _hourlyWeatherScroller.pos

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: isInitialCard != true ? 175 : null,
        width: 165.0,
        child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(color: Colors.grey.shade900, width: 1),
            ),
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(60.0, 20.0, 50.0, 0.0),
              child: Column(children: <Widget>[
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          const Divider(),
                          const Divider(),
                          Text(weekday,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                          Text('$date $month'),
                        ],
                      ),
                      const Spacer(),
                      Column(
                        children: <Widget>[
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Text(' $temperature°C',
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                                const SizedBox(width: 4),
                                Column(
                                  children: <Widget>[
                                    Image.network(
                                        'http://openweathermap.org/img/w/$weathericon.png'),
                                  ],
                                ),
                              ]),
                          Text(description,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 15.0,
                              )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text('wind  $windSpeed m/s',
                                  style: const TextStyle(
                                      color: Colors.blueGrey,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold)),
                              windIcon,
                            ],
                          )
                        ],
                      )
                    ]),
                isInitialCard == true
                    ? SingleChildScrollView(
                        controller: _hourlyWeatherScroller,
                        child: Scrollbar(
                            controller: _hourlyWeatherScroller,
                            trackVisibility: true,
                            thumbVisibility: true,
                            child: ExpansionTile(
                                title: const Text(
                                  "Hourly Forecast",
                                  style: TextStyle(color: Colors.teal),
                                ),
                                initiallyExpanded: false,
                                children: <Widget>[
                                  SizedBox(
                                      height: 300,
                                      child: SingleChildScrollView(
                                          child: hourlyListView!))
                                ])))
                    : const SizedBox(),
              ]),
            )));
  }
}
