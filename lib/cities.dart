import 'dart:convert';
import 'package:flutter/services.dart';

// ignore: camel_case_types
class cities{
  String id;
  String city;
  String state;

  cities({
    this.id,
    this.city,
    this.state
});
  factory cities.fromJson(Map<String,dynamic> parsedJson){
    return cities(
      id: parsedJson['id'] as String,
      city: parsedJson['city'] as String,
      state: parsedJson['state'] as String
    );
  }
}

class CityView {
  static List<cities> Cities;
  static List<String> CityName;

  static Future loadcities() async {
    try {
      CityName = new List<String>();
      Cities = new List<cities>();
      String jsonString = await rootBundle.loadString('assets/cities.json');
      Map parsedJson = json.decode(jsonString);
      var categoryJson = parsedJson['cities'] as List;
      for (int i = 0; i < categoryJson.length; i++) {
        CityName.add(categoryJson[i]['name']);
      }
    } catch (e) {
      print(e);
    }
  }
}
