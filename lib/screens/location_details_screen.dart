import 'package:ceylon_explorer/providers/favorites_provider.dart';
import 'package:ceylon_explorer/providers/location_provider.dart';
import 'package:ceylon_explorer/providers/trip_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationDetailsScreen extends ConsumerWidget {
  final int locationId;

  const LocationDetailsScreen({super.key, required this.locationId});

  Future<bool> _isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locationAsyncValue = ref.watch(locationProvider(locationId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Location Details'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: locationAsyncValue.when(
        data: (location) {
          if (location == null) {
            return const Center(child: Text("Location not found."));
          }
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  location.image,
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        location.name,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        location.description,
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Consumer(
                            builder: (context, ref, child) {
                              final tripNotifier = ref.read(currentTripProvider.notifier);
                              final isInTrip = tripNotifier.isLocationInCurrentTrip(location);

                              return ElevatedButton.icon(
                                onPressed: () async {
                                  final loggedIn = await _isLoggedIn();
                                  if (!loggedIn) {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: const Text('Login Required'),
                                        content: const Text('Please login to use this feature.'),
                                        actions: [
                                          TextButton(
                                            onPressed: () => Navigator.of(context).pop(),
                                            child: const Text('OK'),
                                          ),
                                        ],
                                      ),
                                    );
                                    return;
                                  }
                                  if (isInTrip) {
                                    tripNotifier.removeLocation(location);
                                  } else {
                                    final trip = ref.read(currentTripProvider);
                                    if(trip != null && trip.locations.length >= 20){
                                       ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text("You can only add up to 20 locations per trip.")),
                                      );
                                    }else {
                                      tripNotifier.addLocation(location);
                                    }
                                  }
                                },
                                icon: Icon(
                                  isInTrip ? Icons.remove_circle_outline : Icons.add_location_alt,
                                ),
                                label: Text(isInTrip ? "Remove from Trip" : "Add to Trip"),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: isInTrip ? Colors.red.shade300 : Theme.of(context).colorScheme.primary,
                                ),
                              );
                            },
                          ),
                          IconButton(
                            onPressed: () async {
                              final loggedIn = await _isLoggedIn();
                              if (!loggedIn) {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text('Login Required'),
                                    content: const Text('Please login to use this feature.'),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.of(context).pop(),
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  ),
                                );
                                return;
                              }
                              ref.read(favoriteActionsProvider).toggleFavorite(location);
                            },
                            icon: Icon(
                              location.isFavorite ? Icons.favorite : Icons.favorite_border,
                            ),
                            iconSize: 30,
                            color: Colors.red,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
} 