import 'package:provider/provider.dart';

import '../../features/prayer/viewmodels/prayer_viewmodel.dart';
import '../../features/signin/viewmodels/signin_viewmodel.dart';
import '../../features/signup/viewmodels/signup_viewmodel.dart';
import '../services/service_locator.dart';

class AppProviders {
  static List<ChangeNotifierProvider> getProviders() {
    return [
      ChangeNotifierProvider(create: (_) => locator<PrayerViewModel>()),
      ChangeNotifierProvider(create: (_) => locator<SignupViewModel>()),
      ChangeNotifierProvider(create: (_) => locator<SigninViewModel>()),
    ];
  }
}
