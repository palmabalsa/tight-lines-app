import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

String fromDate = '2022-08-20-14-00';
String toDate = '2022-08-24-09-13';

// String calculateDates (){
//   DateTime currentdate = DateTime.now();
// //   print
// // }

// https://waikatoregion.govt.nz/api/v1/enviromap/stationData/?stations=42456&type=WL&tstypeoption=Day.Mean&fromDate=2021-08-20-14-00&toDate=2022-08-24-09-13

String TTendpoint =
    'https://waikatoregion.govt.nz/api/v1/enviromap/stationData/?stations=42456&type=WL&tstypeoption=Day.Mean&fromDate=2021-08-20-14-00&toDate=2022-08-24-09-13';

Future getTTRiverLevel() async {
  Map<String, String> headers = {
    'Content-Type': 'text/html',
    // 'Content-Type': "application/x-www-form-urlencoded".
    // 'Content-Type': 'text/html',
    // 'Accept': 'application/json',
    'Accept': "application/json",
    // "Authorization": 'Bearer ' + userToken,
  };
  // var response = await http.get(
  //   Uri.parse(mainUrl + "api/log/"),
  //   headers: headers,
  // );
  var response = await http.get(
    Uri.parse(TTendpoint),
    headers: headers,
  );
  print(response);

  if (response.statusCode == 200) {
    var riverData = response.body;

    // var riverData = jsonDecode(response.body);
    print(riverData);
    return riverData;
  } else {
    print(response.statusCode);
    throw (Exception('error HERE'));
  }
}
