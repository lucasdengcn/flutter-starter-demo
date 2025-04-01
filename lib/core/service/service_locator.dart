import 'package:get_it/get_it.dart';

import '../../features/article/service/article_service.dart';
import '../../features/article/viewmodel/article_viewmodel.dart';
import '../../features/cart/service/cart_service.dart';
import '../../features/cart/viewmodel/cart_viewmodel.dart';
import '../../features/charts/service/chart_service.dart';
import '../../features/charts/viewmodel/chart_viewmodel.dart';
import '../../features/image_picker/service/image_service.dart';
import '../../features/image_picker/viewmodel/image_picker_viewmodel.dart';
import '../../features/order/service/order_service.dart';
import '../../features/order/viewmodel/order_viewmodel.dart';
import '../../features/pdf_viewer/service/pdf_service.dart';
import '../../features/pdf_viewer/viewmodel/pdf_viewer_viewmodel.dart';
import '../../features/prayer/service/content_recommendation_service.dart';
import '../../features/prayer/service/prayer_service.dart';
import '../../features/prayer/viewmodel/prayer_viewmodel.dart';
import '../../features/product/service/product_service.dart';
import '../../features/product/viewmodel/product_viewmodel.dart';
import '../../features/signin/service/signin_auth_service.dart';
import '../../features/signin/viewmodel/signin_viewmodel.dart';
import '../../features/signup/service/signup_auth_service.dart';
import '../../features/signup/viewmodel/signup_viewmodel.dart';
import '../../features/video_player/viewmodel/video_player_viewmodel.dart';
import '../providers/theme_provider.dart';
import 'api_client.dart';
import 'cache_service.dart';
import 'config_service.dart';
import 'encryption_service.dart';
import 'logger_service.dart';
import 'navigation_service.dart';
import 'secure_storage_service.dart';
import 'token_storage.dart';

final GetIt locator = GetIt.instance;

Future<void> setupServiceLocator() async {
  try {
    locator.registerLazySingleton<ImageService>(() => ImageService());
    // Register Services as Singletons
    locator.registerLazySingleton<LoggerService>(() => LoggerService());
    locator.registerLazySingleton<ConfigService>(() => ConfigService());
    locator.registerLazySingleton<NavigationService>(() => NavigationService());
    locator.registerLazySingleton<ApiClient>(() => ApiClient());
    locator.registerLazySingleton<TokenStorage>(() => TokenStorage());
    locator.registerLazySingleton<SecureStorageService>(
      () => SecureStorageService(),
    );
    locator.registerLazySingleton<CacheService>(() => CacheService());
    locator.registerLazySingleton<EncryptionService>(() => EncryptionService());
    locator.registerLazySingleton<SignupAuthService>(() => SignupAuthService());
    locator.registerLazySingleton<SigninAuthService>(() => SigninAuthService());
    locator.registerLazySingleton<ArticleService>(() => ArticleService());
    locator.registerLazySingleton<ChartService>(() => ChartService());
    locator.registerLazySingleton<PdfService>(() => PdfService());
    // Initialize ConfigService
    locator<ConfigService>();

    // Register Providers
    locator.registerLazySingleton<ThemeProvider>(() => ThemeProvider());

    // Register ViewModels as Factories
    locator.registerLazySingleton<PrayerService>(() => PrayerService());
    locator.registerLazySingleton<ContentRecommendationService>(
      () => ContentRecommendationService(),
    );
    locator.registerFactory<PrayerViewModel>(
      () => PrayerViewModel(
        prayerService: locator<PrayerService>(),
        contentService: locator<ContentRecommendationService>(),
      ),
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
    locator.registerFactory<ImagePickerViewModel>(
      () => ImagePickerViewModel(locator<ImageService>()),
    );
    locator.registerFactory(() => VideoPlayerViewModel());
    locator.registerFactory<ArticleViewModel>(
      () => ArticleViewModel(articleService: locator<ArticleService>()),
    );
    locator.registerFactory<ChartViewModel>(
      () => ChartViewModel(chartService: locator<ChartService>()),
    );
    locator.registerFactory<PdfViewerViewModel>(() => PdfViewerViewModel());

    // Register Product related dependencies
    locator.registerLazySingleton<ProductService>(() => ProductService());
    locator.registerFactory<ProductViewModel>(() => ProductViewModel());

    // Register Cart related dependencies
    locator.registerLazySingleton<CartService>(
      () => CartService(locator<ProductService>()),
    );
    locator.registerFactory<CartViewModel>(() => CartViewModel());

    // Register Order related dependencies
    locator.registerLazySingleton<OrderService>(() => OrderService());
    locator.registerFactory<OrderViewModel>(() => OrderViewModel());

    // Initialize Services if needed
    await locator<PrayerService>().init();
  } catch (e) {
    print('Error setting up service locator: $e');
    rethrow;
  }
  return;
}
