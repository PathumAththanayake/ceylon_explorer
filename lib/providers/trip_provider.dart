import 'package:ceylon_explorer/models/location_model.dart';
import 'package:ceylon_explorer/models/trip_plan_model.dart';
import 'package:ceylon_explorer/providers/isar_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

// This provider holds the state of the trip plan currently being built.
final currentTripProvider = StateNotifierProvider<TripNotifier, TripPlan?>((ref) {
  final isar = ref.watch(isarInstanceProvider).asData?.value;
  return TripNotifier(isar, ref);
});


class TripNotifier extends StateNotifier<TripPlan?> {
  final Isar? _isar;
  final Ref _ref;

  TripNotifier(this._isar, this._ref) : super(null) {
    _loadOrCreateDraftTrip();
  }

  // Load the latest un-named trip as the draft, or create a new one.
  Future<void> _loadOrCreateDraftTrip() async {
    if (_isar == null) return;
    final draftTrip = await _isar!.tripPlans.where().filter().nameEqualTo("").findFirst();
    if (draftTrip != null) {
      await draftTrip.locations.load();
      state = draftTrip;
    } else {
      final newTrip = TripPlan()
        ..name = "" // Drafts have no name
        ..creationDate = DateTime.now();
      await _isar!.writeTxn(() async => await _isar!.tripPlans.put(newTrip));
      state = newTrip;
    }
  }

  Future<void> addLocation(Location location) async {
    if (_isar == null || state == null) return;
    if (state!.locations.length >= 20) {
      // Handle the 20-location limit
      print("Cannot add more than 20 locations to a trip.");
      return;
    }

    if (state!.locations.contains(location)) return; // Already in the trip

    state!.locations.add(location);
    await _isar!.writeTxn(() async => await state!.locations.save());
    _ref.invalidate(currentTripProvider); // Re-fetch to update UI
  }

  Future<void> removeLocation(Location location) async {
    if (_isar == null || state == null) return;

    state!.locations.remove(location);
    await _isar!.writeTxn(() async => await state!.locations.save());
    _ref.invalidate(currentTripProvider);
  }

  bool isLocationInCurrentTrip(Location location) {
    return state?.locations.contains(location) ?? false;
  }

  Future<void> saveTrip(String name) async {
    if (_isar == null || state == null) return;

    final finalTrip = state!..name = name;
    await _isar!.writeTxn(() async {
      await _isar!.tripPlans.put(finalTrip);
    });

    // Create a new draft for the next session
    _loadOrCreateDraftTrip();
  }
} 