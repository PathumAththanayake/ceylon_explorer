import 'package:ceylon_explorer/isar_db/isar_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

final isarProvider = Provider<IsarService>((ref) {
  return IsarService();
});

final isarInstanceProvider = FutureProvider<Isar>((ref) async {
  return await ref.watch(isarProvider).db;
}); 