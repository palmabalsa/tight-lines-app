import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:flutter_dotenv/flutter_dotenv.dart';

String mainUrl = dotenv.env['TIGHTLINES_API_URL'].toString();

final FirebaseAuth auth = FirebaseAuth.instance;

final fireuser = auth.currentUser!;
final fireuid = fireuser.uid;
final newuser = auth.currentUser!;
final firetoken = newuser.getIdToken();

Future<void> deleteEntry(List<int>? idList) async {
  String? userToken = await FirebaseAuth.instance.currentUser!.getIdToken();

  Map<String, String> headers = {
    'Accept': 'application/json',
    "Authorization": 'Bearer $userToken',
  };
  for (int id in idList!) {
    http.Response response = await http
        .delete(Uri.parse('${mainUrl}api/trout/log/$id/'), headers: headers);
    if (response.statusCode == 204) {
      print(response.statusCode);
    } else {
      throw Exception('Failed to Delete');
    }
  }
}

Future<void> updateEntry(List<int>? idList) async {
  String? userToken = await FirebaseAuth.instance.currentUser!.getIdToken();

  Map<String, String> headers = {
    // 'Content-Type': 'application/json',
    'Accept': 'application/json',
    "Authorization": 'Bearer $userToken',
  };

  for (int id in idList!) {
    http.Response response = await http
        .patch(Uri.parse('${mainUrl}api/trout/log/$id/'), headers: headers);
    if (response.statusCode == 200) {
      // print(response.statusCode);
    } else {
      throw Exception('Failed to Update');
    }
  }
}

Future<List<TroutData>> fetchTroutData() async {
  String? userToken = await FirebaseAuth.instance.currentUser!.getIdToken();
  // print(userToken);

  Map<String, String> headers = {
    // 'Content-Type': 'application/json; UTF-8',
    'Accept': 'application/json',
    "Authorization": 'Bearer $userToken',
  };
  var response = await http.get(
    Uri.parse("${mainUrl}api/trout/log/"),
    headers: headers,
  );

  if (response.statusCode == 200) {
    final List parsedList = jsonDecode(response.body);
    List<TroutData> troutdata =
        parsedList.map((val) => TroutData.fromJson(val)).toList();
    // print(userToken);
    return troutdata;
  } else {
    // print(response.statusCode);
    throw (Exception('error HERE'));
  }
}
// }

Future<TroutData> newCatch(TroutData myCatch) async {
  String? userToken = await FirebaseAuth.instance.currentUser!.getIdToken();

  Map<String, String> headers = {
    'Content-Type': 'application/json',
    // 'Content-Type': 'MediaType.parse("image/jpg")',
    'Accept': 'application/json',
    "Authorization": 'Bearer $userToken',
  };
  final uri = Uri.parse('${mainUrl}api/trout/create/');
  var request = http.MultipartRequest('POST', uri);
  request.fields['user'] = myCatch.user!;
  request.fields['id'] = myCatch.id.toString();
  request.fields['date'] = myCatch.date.toIso8601String();
  request.fields['river'] = myCatch.river;
  request.fields['river_pool'] = myCatch.riverPool!;
  request.fields['lat'] = myCatch.lat!.toString();
  request.fields['lon'] = myCatch.lon!.toString();
  request.fields['fish_weight'] = myCatch.fishWeight!;
  request.fields['kept_or_released'] = myCatch.keptOrReleased;
  request.fields['fish_species'] = myCatch.fishSpecies;
  request.fields['fish_condition'] = myCatch.fishCondition;
  request.fields['fly_used'] = myCatch.flyUsed!;
  request.fields['any_notes'] = myCatch.anyNotes!;

  if (myCatch.fishImage != null) {
    request.files.add(
        await http.MultipartFile.fromPath("image", myCatch.fishImage!.path));
  }
  request.headers.addAll(headers);

  final response = await request.send();

  var responsed = await http.Response.fromStream(response);
  final responseData = TroutData.fromJson(jsonDecode(responsed.body));

  if (response.statusCode == 201) {
    print('Uploaded!');
    return responseData;
  } else if (response.statusCode == 400) {
    throw Exception('Failed to log new catch');
  }
  return responseData;
}

class TroutData {
  String? user;
  int? id;
  DateTime date;
  String river;
  String? riverPool;
  double? lat;
  double? lon;
  String? fishWeight;
  String keptOrReleased;
  String fishSpecies;
  String fishCondition;
  String? flyUsed;
  String? anyNotes;
  // int? numberOfFish;
  File? fishImage;
  // String? fishImage;

  TroutData(
      {required this.user,
      this.id,
      required this.date,
      required this.river,
      this.riverPool,
      this.lat,
      this.lon,
      this.fishWeight,
      required this.keptOrReleased,
      required this.fishSpecies,
      required this.fishCondition,
      this.flyUsed,
      this.anyNotes,
      // });
      // this.numberOfFish,
      this.fishImage});

  bool thisoneselected = false;

  factory TroutData.fromJson(Map<String, dynamic> json) {
    return TroutData(
        user: json['user'],
        id: json['id'] as int,
        date: DateTime.parse(json['date']),
        river: json['river'],
        riverPool: json['river_pool'],
        lat: double.parse(json['lat']),
        lon: double.parse(json['lon']),
        keptOrReleased: json['kept_or_released'],
        fishWeight: json['fish_weight'],
        fishSpecies: json['fish_species'],
        fishCondition: json['fish_condition'],
        flyUsed: json['fly_used'],
        anyNotes: json['any_notes'],
        // numberOfFish: json['number_of_fish'],
        fishImage: json['image'] != null ? File(json['image']) : null);
  }

  Map<String, dynamic> toJson() => {
        'user': user,
        'id': id,
        'date': date.toIso8601String(),
        'river': river,
        'river_pool': riverPool,
        'lat': lat!.toDouble(),
        'lon': lon!.toDouble(),
        'kept_or_released': keptOrReleased,
        'fish_weight': fishWeight,
        'fly_used': flyUsed,
        'any_notes': anyNotes,
        'fish_species': fishSpecies,
        'fish_condition': fishCondition,
        // 'number_of_fish': numberOfFish,
        'image': fishImage,
      };
}
