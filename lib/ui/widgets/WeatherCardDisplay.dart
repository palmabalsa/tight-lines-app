// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class WeatherReportCard extends StatelessWidget {
   WeatherReportCard({
    Key? key,
    required this.isInitialCard,
    this.hourlyListView,

    required this.weekday,
    required this.month,
    required this.date,

    required this.weathericon,
    required this.temperature,
    required this.windSpeed,
    required this.windIcon,
    required this.description, 
    
    }) : super(key: key);
    bool isInitialCard;
    ListView? hourlyListView;

    String weekday;
    String month;
    String date;

    String weathericon;
    String temperature;
    String windSpeed;
    Icon windIcon;
    String description;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: isInitialCard == true ? 300 : 175,
      // height: 300,
      //  height: 200,
      width: 165.0,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16) ),
        color: Colors.white,
        child: Padding( padding: const EdgeInsets.fromLTRB(60.0, 20.0, 50.0, 0.0),
        child: Column(
        children: <Widget> [  
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget> [
              Column(
                children : <Widget>[
                  Divider(),
                  Divider(),
                  Text(weekday, style: TextStyle(fontWeight: FontWeight.bold)),
                   Text('$date $month'),
                ],
              ),
              Spacer(),
              Column(
                children: <Widget> [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget> [
                      Column(
                        children : <Widget>[
                          Text(' $temperature°C', style: TextStyle(color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      SizedBox(
                        width:4
                      ),
                      Column(
                        children : <Widget>[
                          Image.network('http://openweathermap.org/img/w/$weathericon.png'),
                        ],
                      ),
                    ]
                  ),
                  Text('$description', style: TextStyle(color: Colors.black, fontSize: 15.0,  )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:<Widget> [
                      Text('wind  $windSpeed m/s', style: TextStyle(color: Colors.blueGrey, fontSize: 12.0, fontWeight: FontWeight.bold)),
                      windIcon,
                    ],
                  )
                ],
              )
            ]
          ),
          isInitialCard == true? 
            ExpansionTile(
              title: Text("Next 48Hrs Forecast", style: TextStyle(color: Colors.teal),),
              children: <Widget>[
                Container(
                  height: 115,
                  child: SingleChildScrollView(
                    child: hourlyListView!
                  )
                )
              ]
              )
              : SizedBox(),

        ]
        ),
        )
        )
      );
  } 
}




    