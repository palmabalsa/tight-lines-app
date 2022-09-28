import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:ttlines2/env/env.dart';

Future<WeatherDataList> getWeatherData(String lat, String lon) async {
  final String apiUrl =
      '${Env.weatherUrl}data/2.5/onecall?lat=$lat&lon=$lon&exclude=current,minutely,alerts&units=metric&appid=$Env.weatherKey';
  var response = await http.get(Uri.parse(apiUrl));

  WeatherDataList weatherReport =
      WeatherDataList.fromJson(jsonDecode(response.body));

  if (response.statusCode == 200) {
    return weatherReport;
  } else {
    // print(response.statusCode);
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
  num windSpeed;
  num windDeg;
  Temp temp;
  List<WeatherMain> weatherMain;

  WeatherData({
    required this.date,
    required this.windSpeed,
    required this.windDeg,
    required this.temp,
    required this.weatherMain,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    var newList = json['weather'] as List;
    List<WeatherMain> weatherMainList =
        newList.map((item) => WeatherMain.fromJson(item)).toList();

    return WeatherData(
      date:
          DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000, isUtc: false),
      windSpeed: json['windSpeed'] as num,
      windDeg: json['windDeg'] as num,
      temp: Temp.fromJson(json['temp']),
      weatherMain: weatherMainList,
    );
  }
  Map<String, dynamic> toJson() => {
        'date': date,
        'wind_speed': windSpeed,
        'wind_deg': windDeg,
        'temp': temp,
      };
}

class Temp {
  num dayTemp;
  Temp({
    required this.dayTemp,
  });
  factory Temp.fromJson(Map<String, dynamic> json) {
    return Temp(
      dayTemp: json['day'] as num,
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
  num hourlyWindDeg;
  num hourlyWindSpeed;
  List<HourlyWeatherMain> hourlyWeatherIcon;

  HourlyWeatherData({
    required this.hour,
    required this.hourlyTemp,
    required this.hourlyWindDeg,
    required this.hourlyWindSpeed,
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
      hourlyWindDeg: json['wind_deg'] as num,
      hourlyWindSpeed: json['wind_speed'] as num,
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
