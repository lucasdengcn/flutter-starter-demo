import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../features/image_picker/viewmodel/image_picker_viewmodel.dart';
import '../../features/prayer/viewmodel/prayer_viewmodel.dart';
import '../../features/signin/viewmodel/signin_viewmodel.dart';
import '../../features/signup/viewmodel/signup_viewmodel.dart';
import '../../screens/image_picker/image_picker_screen.dart';
import '../../screens/prayer/prayer_screen.dart';
import '../../screens/signin/signin_screen.dart';
import '../../screens/signup/signup_screen.dart';
import '../service/navigation_service.dart';
import '../service/service_locator.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/image_picker',
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
      GoRoute(
        path: '/image_picker',
        name: 'image_picker',
        builder:
            (context, state) => ChangeNotifierProvider(
              create: (_) => locator<ImagePickerViewModel>(),
              child: const ImagePickerScreen(),
            ),
      ),
    ],
  );
}
