import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';


 Future<WeatherDataList> getWeatherData() async {
  final String apiUrl = '***REMOVED***data/2.5/onecall?lat=-39.0982&lon=175.8302&exclude=current,minutely,hourly,alerts&units=metric&appid=***REMOVED***';
  var response = await http.get(Uri.parse(apiUrl));

   WeatherDataList ramon = WeatherDataList.fromJson(jsonDecode(response.body));

     if (response.statusCode == 200) {
      
        print(ramon.weatherList[0].weather_main[0].description);
        return ramon;
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
  int dt;
  double wind_speed;
  int wind_deg;
  Temp temp;
  List<WeatherMain> weather_main;
 
  WeatherData({
    required this.dt,
    required this.wind_speed,
    required this.wind_deg,
    required this.temp,
    required this.weather_main,

    });

factory WeatherData.fromJson(Map<String, dynamic> json) {
  var new_list = json['weather'] as List;
  List<WeatherMain> weather_main_list = new_list.map((item) => WeatherMain.fromJson(item)).toList();
  return WeatherData(
        dt : json['dt'] as int,
        wind_speed: json['wind_speed'] as double,
        wind_deg: json['wind_deg'] as int,
        temp: Temp.fromJson(json['temp']),
        weather_main : weather_main_list,
    );
}  
  Map<String, dynamic> toJson() => {
        'dt': dt,
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
  String description;
  String icon;

  WeatherMain({
    required this.id,
    required this.description,
    required this.icon,
  });
  factory WeatherMain.fromJson(Map<String, dynamic> json){
    return WeatherMain(
      id : json['id'] as int,
      description: json ['description'] as String,
      icon : json['icon'] as String,
      );
  }
}

















// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'dart:async';
// import 'package:flutter/material.dart';


//  Future<WeatherDataList> getWeatherData() async {
//   final String apiUrl = '***REMOVED***data/2.5/onecall?lat=-39.0982&lon=175.8302&exclude=current,minutely,hourly,alerts&units=metric&appid=***REMOVED***';
//   var response = await http.get(Uri.parse(apiUrl));

//    WeatherDataList ramon = WeatherDataList.fromJson(jsonDecode(response.body));

//      if (response.statusCode == 200) {
//         // print (ramon.weatherList?[0].sunrise);
//         // print (ramon.weatherList?[3].sunrise);
//         print(ramon.weatherList?[0]);
//         return ramon;
//   } else {
//     print (response.statusCode);
//     throw (Exception('error HERE'));
//   }
// } 



// class WeatherDataList {
//   List<WeatherData>? weatherList;

//   WeatherDataList ({
//     required this.weatherList,
//   });
  
//   factory WeatherDataList.fromJson(Map<String, dynamic> json) {
//       final list = json['daily'] as List<dynamic>?;
//     final weatherAnswer = list != null ? list.map((item) => WeatherData.fromJson(item)).toList() : <WeatherData> [];

//     return WeatherDataList(
//       weatherList: weatherAnswer,
//     );
//     }
//   }
    

// class WeatherData {
//   int dt;
//   int sunrise;
//   int sunset;
 
//   WeatherData({
//     required this.dt,
//     required this.sunrise,
//     required this.sunset,
//     });

// factory WeatherData.fromJson(Map<String, dynamic> json) {
//   return WeatherData(
//         dt : json['dt'] as int,
//         sunrise: json['sunrise'] as int,
//         sunset: json['sunset'] as int,
//     );
// }
  
//   Map<String, dynamic> toJson() => {
//         'dt': dt,
//         'sunrise': sunrise,
//         'sunset': sunset,
//       };
// }