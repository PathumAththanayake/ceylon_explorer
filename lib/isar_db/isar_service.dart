import 'package:ceylon_explorer/models/location_model.dart';
import 'package:ceylon_explorer/models/province_model.dart';
import 'package:ceylon_explorer/models/trip_plan_model.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class IsarService {
  late Future<Isar> db;

  IsarService() {
    db = openDB();
  }

  Future<Isar> openDB() async {
    if (Isar.instanceNames.isEmpty) {
      final dir = await getApplicationDocumentsDirectory();
      return await Isar.open(
        [ProvinceSchema, LocationSchema, TripPlanSchema],
        directory: dir.path,
        inspector: true,
      );
    }

    return Future.value(Isar.getInstance());
  }
} 