import 'location_model.dart';

class ProvinceModel {
  final String name;
  final String image;
  final List<LocationModel> locations;

  ProvinceModel({
    required this.name,
    required this.image,
    required this.locations,
  });

  factory ProvinceModel.fromJson(Map<String, dynamic> json) {
    var locationsList = (json['locations'] as List)
        .map((location) => LocationModel.fromJson(location))
        .toList();

    return ProvinceModel(
      name: json['name'],
      image: json['image'],
      locations: locationsList,
    );
  }
}
