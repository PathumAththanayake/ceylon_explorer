import 'package:flutter/material.dart';
import '../models/location_model.dart';
import '../widgets/location_card.dart';



class TripPlansScreen extends StatelessWidget {
  final List<LocationModel> tripLocations = [
    // Dummy data for trip plans, replace with real data
    LocationModel(name: "Nuwara Eliya", description: "Known for its cool climate and tea plantations.", image: "assets/images/location_images/nuwara_eliya.jpg")
  ];

   TripPlansScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Trip Plans")),
      body: ListView.builder(
        itemCount: tripLocations.length,
        itemBuilder: (context, index) {
          return LocationCard(location: tripLocations[index]);
        },
      ),
    );
  }
}
