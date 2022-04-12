import 'package:flutter/material.dart';
import 'package:ttlines2/services/one_call_weather.dart';
import 'package:ttlines2/views/weather.dart';
import 'package:ttlines2/services/original_weather_api.dart';

class WeatherCard extends StatefulWidget {

  // final WeatherData weather;
  // WeatherCard({required this.weather});




  @override
  State<WeatherCard> createState() => _WeatherCardState();
}

class _WeatherCardState extends State<WeatherCard> {
  late Future<ForecastData> nowForecast;
  late Future<WeatherData> nowWeather;

   int? sunrise;

  @override
  void initState() {
    super.initState();
    nowForecast = getWeatherData();
    print (nowForecast);
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder<ForecastData>(
      future: nowForecast,
      builder: (context, snapshot){

        if (snapshot.hasData) {

            return SizedBox(
              height: 200.0,
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    //mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // Text('date'),  //date
                      // Text('description'), //weather description
                      // Text(snapshot.data!.forecastList.toString()),  //date
                      Text('description'), //weather description
                      Image.network('https://openweathermap.org/img/w/01d.png'), //icon
                      Text('Temp'), //todays temp - add thermometer icon
                      Text('Wind dr'), //add wind icon and Units (km/h)
                      Text('wind speed'), //convert to a string (eg; SouthWester/Southerly/Northerly etc)
                    ]
                  )
                ) 
              ) 
            );
        }
        else if (snapshot.hasError){
          throw Exception('error in ya code');
        }
        else {
          return CircularProgressIndicator();
        }  
      }
    );
  }
}