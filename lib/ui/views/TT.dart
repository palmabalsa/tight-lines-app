import 'package:flutter/material.dart';
import 'package:ttlines2/services/tt_river_level.dart';
import 'package:ttlines2/ui/widgets/RiverDropDownMenu.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TaurangaTaupoView extends StatefulWidget {
  const TaurangaTaupoView({Key? key}) : super(key: key);

  @override
  _TaurangaTaupoViewState createState() => _TaurangaTaupoViewState();
}

class _TaurangaTaupoViewState extends State<TaurangaTaupoView> {
  String ttLat = '-38.93823';
  String ttLon = '175.93021';

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
        body: Center(
      child: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          RiverDropDown(riverName: 'Tauranga Taupo', lat: ttLat, lon: ttLon),
          SizedBox(
            height: 5,
          ),
          Container(
            height: 2000,
            width: 100,
            child: WebView(
              initialUrl:
                  'https://waikatoregion.govt.nz/environment/envirohub/environmental-maps-and-data/station/42456/WL?dt=Level',
              javascriptMode: JavascriptMode.unrestricted,
              navigationDelegate: (NavigationRequest request) {
                return NavigationDecision.prevent;
              },
            ),
          )
        ],
      ),
    ));
  }
}
