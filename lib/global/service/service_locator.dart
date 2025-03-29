import 'package:get_it/get_it.dart';

import '../../features/prayer/service/prayer_service.dart';
import '../../features/prayer/viewmodel/prayer_viewmodel.dart';
import '../../features/signin/service/signin_auth_service.dart';
import '../../features/signin/viewmodel/signin_viewmodel.dart';
import '../../features/signup/service/signup_auth_service.dart';
import '../../features/signup/viewmodel/signup_viewmodel.dart';
import 'navigation_service.dart';

final GetIt locator = GetIt.instance;

Future<void> setupServiceLocator() async {
  try {
    // Register Services as Singletons
    locator.registerLazySingleton<SignupAuthService>(() => SignupAuthService());
    locator.registerLazySingleton<SigninAuthService>(() => SigninAuthService());
    locator.registerLazySingleton<PrayerService>(() => PrayerService());
    locator.registerLazySingleton<NavigationService>(() => NavigationService());

    // Register ViewModels as Factories
    locator.registerFactory<PrayerViewModel>(
      () => PrayerViewModel(prayerService: locator<PrayerService>()),
    );
    locator.registerFactory<SignupViewModel>(
      () => SignupViewModel(
        authService: locator<SignupAuthService>(),
        navigationService: locator<NavigationService>(),
      ),
    );
    locator.registerFactory<SigninViewModel>(
      () => SigninViewModel(
        authService: locator<SigninAuthService>(),
        navigationService: locator<NavigationService>(),
      ),
    );

    // Initialize Services if needed
    await locator<PrayerService>().init();
  } catch (e) {
    print('Error setting up service locator: $e');
    rethrow;
  }
  return;
}
