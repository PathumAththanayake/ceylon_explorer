import 'package:ceylon_explorer/models/province_model.dart';
import 'package:ceylon_explorer/models/trip_plan_model.dart';
import 'package:isar/isar.dart';

part 'location_model.g.dart';

@collection
class Location {
  Id id = Isar.autoIncrement;

  late String name;
  late String description;
  late String image;

  @Index()
  bool isFavorite = false;

  @Backlink(to: "locations")
  final province = IsarLink<Province>();

  @Backlink(to: "locations")
  final tripPlans = IsarLinks<TripPlan>();
}
