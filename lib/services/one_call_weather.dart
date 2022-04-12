// API CALL: ***REMOVED***data/2.5/onecall?lat={lat}&lon={lon}&exclude={part}&appid={API key}
// API CALL: ***REMOVED***data/2.5/onecall?lat=-39.0982&lon=175.8302&exclude=current,minutely,hourly,alerts&units=metric&appid=***REMOVED***
// add a way where you can enter different lat/lon for the different rivers

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

// original call to weatherData 
//  Future<WeatherData> getWeatherData() async {
//   final String apiUrl = '***REMOVED***data/2.5/onecall?lat=-39.0982&lon=175.8302&exclude=current,minutely,hourly,alerts&units=metric&appid=***REMOVED***';
//   var weatherResponse = await http.get(Uri.parse(apiUrl));
//   WeatherData currentWeather = WeatherData.fromJson(json.decode(weatherResponse.body));

//   if (weatherResponse.statusCode == 200) {
//         print (currentWeather.sunrise);
//         print (currentWeather.sunset);
//         return currentWeather;
//   } else {
//     print (weatherResponse.statusCode);
//     throw (Exception('error'));
//   }
// } 
// }








 Future<ForecastData> getWeatherData() async {
  final String apiUrl = '***REMOVED***data/2.5/onecall?lat=-39.0982&lon=175.8302&exclude=current,minutely,hourly,alerts&units=metric&appid=***REMOVED***';
  var weatherResponse = await http.get(Uri.parse(apiUrl));
  WeatherData todayzWeather = WeatherData.fromJson(json.decode(weatherResponse.body));
  ForecastData todayzForecast = ForecastData.fromJson(json.decode(weatherResponse.body));
  

  if (weatherResponse.statusCode == 200) {
        print (todayzWeather.sunrise);
        print (todayzWeather.sunset);
        print (todayzForecast);
        return todayzForecast;
  } else {
    print (weatherResponse.statusCode);
    throw (Exception('error'));
  }
}

class WeatherData {

  // late double lat;
  // late double lon;
  // late String key;
  // datetime dt;
  //double dt;
  int sunrise;
  int sunset;
  // num temp;
  // String main;
  // String description;
  // String icon;
  // num windSpeed;
  // num windDir;


//we're expecting (in this constructor)to receive these different values, when we create a new instance of this class
  WeatherData({
    // required this.lat, 
    // required this.lon, 
    // required this.key, 
   // required this.dt,
    required this.sunrise,
    required this.sunset,
    // required this.temp, 
    // required this.main, 
    // required this.description, 
    // required this.icon,
    // required this.windSpeed,
    // required this.windDir,
    });

// factory WeatherData.fromJson(Map<String, dynamic> json) { 
//   return WeatherData(
//    // dt: json["dt"] as double,
//     sunrise : json['daily'][0]['sunrise'],
//     sunset : json['daily'][0]['sunset'],
//   );


factory WeatherData.fromJson(Map<String, dynamic> json) => WeatherData(
  // dt: json["dt"] as double,
        sunrise: json['daily'][0]['sunrise'],
        sunset: json['daily'][0]['sunset'],
    );
  
  Map<String, dynamic> toJson() => {
        'sunrise': sunrise,
        'sunset': sunset,
      };
}


class ForecastData {
  List<WeatherData> forecastList;

  ForecastData({
    required this.forecastList,
  });

  factory ForecastData.fromJson(Map<String, dynamic> json) => ForecastData(
    forecastList: List<WeatherData>.from(json["forecastList"].map((x) => WeatherData.fromJson(x))));

  Map<String, dynamic> toJson() => {
    "forecastList" : List<dynamic>.from(forecastList.map((x) => x.toJson())),
  };
}
















// doglas example
// class ForecastData {
//   List forecastList;

//   ForecastData({
//     required this.forecastList,
//   });

//   factory ForecastData.fromJson(Map<String, dynamic> json){
//     List forecastList = [];

//     for (dynamic element in json['forecastList']) {

//       WeatherData currentForecast = WeatherData(
//         sunrise: element['daily'][0]['sunrise'],
//         sunset : element['daily'][0]['sunset']
//       );
//       forecastList.add(currentForecast);
//     }
//     return ForecastData(
//       forecastList: forecastList,
//     );
//   }
// }