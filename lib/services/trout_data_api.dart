import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';


Future<List<TroutData>> fetchTroutData() async {
  var response = await http.get(Uri.parse('http://127.0.0.1:8000/api/'),
  // headers: {

  // }
  );
  
  final List parsedList = jsonDecode(response.body);
  List<TroutData> troutdata = parsedList.map((val) => TroutData.fromJson(val)).toList();
  return troutdata;
}



class TroutData {
  String dateAndTime;
  String river;
  String river_pool;
  String fish_weight;
  // Bool kept_or_released;
  String fish_species;
  String fish_condition;
  String fly_used;
  String any_notes;

  TroutData({
    required this.dateAndTime,
    required this.river,
    required this.river_pool,
    required this.fish_weight,
    // required this.kept_or_released,
    required this.fish_species,
    required this.fish_condition,
    required this.fly_used,
    required this.any_notes,
  });
  factory TroutData.fromJson(Map<String, dynamic> json) {
    return TroutData(
      dateAndTime : json['dateAndTime'],
      river : json['river'],
      river_pool : json['river_pool'],
      fish_weight : json['fish_weight'] as String,
      // kept_or_released : json['kept_or_released'],
      fish_species : json['fish_species'],
      fish_condition : json['fish_condition'],
      fly_used : json['fly_used'],
      any_notes : json['any_notes'],
    );
  }
  // Map<String, dynamic>toJson() =>
  //   {'river': river, 'fish_species': fish_species, 'fish_condition': fish_condition};
}
