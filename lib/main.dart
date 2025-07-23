import 'package:ceylon_explorer/isar_db/data_seeder.dart';
import 'package:ceylon_explorer/isar_db/isar_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ceylon_explorer/screens/home_screen.dart';
import 'package:ceylon_explorer/router.dart';
import 'package:ceylon_explorer/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Isar Service
  final isarService = IsarService();
  final isar = await isarService.db;
  await DataSeeder(isar).loadData();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      title: 'Ceylon Explorer',
      theme: ThemeData(
        primarySwatch: Colors.green,
        // Banana leaf color scheme
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4B6F45), // Banana Leaf Green
          primary: const Color(0xFF4B6F45),
          secondary: const Color(0xFFE8DE6D), // Banana Yellow
        ),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
