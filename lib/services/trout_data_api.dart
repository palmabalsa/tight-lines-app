import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';


Future<TroutData> fetchTroutData() async {
  var response = await http.get(Uri.parse('http://127.0.0.1:8000/api/'));
  TroutData troutData = TroutData.fromJson(jsonDecode(response.body)[0]);
  print(troutData.river);
  print(troutData.fish_species);
  print(troutData.fish_condition);
  return troutData;
}

class TroutData {
  String river;
  String fish_species;
  String fish_condition;

  TroutData({
    required this.river,
    required this.fish_species,
    required this.fish_condition,
  });
  factory TroutData.fromJson(Map<String, dynamic> json) {
    return TroutData(
      river : json['river'],
      fish_species : json['fish_species'],
      fish_condition : json['fish_condition'],
    );
  }
  Map<String, dynamic>toJson() =>
    {'river': river, 'fish_species': fish_species, 'fish_condition': fish_condition};
}
