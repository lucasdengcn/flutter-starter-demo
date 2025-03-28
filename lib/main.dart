import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'features/prayer/viewmodels/prayer_viewmodel.dart';
import 'features/signup/viewmodels/signup_viewmodel.dart';
import 'global/routes/app_router.dart';
import 'global/services/service_locator.dart';

void main() {
  setupServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => locator<PrayerViewModel>()),
        ChangeNotifierProvider(create: (_) => SignupViewModel()),
      ],
      child: MaterialApp.router(
        title: 'Ibadah',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        routerConfig: AppRouter.router,
      ),
    );
  }
}
