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

String tongaLat = '-38.95';
String tongaLon = '175.78333';



  @override
  void initState() {
    super.initState();
    aloha = getWeatherData(tongaLat, tongaLon);
    }


    String theWeekDay = 'Monday';
    String theMonth = 'Jan';

    void DateFormatter (String weekday, String month) {
    Map<String, String> dayDate = {"1" : "Monday", "2" : "Tuesday", "3" : "Wednesday", "4" : "Thursday", "5" : "Friday", "6" : "Saturday", "7" : "Sunday"};
    Map<String, String> monthDate = {"1" : "Jan", "2" : "Feb", "3" : "March", "4" : "April", "5" : "May", "6" : "June", "7" : "July", "8" : "Aug", "9" : "Sep", "10" : "Oct", "11" : "Nov", "12" : "Dec" };
    theWeekDay = '${dayDate[weekday]}' ;
    theMonth = '${monthDate[month]}' ;
    }



  @override
    Widget build(BuildContext context) {
      var theme = Theme.of(context);
      return Scaffold(
        appBar: AppBar(
          title: Text('WEATHER', 
          style: theme.textTheme.headline5, ),
        ),
        body: Center(
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              Divider(),
              Text('TONGARIRO WEATHER', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
              Divider(),
            
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


                          

                          String weathericon = snapshot.data!.weatherList[index].weather_main[0].icon.toString();
                          final currentDate = DateTime.parse('${snapshot.data!.weatherList[index].date}');
                          String weekdayNumber = currentDate.weekday.toString();
                          String monthNumber = currentDate.month.toString();
                          DateFormatter(weekdayNumber, monthNumber);

                          return 
                          SizedBox(
                            height: 200,
                            width: 165.0,
                            child: 
                          Card(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget> [
                                    Text(theWeekDay, style: TextStyle(fontWeight: FontWeight.bold)),
                                    Text('${currentDate.day.toString()} $theMonth'),
                                    // get this weather icon internally: 
                                    Image.network('http://openweathermap.org/img/w/$weathericon.png'),
                                    

                                    // Text(snapshot.data!.weatherList[index].weather_main[0].main_description, style: TextStyle(color: Colors.black, fontSize: 15.0,  )),
                                    Text(snapshot.data!.weatherList[index].weather_main[0].description, style: TextStyle(color: Colors.black, fontSize: 15.0,  )),
                                    Divider(),
                                    Text('Wind: ${snapshot.data!.weatherList[index].wind_speed.toString()} m/s, ${snapshot.data!.weatherList[index].wind_deg.toString()} °', style: TextStyle(color: Colors.black, fontSize: 12.0)),
                                    // get the wind in direction (eg: southerly?west etc)
                                    Divider(),
                                    

                                    // ExpansionPanelList(
                                    //   children: [
                                    //     ExpansionPanel(
                                    //       headerBuilder: (context, isExpanded) {
                                    //         return Text("Hourly");
                                    //       }, 
                                    //       body: Text('hourly weather'),//the context of the opened panel,
                                    //       // isExpanded:
                                    //       ),
                                    //   ]
                                    // )
                                  ] 
                                )
                              )
                            )
                          );
                        }
                      
                      )
                    )
                    
                  );
                  }
                  else if (snapshot.hasError){
                  throw Exception('theres an error mate');
                  }
                    return CircularProgressIndicator();
                } 
              ),
           ],
          )
        )
      );
    }
}













