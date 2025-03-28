import 'package:go_router/go_router.dart';

import '../../screens/prayer/prayer_screen.dart';
import '../../screens/signup/signup_screen.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/signup',
    routes: [
      GoRoute(
        path: '/signup',
        name: 'signup',
        builder: (context, state) => const SignupScreen(),
      ),
      GoRoute(
        path: '/prayer',
        name: 'prayer',
        builder: (context, state) => const PrayerScreen(),
      ),
    ],
  );
}
