class LocationModel  {
  final String name;
  final String image;
  final String description;

  LocationModel ({required this.name, required this.image, required this.description});

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel (
      name: json['name'],
      image: json['image'],
      description: json['description'],
    );
  }

}
