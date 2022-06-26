import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';

Future<WeatherDataList> getWeatherData(String lat, String lon) async {
  String myApiKey = '***REMOVED***';
  final String apiUrl =
      '***REMOVED***data/2.5/onecall?lat=$lat&lon=$lon&exclude=current,minutely,alerts&units=metric&appid=$myApiKey';
  var response = await http.get(Uri.parse(apiUrl));

  WeatherDataList weatherReport =
      WeatherDataList.fromJson(jsonDecode(response.body));

  if (response.statusCode == 200) {
    return weatherReport;
  } else {
    print(response.statusCode);
    throw (Exception('error HERE'));
  }
}

class WeatherDataList {
  List<WeatherData> weatherList;
  List<HourlyWeatherData> hourlyWeatherList;

  WeatherDataList({
    required this.weatherList,
    required this.hourlyWeatherList,
  });
  factory WeatherDataList.fromJson(Map<String, dynamic> json) {
    //   final list = json['daily'] as List<dynamic>?;
    // final weatherAnswer = list != null ? list.map((item) => WeatherData.fromJson(item)).toList() : <WeatherData> [];
    final dailyList = json['daily'] as List<dynamic>;
    List<WeatherData> weatherAnswer =
        dailyList.map((item) => WeatherData.fromJson(item)).toList();

    final hourlyList = json['hourly'] as List<dynamic>;
    List<HourlyWeatherData> hourlyWeatherAnswer =
        hourlyList.map((data) => HourlyWeatherData.fromJson(data)).toList();

    return WeatherDataList(
      weatherList: weatherAnswer,
      hourlyWeatherList: hourlyWeatherAnswer,
    );
  }
}

class WeatherData {
  DateTime date;
  num wind_speed;
  num wind_deg;
  Temp temp;
  List<WeatherMain> weather_main;

  WeatherData({
    required this.date,
    required this.wind_speed,
    required this.wind_deg,
    required this.temp,
    required this.weather_main,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    var new_list = json['weather'] as List;
    List<WeatherMain> weather_main_list =
        new_list.map((item) => WeatherMain.fromJson(item)).toList();

    return WeatherData(
      date:
          DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000, isUtc: false),
      wind_speed: json['wind_speed'] as num,
      wind_deg: json['wind_deg'] as num,
      temp: Temp.fromJson(json['temp']),
      weather_main: weather_main_list,
    );
  }
  Map<String, dynamic> toJson() => {
        'date': date,
        'wind_speed': wind_speed,
        'wind_deg': wind_deg,
        'temp': temp,
      };
}

class Temp {
  num day_temp;
  Temp({
    required this.day_temp,
  });
  factory Temp.fromJson(Map<String, dynamic> json) {
    return Temp(
      day_temp: json['day'] as num,
    );
  }
}

class WeatherMain {
  int id;
  // String main_description;
  String description;
  String icon;

  WeatherMain({
    required this.id,
    // required this.main_description,
    required this.description,
    required this.icon,
  });
  factory WeatherMain.fromJson(Map<String, dynamic> json) {
    return WeatherMain(
      id: json['id'] as int,
      // main_description : json['main'] as String,
      description: json['description'] as String,
      icon: json['icon'] as String,
    );
  }
}

class HourlyWeatherData {
  DateTime hour;
  num hourlyTemp;
  num hourlyWind_deg;
  num hourlyWind_speed;
  List<HourlyWeatherMain> hourlyWeatherIcon;

  HourlyWeatherData({
    required this.hour,
    required this.hourlyTemp,
    required this.hourlyWind_deg,
    required this.hourlyWind_speed,
    required this.hourlyWeatherIcon,
  });

  factory HourlyWeatherData.fromJson(Map<String, dynamic> json) {
    var rawHourlyIconList = json['weather'] as List;
    List<HourlyWeatherMain> hourlyIconList = rawHourlyIconList
        .map((item) => HourlyWeatherMain.fromJson(item))
        .toList();

    return HourlyWeatherData(
      // hour: json['dt'],
      hour:
          DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000, isUtc: false),
      hourlyTemp: json['temp'] as num,
      hourlyWind_deg: json['wind_deg'] as num,
      hourlyWind_speed: json['wind_speed'] as num,
      hourlyWeatherIcon: hourlyIconList,
    );
  }
}

class HourlyWeatherMain {
  String hourlyIcon;

  HourlyWeatherMain({required this.hourlyIcon});

  factory HourlyWeatherMain.fromJson(Map<String, dynamic> json) {
    return HourlyWeatherMain(
      hourlyIcon: json['icon'] as String,
    );
  }
}
