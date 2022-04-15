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
          child: Column(
            children: [
              Text(' Heres todays weather'),
              FutureBuilder<WeatherDataList>(
                future: aloha,
                builder: (context, snapshot) {

                  if (snapshot.hasData) {

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                      child: Container(
                      height: 300.0,
                      child: ListView.builder(
                        itemCount: snapshot.data!.weatherList.length, 
                        scrollDirection: Axis.horizontal, 
                        itemBuilder: (context, index) {
                          return 
                          SizedBox(
                            height: 200.0,
                            width: 150.0,
                            child: Card(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text('${snapshot.data!.weatherList[index].dt}'.toString()),
                                    // Text('${snapshot.data!.weatherList?[index].sunrise}'.toString()),
                                    // Text('${snapshot.data!.weatherList?[index].sunset}'.toString()),
                                    Text('${snapshot.data!.weatherList[index].weather_main[0].id.toString()}'),
                                    Text('${snapshot.data!.weatherList[index].weather_main[0].description.toString()}'),
                                    Text('${snapshot.data!.weatherList[index].weather_main[0].icon.toString()}'),



                                    Text('TEMP'),
                                    Text('${snapshot.data!.weatherList[index].temp.day_temp.toString()} °C'),
                                    Text('WIND'),
                                    Text('${snapshot.data!.weatherList[index].wind_speed.toString()} m/s'),
                                    Text('${snapshot.data!.weatherList[index].wind_deg.toString()} °'),
                                  ] 
                                )
                              )
                            )
                          );
                        }
                        // => ListTile(
                        //   title: Text('${snapshot.data!.weatherList?[index].sunrise}'.toString()),
                        //   subtitle: Text('${snapshot.data!.weatherList?[index].sunset}'.toString()),
                        // )
                      )
                    )
                    
              );
                  }
                  else if (snapshot.hasError){
                  throw Exception('theres an error mate');
                  }
                    return CircularProgressIndicator();
                } 
              )
           ],
          )
        )
      );
    }
}