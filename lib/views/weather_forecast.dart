import 'package:flutter/material.dart';
import 'package:ttlines2/services/one_call_weather.dart';
import 'package:ttlines2/widgets/weather_card.dart';



class weatherForecastView extends StatefulWidget {
  const weatherForecastView({ Key? key }) : super(key: key);

  @override
  State<weatherForecastView> createState() => _weatherForecastViewState();
}

class _weatherForecastViewState extends State<weatherForecastView> {

late Future<WeatherData> aloha;
late Future<ForecastData> mahalo;


  @override
  void initState() {
    super.initState();

    mahalo = getWeatherData();
    monday();
  }


  void monday() {
    print (mahalo);
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
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  height: 200.0,
                  child: ListView.builder(
                    itemCount: 8, 
                    scrollDirection: Axis.horizontal, 
                    itemBuilder: (context, index) => WeatherCard()),//weather: forecastData.list.elementAt(index))),
              ),
            ),
            Text('WEATHER FORECAST FOR TONGARIRO'),
            Divider(),
            ElevatedButton(
              onPressed: () {
              },
              child: const Text('one-call Weather api')),
          ]
        )
      )
    );
  }
}


