import 'package:flutter/material.dart';

class TaurangaTaupoView extends StatefulWidget {
  const TaurangaTaupoView({ Key? key }) : super(key: key);

  @override
  _TaurangaTaupoViewState createState() => _TaurangaTaupoViewState();
}

class _TaurangaTaupoViewState extends State<TaurangaTaupoView> {

  
String ttLat =  '-38.93823';
String ttLon = '175.93021';







  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('TAURANGA TAUPO',
        style: theme.textTheme.headline5),
      ),
      body: Center(
          child: ListView(
            children: [
              //do i need this button? goes back to home page - look up Navigator
              //ElevatedButton( 
              //  onPressed: () {
              //    Navigator.pop(context);
              //  },
              //  child: Text('Home'),
              //),
              Text('Tauranga Taupo River Level'),
              Image.network('http://riverlevelsmap.waikatoregion.govt.nz/cgi-bin/hydwebserver.cgi/points/plot?point=1')
              // change the width and height of this graph so that it fits on the page better
            ],
          ), 
      )     
    );
  }
}