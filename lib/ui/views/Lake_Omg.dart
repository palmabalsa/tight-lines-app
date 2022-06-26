import 'package:flutter/material.dart';
import 'package:flutter_icons_null_safety/flutter_icons_null_safety.dart';
import 'package:ttlines2/ui/widgets/RiverDropDownMenu.dart';
import 'package:ttlines2/ui/widgets/RiverLevelCard.dart';
import 'package:ttlines2/ui/widgets/RiverTitleAndWeatherButton.dart';
import 'package:ttlines2/ui/widgets/RiverAppBar.dart';

class LakeOmgView extends StatefulWidget {
  const LakeOmgView({Key? key,}) : super(key: key);

  @override
  _LakeOmgViewState createState() => _LakeOmgViewState();
}

class _LakeOmgViewState extends State<LakeOmgView> {

  String lakeOLat = '-38.99823';
  String lakeOLon = '175.62021';
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
        style: theme.textTheme.headline5
        ),
        automaticallyImplyLeading: false,
        actions: <Widget> [
          
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(primary: Colors.teal.shade100, shape: CircleBorder(side: BorderSide.none )),
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                context, '/log', (Route<dynamic> route) => false);
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
          children: <Widget> [
            Column(
              children: <Widget> [
                RiverAppBar(style: style),
                SizedBox(
                  height: 10
                ),

                RiverTitle(
                  riverName: 'LAKE O', 
                  lat: lakeOLat, 
                  lon: lakeOLon
                ),

                RiverDropDown(
                  rivertitle: 'LAKE LEVEL', 
                  graphvalue: graphValue, 
                  updateGraphValue : graphcallbackfunction,
                ),

                RiverLevelCard(
                  theme: theme, 
                  measuringSiteName: 'Lake Otamangakau at Dam', 
                  measuringSiteUrl: 'Lake%20Otamangakau%20at%20Dam_', 
                  graphValue: graphValue
                ),
              ]
            )
          ]
        )
      )
    );



  }
}