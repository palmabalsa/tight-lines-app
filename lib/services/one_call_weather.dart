import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';


 
 Future<WeatherDataList> getWeatherData(String lat, String lon) async {
  final String apiUrl = '***REMOVED***data/2.5/onecall?lat=$lat&lon=$lon&exclude=current,minutely,hourly,alerts&units=metric&appid=***REMOVED***';
  var response = await http.get(Uri.parse(apiUrl));

   WeatherDataList weatherReport = WeatherDataList.fromJson(jsonDecode(response.body));

     if (response.statusCode == 200) {
        return weatherReport;
  } else {
    print (response.statusCode);
    throw (Exception('error HERE'));
  }
} 



class WeatherDataList {
  List<WeatherData> weatherList;

  WeatherDataList ({
    required this.weatherList,
  });
  
  factory WeatherDataList.fromJson(Map<String, dynamic> json) {
    //   final list = json['daily'] as List<dynamic>?;
    // final weatherAnswer = list != null ? list.map((item) => WeatherData.fromJson(item)).toList() : <WeatherData> [];
    final list = json['daily'] as List<dynamic>;
    List<WeatherData> weatherAnswer = list.map((item) => WeatherData.fromJson(item)).toList();


    return WeatherDataList(
      weatherList: weatherAnswer,
    );
  }
}
    

class WeatherData {
  DateTime date;
  double wind_speed;
  int wind_deg;
  Temp temp;
  List<WeatherMain> weather_main;
  // List<Hourly> hourly_weather;
 
  WeatherData({
    required this.date,
    required this.wind_speed,
    required this.wind_deg,
    required this.temp,
    required this.weather_main,
    // required this.hourly_weather,

    });

factory WeatherData.fromJson(Map<String, dynamic> json) {
  var new_list = json['weather'] as List;
  List<WeatherMain> weather_main_list = new_list.map((item) => WeatherMain.fromJson(item)).toList();


  // var hourly_list = json['hourly'] as List;
  // List<Hourly> hourly_weather_list = hourly_list.map((hourly_item) => Hourly.fromJson(hourly_item)).toList();
  
  return WeatherData(
        // dt : json['dt'] as int,
        date : DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000, isUtc: false),
        wind_speed: json['wind_speed'] as double,
        wind_deg: json['wind_deg'] as int,
        temp: Temp.fromJson(json['temp']),
        weather_main : weather_main_list,
        // hourly_weather: hourly_weather_list,
    );
}  
  Map<String, dynamic> toJson() => {
        'date': date,
        'wind_speed': wind_speed,
        'wind_deg': wind_deg,
        'temp': temp, //is this right?
      };
}


class Temp {
  double day_temp;

  Temp ({
    required this.day_temp,
  });
  factory Temp.fromJson(Map<String, dynamic> json){
    return Temp(
      day_temp: json['day'] as double,
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
  factory WeatherMain.fromJson(Map<String, dynamic> json){
    return WeatherMain(
      id : json['id'] as int,
      // main_description : json['main'] as String,
      description: json ['description'] as String,
      icon : json['icon'] as String,
      );
  }
}



// class Hourly {
//   DateTime time;   
//   int temp;      
//   int wind_deg;   
//   int wind_speed; 
//   // int icon; 

//   Hourly({
//     required this.time,
//     required this.temp,
//     required this.wind_deg,
//     required this.wind_speed,
//     // required this.icon,
//   });

//   factory Hourly.fromJson(Map<String, dynamic> json)   {

//     return Hourly(
//       time: json['hourly.dt'], 
//       temp: json['hourly.temp'],
//       wind_deg: json['hourly.wind_deg'],
//       wind_speed: json['hourly.wind_speed'],
//       // icon: icon)
//     );
//   }
// }