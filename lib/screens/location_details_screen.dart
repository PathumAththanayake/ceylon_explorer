import 'package:flutter/material.dart';
import '../models/location_model.dart';

class LocationDetailsScreen extends StatelessWidget {
  final LocationModel location;

  // Constructor to receive the LocationModel object
  const LocationDetailsScreen({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(location.name)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Assuming the image is stored locally in assets
          Image.asset(location.image),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(location.name, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(location.description),
          ),
        ],
      ),
    );
  }
}
