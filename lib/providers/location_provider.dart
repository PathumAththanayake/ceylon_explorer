import 'package:ceylon_explorer/models/location_model.dart';
import 'package:ceylon_explorer/providers/isar_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
 
final locationProvider =
    FutureProvider.family<Location?, int>((ref, locationId) async {
  final isar = await ref.watch(isarInstanceProvider.future);
  return await isar.locations.get(locationId);
}); 