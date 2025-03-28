import 'package:get_it/get_it.dart';

import '../../features/prayer/services/prayer_service.dart';
import '../../features/prayer/viewmodels/prayer_viewmodel.dart';

final GetIt locator = GetIt.instance;

Future<void> setupServiceLocator() async {
  try {
    // Register Services as Singletons
    locator.registerLazySingleton<PrayerService>(() => PrayerService());

    // Register ViewModels as Factories
    locator.registerFactory<PrayerViewModel>(
      () => PrayerViewModel(prayerService: locator<PrayerService>()),
    );

    // Initialize Services if needed
    await locator<PrayerService>().init();
  } catch (e) {
    print('Error setting up service locator: $e');
    rethrow;
  }
  return;
}
