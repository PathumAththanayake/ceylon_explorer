import 'package:flutter/material.dart';
import '../models/location_model.dart';
import '../widgets/location_card.dart';

class FavoritesScreen extends StatelessWidget {
  final List<LocationModel> favoriteLocations = [
    // Dummy data for favorites, replace with real data
    LocationModel(
      name: "Colombo",
      description: "The commercial capital of Sri Lanka.",
      image: "assets/images/location_images/colombo.jpg",
    ),
  ];

  FavoritesScreen({super.key}); // Removed const from here

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Favorite Locations")),
      body: ListView.builder(
        itemCount: favoriteLocations.length,
        itemBuilder: (context, index) {
          return LocationCard(location: favoriteLocations[index]);
        },
      ),
    );
  }
}
