import 'package:provider/provider.dart';

import '../../features/prayer/viewmodel/prayer_viewmodel.dart';
import '../../features/signin/viewmodel/signin_viewmodel.dart';
import '../../features/signup/viewmodel/signup_viewmodel.dart';
import '../service/service_locator.dart';

class AppProviders {
  static List<ChangeNotifierProvider> getProviders() {
    return [
      ChangeNotifierProvider(create: (_) => locator<PrayerViewModel>()),
      ChangeNotifierProvider(create: (_) => locator<SignupViewModel>()),
      ChangeNotifierProvider(create: (_) => locator<SigninViewModel>()),
    ];
  }
}
