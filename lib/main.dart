import 'package:audio_session/audio_session.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

import 'core/providers/providers.dart';
import 'core/providers/theme_provider.dart';
import 'core/routes/app_router.dart';
import 'core/service/service_locator.dart';

Future<void> main() async {
  // Load .env file (this file is copied from environment-specific .env files during build)
  await dotenv.load(fileName: '.env');
  // Initialize audio session
  WidgetsFlutterBinding.ensureInitialized();
  final session = await AudioSession.instance;
  await session.configure(const AudioSessionConfiguration.music());
  // Setup service locator
  setupServiceLocator();
  //
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ...AppProviders.getProviders(), // Include existing providers
      ],
      child: Consumer<ThemeProvider>(
        builder:
            (context, themeProvider, child) => MaterialApp.router(
              title: 'Ibadah',
              debugShowCheckedModeBanner: false,
              theme: themeProvider.currentTheme,
              routerConfig: AppRouter.router,
            ),
      ),
    );
  }
}
