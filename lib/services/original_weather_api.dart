import 'package:ttlines2/views/weather.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';


Future<WeatherReport> getData() async {
  http.Response response = await http.get(Uri.parse('***REMOVED***data/2.5/forecast?lat=-39.0982&lon=175.8302&appid=***REMOVED***'));
  // WeatherReport todaysReport = WeatherReport.fromJson(jsonDecode(response.body));

   if (response.statusCode == 200) {
        print (WeatherReport.fromJson(jsonDecode(response.body)));
        return WeatherReport.fromJson(jsonDecode(response.body));
  } else {
    print (response.statusCode);
    throw (Exception('error'));
  }
}   

class WeatherReport {
  num temp;
 // String main;
  String description;
  String icon;
  num speed;
  num deg;


//we're expecting (in this constructor)to receive these different values, when we create a new instance of this class
  WeatherReport({
    required this.temp, 
    //required this.main, 
    required this.description, 
    required this.icon,
    required this.speed,
    required this.deg});


    factory WeatherReport.fromJson(Map<String, dynamic> json) {
      return WeatherReport(
        // date : json['list'][0]['dt'],
        temp : json['list'][0]['main']['temp'],
        //main : json['list'][0]['weather'][0]['main'],
        description : json['list'][0]['weather'][0]['description'],
        icon : json['list'][0]['weather'][0]['icon'],
        speed : json['list'][0]['wind']['speed'],
        deg : json['list'][0]['wind']['deg'],
      );
    }
  
}