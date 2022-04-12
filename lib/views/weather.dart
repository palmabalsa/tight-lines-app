import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ttlines2/services/original_weather_api.dart';

class WeatherView extends StatefulWidget {
  const WeatherView({ Key? key }) : super(key: key);

  @override
  _WeatherViewState createState() => _WeatherViewState();
}
class _WeatherViewState extends State<WeatherView> {

  late Future<WeatherReport> todaysWeather;

  @override
  void initState() { 
    super.initState();
    todaysWeather = getData();

}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TRIAL')
      ),
      body: Center(
        child: Column(
          children: [
            Text('is this working'),
            FutureBuilder<WeatherReport>(
              future: todaysWeather,
              builder: (context, snapshot) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 200.0,
                      child: ListView.builder(
                        itemCount: 8, 
                        scrollDirection: Axis.horizontal, 
                        itemBuilder: (context, index) {
                          return SizedBox(
                              height: 300.0,
                              width:140.0,
                              child: Card(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      // Text('${snapshot.data!.date}'),
                                     // Text(snapshot.data!.main),
                                      Text(snapshot.data!.description),
                                      Text (snapshot.data!.icon),
                                      Text('WIND'),
                                      Text ('Speed: ${snapshot.data!.speed} Kms'),
                                      Text ('Dir: ${snapshot.data!.deg} C'),
                                    ]
                                  )
                                )
                              )
                          );
                        }
                      )
                    ),
                  );
              }
            )
          ]
        )
      )
    );
  }
}
