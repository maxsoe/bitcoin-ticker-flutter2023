import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NetworkHelper {
  NetworkHelper(this.url);
  final String url;

  Future getData() async {
    Uri parsedURL = Uri.parse(url);
    debugPrint('parsed URL is $parsedURL');
    http.Response response = await http.get(parsedURL);
    // print(response.body);
    int responseCode = response.statusCode;
    if (responseCode == 200) {
      String data = response.body;
      var decodedData = jsonDecode(data);
      return decodedData;
    } else {
      debugPrint('Response code: ${responseCode.toString()}');
    }
  }
}
