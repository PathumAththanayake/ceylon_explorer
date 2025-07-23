import 'package:isar/isar.dart';
import 'package:ceylon_explorer/models/location_model.dart';

part 'province_model.g.dart';

@collection
class Province {
  Id id = Isar.autoIncrement;

  late String name;
  
  late String description;

  late String image;

  final locations = IsarLinks<Location>();
}
