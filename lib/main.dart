import 'package:flutter/material.dart';
import 'package:ttlines2/services/fish_data_api.dart';
import 'package:ttlines2/views/loading_screen.dart';
import 'package:ttlines2/views/maps.dart';
import 'package:ttlines2/views/Tongariro.dart';
import 'package:ttlines2/views/TT.dart';
import 'package:ttlines2/views/Lake_Omg.dart';
import 'package:ttlines2/views/todays_weather.dart';
import 'package:ttlines2/views/weather.dart';
import 'package:ttlines2/views/weather_forecast.dart';
import 'package:ttlines2/views/troutDataLog.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Turangi Tight Lines',
      // themedata: shared across all of your app:
      theme: ThemeData(
        primaryColor: Color(0xFFA435F0),
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: Color(0xFFA435F0),
      ),
      home: HomeView(),
      // routes: <String, WidgetBuilder> {
      //   '/new_trial' : (BuildContext context) => const newTrialView(),
      // },
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({ Key? key}) : super(key: key); 

  @override
  _HomeViewState createState() => _HomeViewState();
}
class _HomeViewState extends State<HomeView> {
  var fontFamily;

  @override
  Widget build(BuildContext context) {
    // should i put the button style here? does it matter?
    final ButtonStyle style=
    ElevatedButton.styleFrom(primary: Colors.cyan);
    return Scaffold(
      backgroundColor: Colors.teal.shade50,
      appBar: AppBar(
        title: Text('TURANGI TIGHT LINES',
        style: TextStyle(
          fontFamily:'Sofiapro'),
        )
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(padding: EdgeInsets.symmetric(vertical: 8.0)),
            //first child of Column is a Row of 3x buttons - could it be a Button bar?
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children:<Widget>[
                //first child of the ROW -Tongariro Button
                ElevatedButton(
                  style: style, 
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TongariroView()),
                    );
                  },
                  child: const Text('Tongariro')),

                //second child of Row - TT Button
                // ElevatedButton(
                //   style: style, 
                //   onPressed: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(builder: (context) => TaurangaTaupoView()),
                //     );
                //   },
                //   child: const Text('Tauranga Taupo')),

               
                //Third child of Row -LAKE  Omg Button
                // ElevatedButton(
                //   style: style,
                //   onPressed: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(builder: (context) => LakeOmgView()),
                //     );
                //   },
                //   child: const Text('Lake OMG')),

// django api testing -----------------
                ElevatedButton(
                  style: style, 
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TroutDataView()),
                    );
                  },
                  child: const Text('TROUT DATA')),

// weather forecast button
                ElevatedButton(
                  style: style,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => weatherForecastView()),
                    );
                  },
                  child: const Text('FORECAST')),
              ]
            ),
            Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children:<Widget>[
            // take you to the fishing log:
            ElevatedButton(
              onPressed: () {
              Navigator.push(
                context, 
                MaterialPageRoute(builder: (context) => MapsView()),
              );
              },
              child: Text('Fishing Log')),

              // //just for now - testing weather API stuff
            ElevatedButton(
              style: style,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WeatherView()),
                );
              },
              child: const Text('weather API')),

// testing the loading screen example
              ElevatedButton(
              style: style,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => loadingScreenView()),
                );
              },
              child: const Text('loading screen')),







              ]
            ),

            Padding(padding: EdgeInsets.symmetric(vertical: 12.0)),
            Expanded(
              child:Image.asset("assets/images/taupofisherymap.png")),
            Divider(),
          ]  
        )
      )
    );
  }
}