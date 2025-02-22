import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/location_model.dart';
import '../models/province_model.dart';

class DBHelper {
  static Future<List<ProvinceModel>> loadProvinces() async {
    final String response = await rootBundle.loadString('assets/data/sample_data.json');
    final data = json.decode(response) as List;
    return data.map((e) => ProvinceModel.fromJson(e)).toList();
  }

  static Future<List<LocationModel>> loadLocations(String provinceName) async {
    final String response = await rootBundle.loadString('assets/data/sample_data.json');
    final data = json.decode(response) as List;
    final province = data.firstWhere((e) => e['name'] == provinceName);
    final locations = province['locations'] as List;
    return locations.map((e) => LocationModel.fromJson(e)).toList();
  }
}
