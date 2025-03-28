import 'package:go_router/go_router.dart';
import 'package:insurance_ws/features/prayer/viewmodels/prayer_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../features/signup/viewmodels/signup_viewmodel.dart';
import '../../global/services/service_locator.dart';
import '../../screens/prayer/prayer_screen.dart';
import '../../screens/signup/signup_screen.dart';
import '../services/navigation_service.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/signup',
    navigatorKey: locator<NavigationService>().navigatorKey,
    routes: [
      GoRoute(
        path: '/signup',
        name: 'signup',
        builder:
            (context, state) => ChangeNotifierProvider(
              create: (_) => locator<SignupViewModel>(),
              child: const SignupScreen(),
            ),
      ),
      GoRoute(
        path: '/prayer',
        name: 'prayer',
        builder:
            (context, state) => ChangeNotifierProvider(
              create: (_) => locator<PrayerViewModel>(),
              child: const PrayerScreen(),
            ),
      ),
    ],
  );
}
