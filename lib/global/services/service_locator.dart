import 'package:get_it/get_it.dart';
import 'package:insurance_ws/features/signup/viewmodels/signup_viewmodel.dart';

import '../../features/prayer/services/prayer_service.dart';
import '../../features/prayer/viewmodels/prayer_viewmodel.dart';
import '../../features/signup/services/auth_service.dart';

final GetIt locator = GetIt.instance;

Future<void> setupServiceLocator() async {
  try {
    // Register Services as Singletons
    locator.registerLazySingleton<AuthService>(() => AuthService());
    locator.registerLazySingleton<PrayerService>(() => PrayerService());

    // Register ViewModels as Factories
    locator.registerFactory<PrayerViewModel>(
      () => PrayerViewModel(prayerService: locator<PrayerService>()),
    );
    locator.registerFactory<SignupViewModel>(
      () => SignupViewModel(authService: locator<AuthService>()),
    );

    // Initialize Services if needed
    await locator<PrayerService>().init();
  } catch (e) {
    print('Error setting up service locator: $e');
    rethrow;
  }
  return;
}
