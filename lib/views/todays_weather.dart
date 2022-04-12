import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:weather/weather.dart';

import 'package:ttlines2/widgets/weather_card.dart';



class todaysWeatherView extends StatefulWidget {

  final apiRetrievedWeather;
  todaysWeatherView({this.apiRetrievedWeather});
 
  @override
  State<todaysWeatherView> createState() => _todaysWeatherViewState();
}

class _todaysWeatherViewState extends State<todaysWeatherView> {


  int? temperature;
  double? windSpeed;
  double? windDir;
  String? description;
  String? weathericon;
  // change this to be a datetime object:
  num? date;



  @override
  void initState() {
    super.initState();
    print('initialstate called wohhhhoo');
    print(widget.apiRetrievedWeather);
    updateWeather(widget.apiRetrievedWeather); 
  }


 void updateWeather(dynamic weatherToday) {
   num temp = weatherToday['daily'][0]['temp']['day'];
   temperature = temp.toInt();

   num windS = weatherToday['daily'][0]['wind_speed'];
   windSpeed = windS.toDouble();
  
   num windD =  weatherToday['daily'][0]['wind_deg'];
   windDir = windD.toDouble();

   description = weatherToday['daily'][0]['weather'][0]['description'];
   weathericon = weatherToday['daily'][0]['weather'][0]['icon'];
   date = weatherToday['daily'][0]['dt'];
 }

 
@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todays Weather')
      ),
      body: Center(
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(60, 20, 60, 50),
              child: Card(
                child: Padding(
                padding: EdgeInsets.fromLTRB(30, 20, 30, 50),
                  child: Column(
                    children: <Widget>[
                      Text('$date'),
                      Image.network('http://openweathermap.org/img/w/$weathericon.png', scale: 0.5),
                      Text('$temperature degC'),
                      Text('$description'),
                       Divider(),
                      Text('WIND:'),
                      Text ('Speed: $windSpeed Kms'),
                      Text ('Direction: $windDir degrees'),
                    ]
                  )
                )
              )
            )
          ]
        )
      )
    );
  }
}