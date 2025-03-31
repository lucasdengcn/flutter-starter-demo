import 'package:insurance_ws/features/charts/viewmodel/chart_viewmodel.dart';
import 'package:insurance_ws/features/chat/viewmodel/chat_viewmodel.dart';
import 'package:insurance_ws/features/video_player/viewmodel/video_player_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../features/article/viewmodel/article_viewmodel.dart';
import '../../features/image_picker/viewmodel/image_picker_viewmodel.dart';
import '../../features/pdf_viewer/viewmodel/pdf_viewer_viewmodel.dart';
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
      ChangeNotifierProvider(create: (_) => locator<ImagePickerViewModel>()),
      ChangeNotifierProvider(create: (_) => locator<ArticleViewModel>()),
      ChangeNotifierProvider(create: (_) => locator<PdfViewerViewModel>()),
      ChangeNotifierProvider(create: (_) => locator<ChatViewModel>()),
      ChangeNotifierProvider(create: (_) => locator<ChartViewModel>()),
      ChangeNotifierProvider(create: (_) => locator<VideoPlayerViewModel>()),
    ];
  }
}
