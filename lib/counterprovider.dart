import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class CounterProvider extends ChangeNotifier {

  var result;

  void callapi() async {
    var url = 'https://jsonplaceholder.typicode.com/posts';
    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url);
    if (response.statusCode == 200) {
      result = json.decode(response.body);
    } else {
      print("error api call");
    }
    notifyListeners();
  }
}
