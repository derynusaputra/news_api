import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:newsapi/models/api_user.dart';

class Repository {
  final _baseurl =
      'https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=93f00272d8b642f6acb03004e9f8f378';
  Future getData() async {
    try {
      final response = await http.get(Uri.parse(_baseurl));
      print(response.statusCode);
      if (response.statusCode == 200) {
        var it = jsonDecode(response.body) as Map<String, dynamic>;
        var user = ApiUser.fromJson(jsonDecode(response.body));
        // print(it);
        return user;
      } else {
        throw Exception('Failed to load ${response.statusCode}');
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
