import 'package:go_router/go_router.dart';
import 'package:insurance_ws/features/charts/viewmodel/chart_viewmodel.dart';
import 'package:insurance_ws/features/chat/viewmodel/chat_viewmodel.dart';
import 'package:insurance_ws/screens/charts/chart_screen.dart';
import 'package:insurance_ws/screens/chat/chat_screen.dart';
import 'package:provider/provider.dart';

import '../../features/image_picker/viewmodel/image_picker_viewmodel.dart';
import '../../features/prayer/viewmodel/prayer_viewmodel.dart';
import '../../features/signin/viewmodel/signin_viewmodel.dart';
import '../../features/signup/viewmodel/signup_viewmodel.dart';
import '../../features/video_player/viewmodel/video_player_viewmodel.dart';
import '../../screens/image_picker/image_picker_screen.dart';
import '../../screens/prayer/prayer_screen.dart';
import '../../screens/signin/signin_screen.dart';
import '../../screens/signup/signup_screen.dart';
import '../../screens/video_player/video_player_screen.dart';
import '../service/navigation_service.dart';
import '../service/service_locator.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/chart',
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
      GoRoute(
        path: '/video_player',
        name: 'video_player',
        builder:
            (context, state) => ChangeNotifierProvider(
              create: (_) => locator<VideoPlayerViewModel>(),
              child: const VideoPlayerScreen(),
            ),
      ),
      GoRoute(
        path: '/chat',
        name: 'chat',
        builder:
            (context, state) => ChangeNotifierProvider(
              create: (_) => locator<ChatViewModel>(),
              child: const ChatScreen(
                userId: 'user123',
                wsUrl: 'ws://ws.example.com',
              ),
            ),
      ),
      GoRoute(
        path: '/chart',
        name: 'chart',
        builder:
            (context, state) => ChangeNotifierProvider(
              create: (_) => locator<ChartViewModel>(),
              child: const ChartScreen(),
            ),
      ),
    ],
  );
}
