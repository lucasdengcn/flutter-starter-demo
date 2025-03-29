import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../features/prayer/viewmodels/prayer_viewmodel.dart';
import '../../features/signin/viewmodels/signin_viewmodel.dart';
import '../../features/signup/viewmodels/signup_viewmodel.dart';
import '../../global/services/service_locator.dart';
import '../../screens/prayer/prayer_screen.dart';
import '../../screens/signin/signin_screen.dart';
import '../../screens/signup/signup_screen.dart';
import '../services/navigation_service.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/signin',
    navigatorKey: locator<NavigationService>().navigatorKey,
    routes: [
      GoRoute(
        path: '/signin',
        name: 'signin',
        builder:
            (context, state) => ChangeNotifierProvider(
              create: (_) => locator<SigninViewModel>(),
              child: const SigninScreen(),
            ),
      ),
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
