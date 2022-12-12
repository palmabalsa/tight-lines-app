import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:ttlines2/services/tt_river_level.dart';
import 'package:ttlines2/ui/views/tt_line_charts.dart';
import 'package:ttlines2/ui/widgets/river_drop_down_menu.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TaurangaTaupoView extends StatefulWidget {
  const TaurangaTaupoView({Key? key}) : super(key: key);

  @override
  _TaurangaTaupoViewState createState() => _TaurangaTaupoViewState();
}

class _TaurangaTaupoViewState extends State<TaurangaTaupoView> {
  String ttLat = '-38.93823';
  String ttLon = '175.93021';

  late Future<TTData> getTTData;

  @override
  void initState() {
    super.initState();
    getTTData = getTTRiverLevel();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
        body: Center(
      child: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          const SizedBox(
            height: 10,
          ),
          RiverDropDown(riverName: 'Tauranga Taupo', lat: ttLat, lon: ttLon),
          const SizedBox(
            height: 5,
          ),
          FutureBuilder<TTData>(
              future: getTTData,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var latestData = snapshot.data!.riverLevel;
                  print(latestData);
                  return Container(
                      child: LineChartWidget(
                    datapoints: [],
                  ));

                  // return SizedBox(
                  //     height: 250,
                  //     child: LineChartWidget(
                  //         datapoints: getDataPoints(latestData)));
                  // // this works:
                  // // double waterLevel = snapshot.data!.waterLevel[0][1];
                  // // print(waterLevel);
                  // // return SizedBox(child: Text(waterLevel.toString()));
                } else {
                  return const CircularProgressIndicator();
                }
              })

          // SizedBox(
          //   height: 2000,
          //   width: 100,
          //   child: WebView(
          //     initialUrl:
          //         'https://waikatoregion.govt.nz/environment/envirohub/environmental-maps-and-data/station/42456/WL?dt=Level',
          //     javascriptMode: JavascriptMode.unrestricted,
          //     navigationDelegate: (NavigationRequest request) {
          //       return NavigationDecision.prevent;
          //     },
          //   ),
          // )
        ],
      ),
    ));
  }
}
