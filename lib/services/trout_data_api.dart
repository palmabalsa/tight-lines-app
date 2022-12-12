import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:flutter_dotenv/flutter_dotenv.dart';

String mainUrl = dotenv.env['TIGHTLINES_API_URL'].toString();

final troutDataServiceProvider =
    Provider<TroutDataService>((ref) => TroutDataService());

final FirebaseAuth auth = FirebaseAuth.instance;

// Future<String> firebaseUID() async {
final fireuser = auth.currentUser!;
final fireuid = fireuser.uid;
//   return fireuid;
// }

// Future<String> firebaseToken() async {
final newuser = auth.currentUser!;
final firetoken = newuser.getIdToken();
//   return firetoken;
// }

class TroutDataService {
// EDITED TRIAL::::::::::::::
  Future<void> deleteEntry(List<int>? idList) async {
    String userToken = await FirebaseAuth.instance.currentUser!.getIdToken();

    Map<String, String> headers = {
      'Content-Type': 'application/json',
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
    String userToken = await FirebaseAuth.instance.currentUser!.getIdToken();

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      "Authorization": 'Bearer $userToken',
    };

    for (int id in idList!) {
      http.Response response = await http
          .patch(Uri.parse('${mainUrl}api/trout/log/$id/'), headers: headers);
      if (response.statusCode == 200) {
        print(response.statusCode);
      } else {
        throw Exception('Failed to Update');
      }
    }
  }

  // Future<TroutData> newCatch(TroutData myCatch) async {
  //   String userToken = await FirebaseAuth.instance.currentUser!.getIdToken();

  //   Map<String, String> headers = {
  //     'Content-Type': 'application/json',
  //     'Accept': 'application/json',
  //     "Authorization": 'Bearer $userToken',
  //   };
  //   var body = jsonEncode(myCatch.toJson());

  //   final response = await http.post(Uri.parse('${mainUrl}api/trout/create/'),
  //       headers: headers, body: body);
  //   if (response.statusCode == 201) {
  //     return TroutData.fromJson(jsonDecode(response.body));
  //   } else {
  //     print(response.statusCode);
  //     throw Exception('Failed to log new catch.');
  //   }
  // }

  Future<List<TroutData>> fetchTroutData() async {
    String userToken = await FirebaseAuth.instance.currentUser!.getIdToken();
    print(userToken);

    Map<String, String> headers = {
      'Content-Type': 'application/json; UTF-8',
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
      print(userToken);
      return troutdata;
    } else {
      print(response.statusCode);
      throw (Exception('error HERE'));
    }
  }
}

Future<TroutData> newCatch(TroutData myCatch) async {
  String userToken = await FirebaseAuth.instance.currentUser!.getIdToken();

  Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    "Authorization": 'Bearer $userToken',
  };
  var body = jsonEncode(myCatch.toJson());

  final response = await http.post(Uri.parse('${mainUrl}api/trout/create/'),
      headers: headers, body: body);
  if (response.statusCode == 201) {
    return TroutData.fromJson(jsonDecode(response.body));
  } else {
    print(response.statusCode);
    throw Exception('Failed to log new catch.');
  }
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
  // bool kept_or_released;
  String fishSpecies;
  String fishCondition;
  String? flyUsed;
  String? anyNotes;
  int? numberOfFish;

  TroutData({
    required this.user,
    this.id,
    required this.date,
    required this.river,
    this.riverPool,
    this.lat,
    this.lon,
    this.fishWeight,
    // required this.kept_or_released,
    required this.fishSpecies,
    required this.fishCondition,
    this.flyUsed,
    this.anyNotes,
    this.numberOfFish,
  });

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
      // kept_or_released : json['kept_or_released'],
      fishWeight: json['fish_weight'],
      fishSpecies: json['fish_species'],
      fishCondition: json['fish_condition'],
      flyUsed: json['fly_used'],
      anyNotes: json['any_notes'],
      numberOfFish: json['number_of_fish'],
    );
  }

  Map<String, dynamic> toJson() => {
        'user': user,
        'id': id,
        'date': date.toIso8601String(),
        'river': river,
        'river_pool': riverPool,
        'lat': lat!.toDouble(),
        'lon': lon!.toDouble(),
        // 'kept_or_released': kept_or_released,
        'fish_weight': fishWeight,
        'fly_used': flyUsed,
        'any_notes': anyNotes,
        'fish_species': fishSpecies,
        'fish_condition': fishCondition,
        'number_of_fish': numberOfFish,
      };
}
