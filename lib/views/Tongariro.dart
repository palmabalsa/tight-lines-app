import 'package:flutter/material.dart';
//import 'package:ttlines/services/weather.dart';
import 'package:ttlines2/widgets/weather_card.dart';
import 'package:ttlines2/services/one_call_weather.dart';
import 'package:http/http.dart' as http;

class TongariroView extends StatefulWidget {
  
  TongariroView({this.locationWeather});
  final locationWeather;

  @override
  _TongariroViewState createState() => _TongariroViewState();
}

class _TongariroViewState extends State<TongariroView> {

  @override
  void initState() { 
    super.initState();
    getWeatherData();
    print('initstate called');
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tongariro River')
      ),
      body: Center(
        child : ListView(
          children: [
            Text('Tongariro @ Turangi'),
            Image.network('https://gesakentico.blob.core.windows.net/genesis/WebGraphs/Tongariro%20at%20Turangi_7D.gif'),
            Text('Tongariro @ Poutu Intake'),
            Image.network('https://gesakentico.blob.core.windows.net/genesis/WebGraphs/Tongariro%20downstream%20of%20Poutu%20Intake_7D.gif'),
            Text('Tongariro @ Rangipo'),
            Image.network('https://gesakentico.blob.core.windows.net/genesis/WebGraphs/Tongariro%20at%20Rangipo_7D.gif'),
            Text('Tongariro @ Waipakihi'),
            Image.network('https://gesakentico.blob.core.windows.net/genesis/WebGraphs/Tongariro%20at%20Waipakihi_7D.gif'),
          ]
        )
      )   
    );
  }
}