import 'package:flutter/material.dart';

class TaurangaTaupoView extends StatefulWidget {
  const TaurangaTaupoView({ Key? key }) : super(key: key);

  @override
  _TaurangaTaupoViewState createState() => _TaurangaTaupoViewState();
}

class _TaurangaTaupoViewState extends State<TaurangaTaupoView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tauranga Taupo River')
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