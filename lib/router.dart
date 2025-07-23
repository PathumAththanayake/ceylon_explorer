import 'package:ceylon_explorer/screens/favorites_screen.dart';
import 'package:ceylon_explorer/screens/home_screen.dart';
import 'package:ceylon_explorer/screens/location_details_screen.dart';
import 'package:ceylon_explorer/screens/trip_plan_screen.dart';
import 'package:ceylon_explorer/screens/onboarding_screen.dart';
import 'package:ceylon_explorer/screens/splash_screen.dart';
import 'package:ceylon_explorer/screens/register_screen.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      builder: (context, state) => SplashScreen(),
    ),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => OnboardingScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/',
      builder: (context, state) => HomeScreen(),
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