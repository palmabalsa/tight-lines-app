import 'dart:ui';
import 'package:flutter_icons_null_safety/flutter_icons_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:ttlines2/ui/views/maps.dart';
import 'package:ttlines2/ui/views/Tongariro.dart';
import 'package:ttlines2/ui/themes.dart';
import 'package:ttlines2/ui/views/TT.dart';
import 'package:ttlines2/ui/views/Lake_Omg.dart';
import 'package:ttlines2/ui/views/weather_forecast.dart';
import 'package:ttlines2/ui/views/troutDataLog.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Turangi Tight Lines',
      theme:  Themes.light,
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
    var theme = Theme.of(context);
    
    final ButtonStyle style=
    TextButton.styleFrom(primary: Theme.of(context).colorScheme.onPrimary);
    ElevatedButton.styleFrom(primary: Colors.cyan);

    return Scaffold(
      backgroundColor: Colors.teal.shade50,
      appBar: AppBar(
        // toolbarHeight: 70,
        title: Text('TURANGI TIGHT LINES',
        style: theme.textTheme.headline5,
        ),
        actions: <Widget> [
        
           TextButton.icon(
                style: style,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TroutDataView()),
                  );
                },
                icon: const Icon(MaterialCommunityIcons.fish),
                label: Text('LOG'),
              ),


          // IconButton(
          //   onPressed: () {
          //           Navigator.push(
          //             context,
          //             MaterialPageRoute(builder: (context) => TroutDataView()),
          //           );
          //         },
          //   icon: const Icon(MaterialCommunityIcons.fish),

            //  Icon(FontAwesome5.fish),
          //)


        ]
      ),
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            AppBar(
              toolbarHeight: 47,
              actions: <Widget> [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround, 
                  children: [
                    TextButton(
                      style : style, 
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => TongariroView()),
                        );
                      },
                      child: const Text('TONGARIRO')
                    ),
                    TextButton(
                      style: style, 
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => TaurangaTaupoView()),
                        );
                      },
                      child: const Text('TT')
                    ),
                    TextButton(
                      style: style, 
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LakeOmgView()),
                        );
                      },
                      child: const Text('LAKE O')
                    ),
                    TextButton(
                      style: TextButton.styleFrom(primary: Colors.amber,),      //TextButton.styleFrom(primary: Theme.of(context).colorScheme.onPrimary); 
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => weatherForecastView()),
                        );
                      },
                      child: const Text('FORECAST')
                    ),
                  ]
                )



              ],
            ),





//             Padding(padding: EdgeInsets.symmetric(vertical: 8.0)),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children:<Widget>[
                   
// // GOOGLE MAPS view
//                 ElevatedButton(
//                 onPressed: () {
//                 Navigator.push(
//                   context, 
//                   MaterialPageRoute(builder: (context) => MapsView()),
//                 );
//                 },
//                 child: Text('Map')
//                 ),
//               ]
//             ),
            
            // Padding(padding: EdgeInsets.symmetric(vertical: 40.0),
            // // Expanded(
            //   child:Image.asset("assets/images/taupofisherymap.png")
            //   // ),
            // ),
            // Divider(),
          ]  
        )
      )
    );
  }
}