// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:ttlines2/services/networking.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';

// class loadingScreenView extends StatefulWidget {
//   loadingScreenView({Key? key}) : super(key: key);

//   @override
//   State<loadingScreenView> createState() => _loadingScreenViewState();
// }

// class _loadingScreenViewState extends State<loadingScreenView> {


// @override
//   void initState() {
//     super.initState();
//     print('init state called');
//     getWeatherData();
//     // getWeatherIcon();
//   }

// Future <void> getWeatherData() async {
//    var weatherApiUrl = '***REMOVED***data/2.5/onecall?lat=-39.0982&lon=175.8302&exclude=current,minutely,hourly,alerts&units=metric&appid=***REMOVED***';

//   NetworkHelper weatherNetworkRequest = NetworkHelper(weatherApiUrl);

//   var weatherToday = await weatherNetworkRequest.getData();

// // NAVIGATOR
// //couldnt get pushNamed to work because it wouldnt take arguments(like passing data)
// // i needed to define arguments, extract them etc etc 
//   //  Navigator.pushNamed(context, '/new_trial');
//   Navigator.push(context, MaterialPageRoute(builder: (context) {
//     return todaysWeatherView(apiRetrievedWeather : weatherToday);
//     }));
//   }



// @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: SpinKitFadingCircle(
//           color: Colors.blue.shade900,
//           size: 70.0,
//         )
//       ),
//     );
//   }
// }