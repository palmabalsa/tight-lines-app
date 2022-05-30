// import 'package:flutter/material.dart';

// class WeatherCard extends StatelessWidget {
  
//   const WeatherCard({
//      Key? key,
//      required this.weather 
//      }) : super(key: key);

//      final Weather weather;

//   @override
//   Widget build(BuildContext context) {
//     var theme = Theme.of(context);

//     // return Container(
//     //       height: 300.0,
//     //       child: ListView.builder(
//     //         itemCount: snapshot.data!.weatherList.length, 
//     //         scrollDirection: Axis.horizontal, 
//     //         itemBuilder: (context, index) {


// // Date formatter
//               // String weathericon = snapshot.data!.weatherList[index].weather_main[0].icon.toString();
//               // final currentDate = DateTime.parse('${snapshot.data!.weatherList[index].date}');
//               // String weekdayNumber = currentDate.weekday.toString();
//               // String monthNumber = currentDate.month.toString();
//               // DateFormatter(weekdayNumber, monthNumber);

//               return 
//               SizedBox(
//                 height: 200,
//                 width: 165.0,
//                 child: 
//               Card(
//                   child: Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: <Widget> [
//                         // Text(theWeekDay, style: TextStyle(fontWeight: FontWeight.bold)),
//                         // Text('${currentDate.day.toString()} $theMonth'),
//                         // get this weather icon internally: 
//                         Image.network('http://openweathermap.org/img/w/${weather.icon}.png'),
                        

//                         // Text(snapshot.data!.weatherList[index].weather_main[0].main_description, style: TextStyle(color: Colors.black, fontSize: 15.0,  )),
//                         Text(weather.main, style: TextStyle(color: Colors.black, fontSize: 15.0,  )),
//                         Divider(),
//                         Text('Wind: ${weather.wind_speed.toString()} m/s, ${weather.wind_deg.toString()} °', style: TextStyle(color: Colors.black, fontSize: 12.0)),
//                         // get the wind in direction (eg: southerly?west etc)
//                         Divider(),
                        

//                         // ExpansionPanelList(
//                         //   children: [
//                         //     ExpansionPanel(
//                         //       headerBuilder: (context, isExpanded) {
//                         //         return Text("Hourly");
//                         //       }, 
//                         //       body: Text('hourly weather'),//the context of the opened panel,
//                         //       // isExpanded:
//                         //       ),
//                         //   ]
//                         // )
//                       ] 
//                     )
//                   )
//                 )
//               );
//             }
          
//           )
//         )
        
//       );
//       }

//     );
//   }
// }