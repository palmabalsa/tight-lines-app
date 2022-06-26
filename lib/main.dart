import 'package:flutter_icons_null_safety/flutter_icons_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:ttlines2/ui/themes.dart';
import 'package:ttlines2/ui/views/TT.dart';
import 'package:ttlines2/ui/views/Lake_Omg.dart';
import 'package:ttlines2/ui/views/troutDataLog.dart';
import 'package:ttlines2/ui/widgets/RiverDropDownMenu.dart';
import 'package:ttlines2/ui/widgets/RiverLevelCard.dart';
import 'package:ttlines2/ui/widgets/RiverTitleAndWeatherButton.dart';
import 'package:ttlines2/ui/widgets/RiverAppBar.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Turangi Tight Lines',
      theme:  Themes.light,
      initialRoute: '/',
      routes: <String, WidgetBuilder> {
        '/' : (context) => const HomeView(),
        '/taurangataupo' : (context) => const TaurangaTaupoView(),
        '/lakeO' : (context) => const LakeOmgView(),
        '/log' : (context) => TroutDataView(),
      },
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({ Key? key}) : super(key: key); 

  @override
  _HomeViewState createState() => _HomeViewState();
}
class _HomeViewState extends State<HomeView> {
  String tongaLat = '-38.95';
  String tongaLon = '175.78333';
  var fontFamily;
  String graphValue = '7D';

  void graphcallbackfunction(String newValue){
    setState(() {
      graphValue = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    
    final ButtonStyle style=
    TextButton.styleFrom(primary: Theme.of(context).colorScheme.onPrimary);
    ElevatedButton.styleFrom(primary: Colors.amber);
    

    return Scaffold(
      backgroundColor: Colors.teal.shade50,
      appBar: AppBar(
        title: Text('TURANGI TIGHT LINES',
        style: theme.textTheme.headline5,
        ),
        actions: <Widget> [
          
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(primary: Colors.teal.shade100, shape: CircleBorder(side: BorderSide.none )),
            onPressed: () {
              Navigator.pushNamed(
                context, '/log');
            }, 
            icon: Icon(MaterialCommunityIcons.fish),
            label: Text('LOG', style: theme.textTheme.bodyText2)
          ),
          // ),
        ]
      ),
      body: Center(
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [ 
            Column(
              children: <Widget>[
                RiverAppBar(style: style),
                SizedBox(
                  height: 10
                ),
                RiverTitle(
                  riverName: 'TONGARIRO', 
                  lat: tongaLat, 
                  lon: tongaLon
                ),

                RiverDropDown(
                  rivertitle: 'RIVER LEVEL',
                  graphvalue: graphValue, 
                  updateGraphValue: graphcallbackfunction
                ),
              
                RiverLevelCard(
                  theme: theme, 
                  measuringSiteName: 'Tongariro @ Turangi',
                  measuringSiteUrl: 'Tongariro%20at%20Turangi_',
                  graphValue: graphValue
                ),
                RiverLevelCard(
                  theme: theme, 
                  measuringSiteName: 'Tongariro @ Poutu Intake',
                  measuringSiteUrl: 'Tongariro%20downstream%20of%20Poutu%20Intake_',
                  graphValue: graphValue
                ),
                RiverLevelCard(
                  theme: theme, 
                  measuringSiteName: 'Tongariro @ Rangipo',
                  measuringSiteUrl: 'Tongariro%20at%20Rangipo_',
                  graphValue: graphValue
                ),
                RiverLevelCard(
                  theme: theme, 
                  measuringSiteName: 'Tongariro @ Waipakihi',
                  measuringSiteUrl: 'Tongariro%20at%20Waipakihi_',
                  graphValue: graphValue
                ),
              ],
            )
          ]
        )
      )  
    );
  }
}

