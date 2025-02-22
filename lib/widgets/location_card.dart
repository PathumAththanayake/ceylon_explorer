import 'package:flutter/material.dart';
import '../models/location_model.dart';
import '../screens/location_details_screen.dart';

class LocationCard extends StatelessWidget {
  final LocationModel location;

  const LocationCard({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: ListTile(
        contentPadding: EdgeInsets.all(8.0),
        leading: Image.asset(location.image, width: 50, height: 50, fit: BoxFit.cover),
        title: Text(location.name),
        subtitle: Text(location.description),
        onTap: () {
          // Navigate to LocationDetailsScreen when tapped
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => LocationDetailsScreen(location: location),
            ),
          );
        },
      ),
    );
  }
}
