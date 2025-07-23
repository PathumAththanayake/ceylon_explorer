import 'package:ceylon_explorer/models/location_model.dart';
import 'package:ceylon_explorer/providers/isar_provider.dart';
import 'package:ceylon_explorer/providers/location_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

// Provider to get a stream of favorite locations
final favoriteLocationsProvider = StreamProvider<List<Location>>((ref) {
  final isar = ref.watch(isarInstanceProvider).asData?.value;
  if (isar != null) {
    return isar.locations.where().isFavoriteEqualTo(true).watch(fireImmediately: true);
  }
  return Stream.value([]);
});

// Provider to expose favorite actions
final favoriteActionsProvider = Provider((ref) {
  final isar = ref.watch(isarInstanceProvider).asData?.value;
  return FavoriteActions(isar, ref);
});

class FavoriteActions {
  final Isar? _isar;
  final Ref _ref;

  FavoriteActions(this._isar, this._ref);

  Future<void> toggleFavorite(Location location) async {
    if (_isar == null) return;
    
    final newLocation = location..isFavorite = !location.isFavorite;
    
    await _isar!.writeTxn(() async {
      await _isar!.locations.put(newLocation);
    });
    // Invalidate providers to refresh UI
    _ref.invalidate(locationProvider(location.id));
    _ref.invalidate(favoriteLocationsProvider);
  }
} 