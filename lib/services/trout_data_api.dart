import 'package:confetti/confetti.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:ttlines2/ui/views/Confetti_Screen.dart';

final FirebaseAuth auth = FirebaseAuth.instance;

Future<String> firebaseUID() async {
  final fireuser = await auth.currentUser!;
  final fireuid = fireuser.uid;
  return fireuid;
}

Future<String> firebaseToken() async {
  final newuser = await auth.currentUser!;
  final firetoken = newuser.getIdToken();
  return firetoken;
}

String mainUrl = '***REMOVED***';

// EDITED TRIAL::::::::::::::
Future<void> deleteEntry(List<int>? idList) async {
  String userToken = await FirebaseAuth.instance.currentUser!.getIdToken();

  Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    "Authorization": 'Bearer ' + userToken,
  };

  for (int id in idList!) {
    http.Response response = await http
        .delete(Uri.parse(mainUrl + 'api/log/$id/'), headers: headers);
    if (response.statusCode == 204) {
      print(response.statusCode);
    } else {
      throw Exception('Failed to Delete');
    }
  }
}

Future<void> UpdateEntry(List<int>? idList) async {
  String userToken = await FirebaseAuth.instance.currentUser!.getIdToken();

  Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    "Authorization": 'Bearer ' + userToken,
  };

  for (int id in idList!) {
    http.Response response =
        await http.patch(Uri.parse(mainUrl + 'api/$id/'), headers: headers);
    if (response.statusCode == 200) {
      print(response.statusCode);
    } else {
      throw Exception('Failed to Update');
    }
  }
}

Future<TroutData> newCatch(TroutData myCatch) async {
  String userToken = await FirebaseAuth.instance.currentUser!.getIdToken();

  Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    "Authorization": 'Bearer ' + userToken,
  };
  var body = jsonEncode(myCatch.toJson());

  final response = await http.post(Uri.parse(mainUrl + 'api/create/'),
      headers: headers, body: body);
  if (response.statusCode == 201) {
    return TroutData.fromJson(jsonDecode(response.body));
  } else {
    print(response.statusCode);
    throw Exception('Failed to log new catch.');
  }
}

Future<List<TroutData>> fetchTroutData() async {
  String userToken = await FirebaseAuth.instance.currentUser!.getIdToken();

  Map<String, String> headers = {
    'Content-Type': 'application/json; UTF-8',
    'Accept': 'application/json',
    "Authorization": 'Bearer ' + userToken,
  };
  var response = await http.get(
    Uri.parse(mainUrl + "api/log/"),
    headers: headers,
  );

  if (response.statusCode == 200) {
    final List parsedList = jsonDecode(response.body);
    List<TroutData> troutdata =
        parsedList.map((val) => TroutData.fromJson(val)).toList();
    print('Token= ' + userToken);
    return troutdata;
  } else {
    print(response.statusCode);
    throw (Exception('error HERE'));
  }
}

class TroutData {
  String? user;
  int? id;
  DateTime date;
  String river;
  String river_pool;
  String fish_weight;
  // bool kept_or_released;
  String fish_species;
  String fish_condition;
  String fly_used;
  String? any_notes;

  TroutData({
    required this.user,
    this.id,
    required this.date,
    required this.river,
    required this.river_pool,
    required this.fish_weight,
    // required this.kept_or_released,
    required this.fish_species,
    required this.fish_condition,
    required this.fly_used,
    required this.any_notes,
  });

  bool thisoneselected = false;

  factory TroutData.fromJson(Map<String, dynamic> json) {
    return TroutData(
      user: json['user'],
      id: json['id'] as int,
      date: DateTime.parse(json['date']),
      river: json['river'],
      river_pool: json['river_pool'],
      fish_weight: json['fish_weight'],
      // kept_or_released : json['kept_or_released'],
      fish_species: json['fish_species'],
      fish_condition: json['fish_condition'],
      fly_used: json['fly_used'],
      any_notes: json['any_notes'],
    );
  }

  Map<String, dynamic> toJson() => {
        'user': user,
        'id': id,
        'date': date.toIso8601String(),
        'river': river,
        'river_pool': river_pool,
        // 'kept_or_released': kept_or_released,
        'fish_weight': fish_weight,
        'fly_used': fly_used,
        'any_notes': any_notes,
        'fish_species': fish_species,
        'fish_condition': fish_condition,
      };
}
