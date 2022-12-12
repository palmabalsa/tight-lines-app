import 'dart:convert';

import 'package:http/http.dart' as http;
import 'dart:async';

import 'package:intl/intl.dart';

Future<TTData> getTTRiverLevel() async {
  String ttEndpoint =
      'http://envdata.waikatoregion.govt.nz:8080/KiWIS/KiWIS?service=kisters&type=queryServices&request=getTimeseriesValues&datasource=0&format=dajson&dateformat=yyyy-MM-dd HH:mm:ss&ts_path=971/4/S/Cmd.P&period=P1D';

  var response = await http.get(
    Uri.parse(ttEndpoint),
  );
  if (response.statusCode == 200) {
    TTData incomingdata = TTData.fromJson(jsonDecode(response.body));
    // print(incomingdata.riverLevel[0]);
    return incomingdata;
  } else {
    print(response.statusCode);
    throw (Exception('error HERE'));
  }
}

// class TTData {
//   List<TTRiverLevelData> riverLevel;
//   TTData({required this.riverLevel});
//   factory TTData.fromJson(List<dynamic> json) {
//     return TTData(
//         riverLevel: List<TTRiverLevelData>.from(json[0]['data'].map((x) => x)));
//   }
// }

class TTData {
  List<List> riverLevel;
  TTData({required this.riverLevel});
  factory TTData.fromJson(List<dynamic> json) {
    return TTData(riverLevel: List<List>.from(json[0]['data'].map((x) => x)));
  }
}

class TTRiverLevelData {
  // x axis
  double fiveMinInterval;
  // y axis
  double waterLevel;
  TTRiverLevelData({required this.waterLevel, required this.fiveMinInterval});
}

List<TTRiverLevelData> getDataPoints(List<List> apiDataInput) {
  List<TTRiverLevelData> dataPoints = [];
  List<dynamic> dayParameter = [];
  List<dynamic> xxx = [];
  for (List item in apiDataInput) {
    List<String> datetimeSplit = item[0].split(' ');
    dayParameter.add(DateFormat.MMMd(datetimeSplit[0]));
    String newString = '${datetimeSplit[0]}T+${datetimeSplit[1]}';
    // parse.double(newString);
    xxx.add(newString);

    final timeParameter = dataPoints.map((e) => TTRiverLevelData(
        waterLevel: item[1] as double, fiveMinInterval: item[0] as double));
  }
  return dataPoints;
}
