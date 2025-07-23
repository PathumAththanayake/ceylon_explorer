import 'package:ceylon_explorer/providers/trip_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class TripPlanScreen extends ConsumerWidget {
  const TripPlanScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trip = ref.watch(currentTripProvider);
    final tripNotifier = ref.read(currentTripProvider.notifier);
    final TextEditingController nameController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('My Current Trip (${trip?.locations.length ?? 0}/20)'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: trip == null
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: trip.locations.isEmpty
                      ? const Center(
                          child: Text(
                            'Add locations to your trip to see them here.',
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                        )
                      : ListView.builder(
                          itemCount: trip.locations.length,
                          itemBuilder: (context, index) {
                            final location = trip.locations.elementAt(index);
                            return ListTile(
                              leading: Image.asset(location.image, width: 80, fit: BoxFit.cover),
                              title: Text(location.name),
                              trailing: IconButton(
                                icon: const Icon(Icons.remove_circle, color: Colors.red),
                                onPressed: () {
                                  tripNotifier.removeLocation(location);
                                },
                              ),
                              onTap: () => context.go('/location/${location.id}'),
                            );
                          },
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: nameController,
                          decoration: const InputDecoration(
                            labelText: 'Trip Name',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          if (nameController.text.isNotEmpty) {
                            tripNotifier.saveTrip(nameController.text);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Trip "${nameController.text}" saved!')),
                            );
                            nameController.clear();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Please enter a name for your trip.')),
                            );
                          }
                        },
                        child: const Text('Save Trip'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
} 