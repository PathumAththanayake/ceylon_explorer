import 'package:flutter/material.dart';
import 'location_details_screen.dart';
import '../models/location_model.dart';

class ProvinceScreen extends StatelessWidget {
  final List<LocationModel> tripLocations = [
    // Add some sample locations
    LocationModel(
      name: "Nuwara Eliya",
      description: "Known for its cool climate and tea plantations.",
      image: "assets/images/location_images/nuwara_eliya.jpg",
    ),
    // Add more LocationModel objects here
  ];

   ProvinceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Choose a Location')),
      body: ListView.builder(
        itemCount: tripLocations.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(tripLocations[index].name),
            onTap: () {
              // Navigate to LocationDetailsScreen and pass the LocationModel
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => LocationDetailsScreen(location: tripLocations[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
