import 'dart:convert';
import 'package:ceylon_explorer/models/location_model.dart';
import 'package:ceylon_explorer/models/province_model.dart';
import 'package:flutter/services.dart';
import 'package:isar/isar.dart';

class DataSeeder {
  final Isar isar;

  DataSeeder(this.isar);

  Future<void> loadData() async {
    final count = await isar.provinces.count();
    if (count == 0) {
      final String jsonContent =
          await rootBundle.loadString('lib/data/sample_data.json');
      final jsonData = json.decode(jsonContent);

      final provincesData = jsonData['provinces'] as List;
      List<Province> provinces = [];
      List<Location> locations = [];

      for (var provinceData in provincesData) {
        var province = Province()
          ..name = provinceData['name']
          ..description = provinceData['description']
          ..image = provinceData['image'];
        provinces.add(province);

        final locationsData = provinceData['locations'] as List;
        for (var locationData in locationsData) {
          var location = Location()
            ..name = locationData['name']
            ..description = locationData['description']
            ..image = locationData['image']
            ..province.value = province;
          locations.add(location);
        }
      }

      await isar.writeTxn(() async {
        await isar.provinces.putAll(provinces);
        await isar.locations.putAll(locations);
        
        for (var p in provinces) {
            await p.locations.save();
        }
      });
    }
  }
} 