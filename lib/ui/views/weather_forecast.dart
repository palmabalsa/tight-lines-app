// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_icons_null_safety/flutter_icons_null_safety.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:ttlines2/services/one_call_weather.dart';
import 'dart:async';
import 'package:ttlines2/ui/widgets/weather_card_display.dart';
import 'package:ttlines2/ui/widgets/weather_48hr_list_tile.dart';
import 'package:intl/intl.dart';

class WeatherForecastView extends StatefulWidget {
  WeatherForecastView({
    Key? key,
    required this.riverName,
    required this.lat,
    required this.lon,
  }) : super(key: key);

  String riverName;
  String lat;
  String lon;

  @override
  State<WeatherForecastView> createState() => _WeatherForecastViewState();
}

class _WeatherForecastViewState extends State<WeatherForecastView> {
  late Future<WeatherDataList> aloha;

  late String lat = widget.lat;
  late String lon = widget.lon;

  Icon getWindArrow(int windDir) {
    if (windDir >= 338 && windDir <= 360 || windDir >= 0 && windDir <= 22) {
      return const Icon(MaterialCommunityIcons.arrow_up,
          color: Colors.blueGrey);
    } else if (windDir >= 23 && windDir <= 67) {
      return const Icon(MaterialCommunityIcons.arrow_top_right,
          color: Colors.blueGrey);
    } else if (windDir >= 68 && windDir <= 112) {
      return const Icon(MaterialCommunityIcons.arrow_right,
          color: Colors.blueGrey);
    } else if (windDir >= 113 && windDir <= 157) {
      return const Icon(MaterialCommunityIcons.arrow_bottom_right,
          color: Colors.blueGrey);
    } else if (windDir >= 158 && windDir <= 202) {
      return const Icon(MaterialCommunityIcons.arrow_down,
          color: Colors.blueGrey);
    } else if (windDir >= 203 && windDir <= 247) {
      return const Icon(MaterialCommunityIcons.arrow_left,
          color: Colors.blueGrey);
    } else if (windDir >= 248 && windDir <= 292) {
      return const Icon(MaterialCommunityIcons.arrow_bottom_left,
          color: Colors.blueGrey);
    } else if (windDir >= 293 && windDir <= 337) {
      return const Icon(MaterialCommunityIcons.arrow_top_left,
          color: Colors.blueGrey);
    } else {
      return const Icon(Icons.abc);
    }
  }

  @override
  void initState() {
    super.initState();
    aloha = getWeatherData(lat, lon);
  }

  String theWeekDay = 'Monday';
  String theMonth = 'Jan';

  void dateFormatter(String weekday, String month) {
    Map<String, String> dayDate = {
      "1": "Monday",
      "2": "Tuesday",
      "3": "Wednesday",
      "4": "Thursday",
      "5": "Friday",
      "6": "Saturday",
      "7": "Sunday"
    };
    Map<String, String> monthDate = {
      "1": "Jan",
      "2": "Feb",
      "3": "March",
      "4": "April",
      "5": "May",
      "6": "June",
      "7": "July",
      "8": "Aug",
      "9": "Sep",
      "10": "Oct",
      "11": "Nov",
      "12": "Dec"
    };
    theWeekDay = '${dayDate[weekday]}';
    theMonth = '${monthDate[month]}';
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.riverName,
            style: theme.textTheme.headline5,
          ),
        ),
        body: Center(
            child: Padding(
          padding: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
          child: FutureBuilder<WeatherDataList>(
              future: aloha,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return SizedBox(
                      height: 5000,
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          // child: SingleChildScrollView(
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data!.weatherList.length,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) {
                                String weathericon = snapshot.data!
                                    .weatherList[index].weatherMain[0].icon
                                    .toString();
                                final currentDate = DateTime.parse(
                                    '${snapshot.data!.weatherList[index].date}');
                                final theDate = currentDate.day.toString();
                                String weekdayNumber =
                                    currentDate.weekday.toString();
                                String monthNumber =
                                    currentDate.month.toString();
                                dateFormatter(weekdayNumber, monthNumber);
                                String temperature = snapshot
                                    .data!.weatherList[index].temp.dayTemp
                                    .toStringAsFixed(0);
                                String windSpeed = snapshot
                                    .data!.weatherList[index].windSpeed
                                    .toStringAsFixed(0);
                                num windDirectionNum =
                                    snapshot.data!.weatherList[index].windDeg;
                                int winddirectionNN = windDirectionNum as int;
                                // String windDirection = snapshot.data!.weatherList[index].wind_deg.toStringAsFixed(0);
                                String description = snapshot
                                    .data!
                                    .weatherList[index]
                                    .weatherMain[0]
                                    .description;
                                var currentWindIcon =
                                    getWindArrow(winddirectionNN);
                                List<HourlyWeatherData> fortyEightHours =
                                    snapshot.data!.hourlyWeatherList;
                                List<String> hoursOnly = [];
                                List<String> day2HourList = [];
                                int first24hourIndex = 0;
                                int second24hourIndex = 0;

                                // ScrollController weatherScrollController =
                                //     ScrollController(
                                //   initialScrollOffset: 16,
                                //   // initialScrollOffset: first24hourIndex + 1,
                                //   keepScrollOffset: true,
                                // );

                                void trythis() {
                                  for (var item in fortyEightHours) {
                                    String individualhour =
                                        DateFormat('H').format(item.hour);
                                    hoursOnly.add(individualhour);
                                    for (String hour in hoursOnly) {
                                      first24hourIndex = hoursOnly.indexWhere(
                                              (hour) => (hour == '00')) +
                                          1;
                                      second24hourIndex = first24hourIndex + 1;
                                    }
                                  }
                                  print(
                                      '$first24hourIndex, $second24hourIndex');
                                }

                                trythis();

                                if (snapshot.hasData) {
                                  return WeatherReportCard(
                                    isInitialCard:
                                        index == 0 || index == 1 ? true : false,
                                    weekday: theWeekDay,
                                    month: theMonth,
                                    date: theDate,
                                    weathericon: weathericon,
                                    temperature: temperature,
                                    windSpeed: windSpeed,
                                    windIcon: currentWindIcon,
                                    description: description,
                                    // hourlyListView: index > 1
                                    hourlyListView: index > 1
                                        ? null
                                        : index == 0 || index == 1
                                            ?
                                            // ? ScrollablePositionedList.builder(
                                            //     initialScrollIndex: index == 1
                                            //         ? first24hourIndex + 1
                                            //         : 0,
                                            //     itemCount: index == 0
                                            //         ? first24hourIndex
                                            //         : 24,
                                            //     itemScrollController: scrollController,
                                            //     scrollDirection: Axis.vertical,
                                            //     physics:
                                            //         const ClampingScrollPhysics(),
                                            //     shrinkWrap: true,
                                            //     itemBuilder:
                                            //         (BuildContext context,
                                            //             int index) {
                                            //       DateTime thehour = DateTime.parse(
                                            //           '${snapshot.data!.hourlyWeatherList[index].hour}');
                                            //       String hour = DateFormat('j')
                                            //           .format(thehour);
                                            //       String hourlyTemperature =
                                            //           snapshot
                                            //               .data!
                                            //               .hourlyWeatherList[
                                            //                   index]
                                            //               .hourlyTemp
                                            //               .toStringAsFixed(0);
                                            //       String hourlyWindDeg =
                                            //           snapshot
                                            //               .data!
                                            //               .hourlyWeatherList[
                                            //                   index]
                                            //               .hourlyWindDeg
                                            //               .toStringAsFixed(0);
                                            //       num hourlyWindDirectionNum =
                                            //           snapshot
                                            //               .data!
                                            //               .hourlyWeatherList[
                                            //                   index]
                                            //               .hourlyWindDeg;
                                            //       int hourlyWindDegAsInt =
                                            //           hourlyWindDirectionNum
                                            //               as int;
                                            //       var hourlyWindIcon =
                                            //           getWindArrow(
                                            //               hourlyWindDegAsInt);
                                            //       String hourlyWindSpeed =
                                            //           snapshot
                                            //               .data!
                                            //               .hourlyWeatherList[
                                            //                   index]
                                            //               .hourlyWindSpeed
                                            //               .toStringAsFixed(0);
                                            //       String hourlyWeatherIcon =
                                            //           snapshot
                                            //               .data!
                                            //               .hourlyWeatherList[
                                            //                   index]
                                            //               .hourlyWeatherIcon[0]
                                            //               .hourlyIcon
                                            //               .toString();

                                            // return WeatherListTile(
                                            //     hour: hour,
                                            //     hourlyTemperature:
                                            //         hourlyTemperature,
                                            //     hourlyWindIcon:
                                            //         hourlyWindIcon,
                                            //     hourlyWindSpeed:
                                            //         hourlyWindSpeed,
                                            //     hourlyWeatherIcon:
                                            //         hourlyWeatherIcon);

                                            ListView.builder(
                                                // controller: index == 0
                                                //     ? null
                                                //     : index == 1
                                                //         ? weatherScrollController
                                                //         : null,
                                                itemCount: first24hourIndex,

                                                // itemCount: index == 0
                                                //     ? first24hourIndex
                                                //     : index == 1
                                                //         ? 12
                                                //         : null,
                                                scrollDirection: Axis.vertical,
                                                physics:
                                                    const ClampingScrollPhysics(),
                                                shrinkWrap: true,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  DateTime thehour = DateTime.parse(
                                                      '${snapshot.data!.hourlyWeatherList[index].hour}');
                                                  String hour = DateFormat('j')
                                                      .format(thehour);
                                                  String hourlyTemperature =
                                                      snapshot
                                                          .data!
                                                          .hourlyWeatherList[
                                                              index]
                                                          .hourlyTemp
                                                          .toStringAsFixed(0);
                                                  String hourlyWindDeg =
                                                      snapshot
                                                          .data!
                                                          .hourlyWeatherList[
                                                              index]
                                                          .hourlyWindDeg
                                                          .toStringAsFixed(0);
                                                  num hourlyWindDirectionNum =
                                                      snapshot
                                                          .data!
                                                          .hourlyWeatherList[
                                                              index]
                                                          .hourlyWindDeg;
                                                  int hourlyWindDegAsInt =
                                                      hourlyWindDirectionNum
                                                          as int;
                                                  var hourlyWindIcon =
                                                      getWindArrow(
                                                          hourlyWindDegAsInt);
                                                  String hourlyWindSpeed =
                                                      snapshot
                                                          .data!
                                                          .hourlyWeatherList[
                                                              index]
                                                          .hourlyWindSpeed
                                                          .toStringAsFixed(0);
                                                  String hourlyWeatherIcon =
                                                      snapshot
                                                          .data!
                                                          .hourlyWeatherList[
                                                              index]
                                                          .hourlyWeatherIcon[0]
                                                          .hourlyIcon
                                                          .toString();

                                                  return WeatherListTile(
                                                      hour: hour,
                                                      hourlyTemperature:
                                                          hourlyTemperature,
                                                      hourlyWindIcon:
                                                          hourlyWindIcon,
                                                      hourlyWindSpeed:
                                                          hourlyWindSpeed,
                                                      hourlyWeatherIcon:
                                                          hourlyWeatherIcon);
                                                },
                                              )
                                            : null,
                                  );
                                } else if (snapshot.hasError) {
                                  throw Exception('theres an error mate');
                                }
                                return const SizedBox(
                                  height: 200.0,
                                  child: Center(
                                      child: CircularProgressIndicator()),
                                );
                              })));
                } else if (snapshot.hasError) {
                  throw Exception('theres an error mate');
                }
                return const SizedBox(
                  height: 200.0,
                  child: Center(child: CircularProgressIndicator()),
                );
              }),
        )));
  }
}
