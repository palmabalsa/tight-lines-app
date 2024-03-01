import 'package:flutter/material.dart';
import 'package:ttlines2/ui/views/TT_webview.dart';
import 'package:ttlines2/ui/widgets/riverdropdown_and_weather_header.dart';

class TaurangaTaupoView extends StatefulWidget {
  const TaurangaTaupoView({Key? key}) : super(key: key);

  @override
  State<TaurangaTaupoView> createState() => _TaurangaTaupoViewState();
}

class _TaurangaTaupoViewState extends State<TaurangaTaupoView> {
  String ttLat = '-38.93823';
  String ttLon = '175.93021';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          const SizedBox(
            height: 10,
          ),
          RiverDropDown(waterwayName: 'Tauranga Taupo', lat: ttLat, lon: ttLon),
          const SizedBox(
            height: 5,
          ),
          const SizedBox(height: 2000, width: 100, child: TTWebview()
              // child: WebView(
              //   initialUrl:
              //       'https://waikatoregion.govt.nz/environment/envirohub/environmental-maps-and-data/station/42456/WL?dt=Level',
              //   javascriptMode: JavascriptMode.unrestricted,
              //   navigationDelegate: (NavigationRequest request) {
              //     return NavigationDecision.prevent;
              //   },
              // ),
              )
        ],
      ),
    ));
  }
}
