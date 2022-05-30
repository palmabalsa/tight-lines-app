import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';


// DELETE REQUEST : // CRUD (DELETE) -TAKES INPUT #ID for the item to delete
Future<http.Response> deleteEntry(String id) async{
  var response = await http.delete(Uri.parse('http://127.0.0.1:8000/api/$id'),
  headers: <String, String> {
    'Content-Type': 'application/json; charset=UTF-8',
  },);
  if (response.statusCode == 200) {
    return response;
  } else {
    throw Exception('Failed to Delete');
  }
}






//TO DO ==== WRITE THIS ONE:
// PUT/PATCH REQUEST : //CRUD(Update) // EDIT AN ENTRY








// POST REQUEST:  //CRUD (CREATE)
Future<TroutData> newCatch(TroutData myCatch) async{
  Map<String, String> headers = {'Content-Type': 'application/json'};
  var body = jsonEncode(myCatch.toJson());

  final response = await http.post(Uri.parse('http://127.0.0.1:8000/api/create/'),
  headers: headers,
  body: body);
    if (response.statusCode == 201) {
    return TroutData.fromJson(jsonDecode(response.body));
  } else {
    print(response.statusCode);
    throw Exception('Failed to log new catch.');
  } 
}

// GET REQUEST:   // CRUD (READ)
Future<List<TroutData>> fetchTroutData() async {
  var response = await http.get(Uri.parse('http://127.0.0.1:8000/api/'));
  final List parsedList = jsonDecode(response.body);
  List<TroutData> troutdata = parsedList.map((val) => TroutData.fromJson(val)).toList();
  return troutdata;
}



class TroutData {
  // String dateAndTime;
  // String? river;
  String river_pool;
  // String fish_weight;
  // bool kept_or_released;
  // String? fish_species;
  // String? fish_condition;
  String fly_used;
  String any_notes;

  TroutData({
    // required this.dateAndTime,
    // required this.river,
    required this.river_pool,
    // required this.fish_weight,
    // required this.kept_or_released,
    // required this.fish_species,
    // required this.fish_condition,
    required this.fly_used,
    required this.any_notes,
  });
  factory TroutData.fromJson(Map<String, dynamic> json) {
    return TroutData(
      // dateAndTime : json['dateAndTime'],
      // river : json['river'],
      river_pool : json['river_pool'],
      // fish_weight : json['fish_weight'],
      // kept_or_released : json['kept_or_released'],
      // fish_species : json['fish_species'],
      // fish_condition : json['fish_condition'],
      fly_used : json['fly_used'],
      any_notes : json['any_notes'],
    );
  }

   Map<String, dynamic> toJson() =>
    {
      // 'river': river,
      'river_pool': river_pool, 
      // 'kept_or_released': kept_or_released, 
      // 'fish_weight' : fish_weight,
      'fly_used': fly_used, 
      'any_notes': any_notes,
      // 'fish_species' : fish_species,
      // 'fish_condition' : fish_condition,
    };
}



// PAGINATED DATATABLE:
// class sourceData extends DataTableSource {

//   @override
//   bool get isRowCountApproximate => false;
//   @override
//   int get rowCount => data.length;
//   @override
//   int get selectedRowCount => 0;
//   @override
//   DataRow getRow(int index) {
//     return DataRow(cells: [
//       DataCell(Text(data[index]['river_pool'])),
//       DataCell(Text(data[index]['fly_used'])),
//       DataCell(Text(data[index]['any_notes'])),
//     ]);
//   }
// }
