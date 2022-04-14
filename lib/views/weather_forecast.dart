import 'package:flutter/material.dart';
import 'package:ttlines2/services/one_call_weather.dart';
import 'dart:async';


class weatherForecastView extends StatefulWidget {
  const weatherForecastView({ Key? key }) : super(key: key);

  @override
  State<weatherForecastView> createState() => _weatherForecastViewState();
}

class _weatherForecastViewState extends State<weatherForecastView> {
late Future<WeatherDataList> aloha;


  @override
  void initState() {
    super.initState();
    aloha = getWeatherData();
  }
 
  @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Todays Weather'),
        ),
        body: Center(


          // child: Text('hello'),
          child: FutureBuilder<WeatherDataList>(
            future: aloha,
            builder: (context, snapshot) {
              // if (snapshot.connectionState == ConnectionState.done) {
               if (snapshot.hasData){

                 var hello = snapshot.data!.weatherList?[0].sunrise;
                 var bye = snapshot.data!.weatherList?[0].sunset;
                
                print(hello);
                
                return Text('$hello + $bye');
                // return Text('${snapshot.data!.weatherList[1].sunrise}');
              }
              else if (snapshot.hasError){
                throw Exception('theres an error mate');
              }
              else return CircularProgressIndicator();
            }
          )









          // child: FutureBuilder<WeatherDataList>(
          //   future: aloha,
          //   builder: (context, snapshot) {

          //     if (snapshot.hasData) {

          //       dynamic maybe = snapshot.data!.theForecast;
          //       print( maybe);


          //         // return ListView.builder(
          //         //   itemCount: snapshot.data!.length, 
          //         //   scrollDirection: Axis.horizontal, 
          //         //   itemBuilder: (context, index) => ListTile(
          //         //     title: Text(snapshot.data![index].sunrise.toString()),
          //         //     subtitle: Text(snapshot.data![index].sunset.toString()),
          //         //   )
          //         // );       
          //     }
          //     else if (snapshot.hasError){
          //     throw Exception('theres an error');
          //     }
          //     return CircularProgressIndicator();
          //   } 
          // )
        )
      );
    }
}