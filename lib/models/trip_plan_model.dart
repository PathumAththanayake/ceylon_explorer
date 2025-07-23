import 'package:isar/isar.dart';
import 'package:ceylon_explorer/models/location_model.dart';

part 'trip_plan_model.g.dart';

@collection
class TripPlan {
  Id id = Isar.autoIncrement;

  late String name;
  
  late DateTime creationDate;

  final locations = IsarLinks<Location>();
} 