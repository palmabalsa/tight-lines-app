// import 'package:flutter/material.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_icons_null_safety/flutter_icons_null_safety.dart';
// import 'package:ttlines2/services/one_call_weather.dart';
// import 'package:ttlines2/ui/views/WeatherForecast.dart';
// import 'package:ttlines2/ui/views/weather_forecast.dart';
// // import 'package:ttlines2/ui/widgets/graph_options_dropdown.dart';

// class TongariroView extends StatefulWidget {

//   @override
//   _TongariroViewState createState() => _TongariroViewState();
// }
// class _TongariroViewState extends State<TongariroView> {
//   late Future<WeatherDataList> tongaForecast;
//   String tongaLat = '-38.95';
//   String tongaLon = '175.78333';


 
//   String graphValue = '7D';


// DropdownButtonFormField<String> newDropdown() {
//    return DropdownButtonFormField<String>(

//      itemHeight: null,
//      decoration: InputDecoration(
//       //  contentPadding: EdgeInsets.all(8.0),
//        labelStyle: TextStyle(fontWeight: FontWeight.w900),
//        enabled: false,
//        border: OutlineInputBorder(
//          borderSide: BorderSide(color: Colors.teal.shade100),
//          borderRadius: BorderRadius.circular(99),
//        ),
//        filled: true,
//        fillColor: Colors.teal.shade50,
//       ),
//       dropdownColor: Colors.teal.shade50,
//       iconSize: 30,
//       items: [
//         DropdownMenuItem<String>(child: Text('2 Days'), value: '2D'), 
//         DropdownMenuItem<String>(child: Text('7 Days'), value: '7D'),
//         DropdownMenuItem<String>(child: Text('1 Month'), value: '1M'),
//         DropdownMenuItem<String>(child: Text('3 Months'), value: '3M'),
//       ],
//       value: graphValue,
//       onChanged: (value) {
//         setState(() {
//           graphValue = value!;
//         });
//       }
//    );
// }



// @override
//   void initState() {
//     super.initState();
//     tongaForecast = getWeatherData(tongaLat, tongaLon);
//   }


//   @override
//   Widget build(BuildContext context) {
//     var theme = Theme.of(context);
//     final ButtonStyle style=
//     TextButton.styleFrom(primary: Theme.of(context).colorScheme.onPrimary);
//     ElevatedButton.styleFrom(primary: Colors.cyan);
//     return Scaffold(
//       backgroundColor: Colors.teal.shade50,
//       appBar: AppBar(
//         title: Text('TONGARIRO', style: theme.textTheme.headline5,),
      
//       ),
//       body: Center(
//         child: ListView(
//           scrollDirection:Axis.vertical,
//               children: <Widget>[
//                 Padding(
//                 padding: EdgeInsets.fromLTRB(8.0, 15.0, 8.0, 0.0),
//                 child: Column(
//                   children: <Widget> [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Spacer(flex: 1),
//                         Column(
//                           children: <Widget>[
//                           Text('RIVER LEVEL',
//                             style: Theme.of(context).textTheme.headline6,
//                             ),
                         
//                            SizedBox(
//                             width: 120,
//                             height: 40,
//                             child: newDropdown(),
//                             ),
//                           ],
//                         ),
//                         Spacer(flex: 6),
//                         Column(
//                           children: [
//                             ElevatedButton.icon(
//                               // style: ButtonStyle(backgroundColor: MaterialStateProperty(Colors.amber)),
//                               onPressed: () {}, 
//                               icon: Icon(Icons.sunny),
//                               label: Text("Forecast"))
//                           ],
//                         ),
                        

//                       ]
//                     ),
                  
//                     Container(
//                       height: 200,
//                       margin: EdgeInsets.fromLTRB(8.0, 5.0, 8.0, 0.0),
//                       child: Card( 
//                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16) ),
//                         color: Colors.white,
//                         child: Column(
//                         children : [ 
//                           SizedBox(
//                             height: 6,
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               Spacer(),
//                               Text('Tongariro @ Turangi', style: theme.textTheme.bodyText2),
//                               Spacer(flex: 6),
//                             ]
//                           ),
//                           SizedBox(
//                             height: 1,
//                           ),
//                           Image.network('https://gesakentico.blob.core.windows.net/genesis/WebGraphs/Tongariro%20at%20Turangi_$graphValue.gif'),
//                         ]),
//                       ),
//                     ),
                      
//                     SizedBox(
//                         height: 5,
//                     ),

//                     Container(
//                       height: 200,
//                       margin: EdgeInsets.fromLTRB(8.0, 5.0, 8.0, 0.0),
//                       child: Card(
//                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//                         color: Colors.white,
//                         child: Column(
//                         children : [ 
//                           SizedBox(
//                               height: 6,
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               Spacer(),
//                               Text('Tongariro @ Poutu Intake', style: theme.textTheme.bodyText2),
//                               Spacer(flex: 6),
//                             ]
//                           ),
//                           SizedBox(
//                             height: 1,
//                           ),
//                           Image.network('https://gesakentico.blob.core.windows.net/genesis/WebGraphs/Tongariro%20downstream%20of%20Poutu%20Intake_$graphValue.gif'),
//                         ]
//                         ),
//                       )
//                     ),
//                     SizedBox(
//                       height: 5,
//                     ),


//                     Container(
//                       height: 200,
//                       margin: EdgeInsets.fromLTRB(8.0, 5.0, 8.0, 0.0),
//                       child: Card(
//                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//                         color: Colors.white,
//                         child: Column(
//                         children : [ 
//                           SizedBox(
//                             height: 6,
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               Spacer(),
//                               Text('Tongariro @ Rangipo', style: theme.textTheme.bodyText2),
//                               Spacer(flex: 6),
//                             ]
//                           ),
//                           SizedBox(
//                             height: 1,
//                           ),
//                           Image.network('https://gesakentico.blob.core.windows.net/genesis/WebGraphs/Tongariro%20at%20Rangipo_$graphValue.gif'),
//                         ]),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 5,
//                       ),



//                     Container(
//                       height: 200,
//                       margin: EdgeInsets.fromLTRB(8.0, 5.0, 8.0, 0.0),
//                       child: Card(
//                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//                         color: Colors.white,
//                         child: Column(
//                         children : [ 
//                           SizedBox(
//                               height: 6,
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               Spacer(),
//                               Text('Tongariro @ Waipakihi', style: theme.textTheme.bodyText2),
//                               Spacer(flex: 6),
//                             ]
//                           ),
//                           SizedBox(
//                             height: 1,
//                           ),
//                           Image.network('https://gesakentico.blob.core.windows.net/genesis/WebGraphs/Tongariro%20at%20Waipakihi_$graphValue.gif'),
//                         ]),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ]
//       )
//     // ]
//   // )
//       )
//     );
//   }
// }