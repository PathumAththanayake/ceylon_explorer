import 'package:ceylon_explorer/models/location_model.dart';
import 'package:ceylon_explorer/models/province_model.dart';
import 'package:ceylon_explorer/providers/province_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

// Provider to track the index of the currently displayed province
final currentPageProvider = StateProvider<int>((ref) => 0);

// Provider to get the currently selected province object
final currentProvinceProvider = Provider<Province?>((ref) {
  final provinces = ref.watch(provinceProvider).asData?.value;
  final currentIndex = ref.watch(currentPageProvider);
  if (provinces != null && provinces.isNotEmpty) {
    return provinces[currentIndex];
  }
  return null;
});

// Provider to fetch locations for the current province
final locationsForProvinceProvider = FutureProvider<List<Location>>((ref) async {
  final province = ref.watch(currentProvinceProvider);
  if (province != null) {
    // IsarLinks are lazy-loaded, so we need to explicitly load them.
    await province.locations.load();
    return province.locations.toList();
  }
  return [];
});


class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provincesAsyncValue = ref.watch(provinceProvider);
    final pageController = PageController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Explore Provinces'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              context.go('/favorites');
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          context.go('/trip');
        },
        label: const Text("My Trip"),
        icon: const Icon(Icons.map),
      ),
      body: provincesAsyncValue.when(
        data: (provinces) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Horizontal PageView for Provinces
              SizedBox(
                height: 250,
                child: PageView.builder(
                  controller: pageController,
                  itemCount: provinces.length,
                  onPageChanged: (index) {
                    ref.read(currentPageProvider.notifier).state = index;
                  },
                  itemBuilder: (context, index) {
                    final province = provinces[index];
                    return Card(
                      margin: const EdgeInsets.all(10),
                      clipBehavior: Clip.antiAlias,
                      elevation: 5,
                      child: Stack(
                        children: [
                          Image.asset(
                            province.image,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                          Container(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Colors.black54, Colors.transparent],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 20,
                            left: 20,
                            child: Text(
                              province.name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "Locations",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              // Vertical ListView for Locations
              Expanded(
                child: ref.watch(locationsForProvinceProvider).when(
                      data: (locations) {
                        if (locations.isEmpty) {
                          return const Center(child: Text("No locations found."));
                        }
                        return ListView.builder(
                          itemCount: locations.length,
                          itemBuilder: (context, index) {
                            final location = locations[index];
                            return InkWell(
                              onTap: () {
                                context.go('/location/${location.id}');
                              },
                              child: ListTile(
                                leading: Image.asset(
                                  location.image,
                                  width: 80,
                                  fit: BoxFit.cover,
                                ),
                                title: Text(location.name),
                                subtitle: Text(
                                  location.description,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            );
                          },
                        );
                      },
                      loading: () =>
                          const Center(child: CircularProgressIndicator()),
                      error: (err, stack) =>
                          Center(child: Text('Error: $err')),
                    ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
} 