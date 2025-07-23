import 'package:ceylon_explorer/models/province_model.dart';
import 'package:ceylon_explorer/providers/isar_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

final provinceProvider = FutureProvider<List<Province>>((ref) async {
  final isar = await ref.watch(isarInstanceProvider.future);
  return await isar.provinces.where().findAll();
}); 