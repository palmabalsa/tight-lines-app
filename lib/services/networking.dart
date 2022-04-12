import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ttlines2/views/loading_screen.dart';



class NetworkHelper {
  
  String url;
  NetworkHelper(this.url);

  Future getData() async {
    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      // is this the right thing to write?
      var data = jsonDecode(response.body);
      return data;

    } else {
      print (response.statusCode);
      return Exception('Network request failed');
    }
  }
}


// to use this network helper class, you just plug in your networking url and code and it should work
//