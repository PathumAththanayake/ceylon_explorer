import 'package:ceylon_explorer/screens/favorites_screen.dart';
import 'package:ceylon_explorer/screens/home_screen.dart';
import 'package:ceylon_explorer/screens/location_details_screen.dart';
import 'package:ceylon_explorer/screens/trip_plan_screen.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/favorites',
      builder: (context, state) => const FavoritesScreen(),
    ),
    GoRoute(
      path: '/trip',
      builder: (context, state) => const TripPlanScreen(),
    ),
    GoRoute(
      path: '/location/:id',
      builder: (context, state) {
        final locationId = int.parse(state.params['id']!);
        return LocationDetailsScreen(locationId: locationId);
      },
    ),
  ],
); 