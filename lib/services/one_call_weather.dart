import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';


 Future<WeatherDataList> getWeatherData() async {
  final String apiUrl = '***REMOVED***data/2.5/onecall?lat=-39.0982&lon=175.8302&exclude=current,minutely,hourly,alerts&units=metric&appid=***REMOVED***';
  var response = await http.get(Uri.parse(apiUrl));

   WeatherDataList ramon = WeatherDataList.fromJson(jsonDecode(response.body));

     if (response.statusCode == 200) {
        print (ramon.weatherList?[0].sunrise);
        print (ramon.weatherList?[3].sunrise);
        return ramon;
  } else {
    print (response.statusCode);
    throw (Exception('error HERE'));
  }
} 

    
//   WeatherDataList dataHere = WeatherDataList.fromJson(jsonDecode(response.body));
  
//   print(dataHere.runtimeType);
//   print(dataHere.weatherList[1].sunrise);

//   return dataHere;

//  }




  
 

class WeatherDataList {
  List<WeatherData>? weatherList;

  WeatherDataList ({
    required this.weatherList,
  });
  
  factory WeatherDataList.fromJson(Map<String, dynamic> json) {
      final recievedData = json['daily'] as List<dynamic>?;
    // List<WeatherData> weatherAnswer = recievedData.map((item) => WeatherData.fromJson(item)).toList();
    final weatherAnswer = recievedData != null ? recievedData.map((item) => WeatherData.fromJson(item)).toList() : <WeatherData> [];

    return WeatherDataList(
      weatherList: weatherAnswer,
    );
    }
  }



    // final recievedData = json['daily'] as List<dynamic>?;
    // final  weatherList = recievedData != null ? recievedData.map((item) => WeatherData.fromJson(item)).toList() : <WeatherData> [];

    // return WeatherDataList(
    //   weatherList: weatherList,
   
    
    
    

class WeatherData {
  int dt;
  int sunrise;
  int sunset;
 
  WeatherData({
    required this.dt,
    required this.sunrise,
    required this.sunset,
    });

factory WeatherData.fromJson(Map<String, dynamic> json) {
  return WeatherData(
        dt : json['dt'] as int,
        sunrise: json['sunrise'] as int,
        sunset: json['sunset'] as int,
    );
}
  
  Map<String, dynamic> toJson() => {
        'dt': dt,
        'sunrise': sunrise,
        'sunset': sunset,
      };
}




























// class ForecastData {
//   List<WeatherData> forecastList;

//   ForecastData({
//     required this.forecastList,
//   });

//   factory ForecastData.fromJson(Map<String, dynamic> json) => ForecastData(
//     forecastList: List<WeatherData>.from(json["forecastList"].map((x) => WeatherData.fromJson(x))));

//   Map<String, dynamic> toJson() => {
//     "forecastList" : List<dynamic>.from(forecastList.map((x) => x.toJson())),
//   };
// }
















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