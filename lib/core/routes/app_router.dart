import 'package:go_router/go_router.dart';
import 'package:insurance_ws/features/cart/viewmodel/cart_viewmodel.dart';
import 'package:insurance_ws/features/charts/viewmodel/chart_viewmodel.dart';
import 'package:insurance_ws/features/chat/viewmodel/chat_viewmodel.dart';
import 'package:insurance_ws/features/order/viewmodel/order_viewmodel.dart';
import 'package:insurance_ws/features/pdf_viewer/viewmodel/pdf_viewer_viewmodel.dart';
import 'package:insurance_ws/features/product/viewmodel/product_viewmodel.dart';
import 'package:insurance_ws/screens/cart/cart_screen.dart';
import 'package:insurance_ws/screens/charts/chart_screen.dart';
import 'package:insurance_ws/screens/chat/chat_screen.dart';
import 'package:insurance_ws/screens/index/index_screen.dart';
import 'package:insurance_ws/screens/order/order_detail_screen.dart';
import 'package:insurance_ws/screens/order/order_list_screen.dart';
import 'package:insurance_ws/screens/pdf_viewer/pdf_viewer_screen.dart';
import 'package:insurance_ws/screens/product/product_detail_screen.dart';
import 'package:insurance_ws/screens/product/product_list_screen.dart';
import 'package:provider/provider.dart';

import '../../features/article/viewmodel/article_viewmodel.dart';
import '../../features/image_picker/viewmodel/image_picker_viewmodel.dart';
import '../../features/prayer/viewmodel/prayer_viewmodel.dart';
import '../../features/signin/viewmodel/signin_viewmodel.dart';
import '../../features/signup/viewmodel/signup_viewmodel.dart';
import '../../features/video_player/viewmodel/video_player_viewmodel.dart';
import '../../screens/article/article_detail_screen.dart';
import '../../screens/article/article_list_screen.dart';
import '../../screens/image_picker/image_picker_screen.dart';
import '../../screens/prayer/prayer_screen.dart';
import '../../screens/signin/signin_screen.dart';
import '../../screens/signup/signup_screen.dart';
import '../../screens/video_player/video_player_screen.dart';
import '../service/navigation_service.dart';
import '../service/service_locator.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    navigatorKey: locator<NavigationService>().navigatorKey,
    routes: [
      GoRoute(
        path: '/',
        name: 'index',
        builder: (context, state) => const IndexScreen(),
      ),
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
        path: '/article/list',
        name: 'article-list',
        builder:
            (context, state) => ChangeNotifierProvider(
              create: (_) => locator<ArticleViewModel>(),
              child: const ArticleListScreen(),
            ),
      ),
      GoRoute(
        path: '/article/detail/:id',
        name: 'article-detail',
        builder:
            (context, state) => ChangeNotifierProvider(
              create:
                  (_) =>
                      locator<ArticleViewModel>()
                        ..selectArticle(state.pathParameters['id']!),
              child: const ArticleDetailScreen(),
            ),
      ),
      GoRoute(
        path: '/products',
        name: 'products',
        builder:
            (context, state) => ChangeNotifierProvider(
              create: (_) => locator<ProductViewModel>(),
              child: const ProductListScreen(),
            ),
      ),
      GoRoute(
        path: '/products/:id',
        name: 'product-detail',
        builder:
            (context, state) => ChangeNotifierProvider(
              create:
                  (_) =>
                      locator<ProductViewModel>()
                        ..loadProductDetails(state.pathParameters['id']!),
              child: ProductDetailScreen(
                productId: state.pathParameters['id']!,
              ),
            ),
      ),
      GoRoute(
        path: '/cart',
        name: 'cart',
        builder:
            (context, state) => ChangeNotifierProvider(
              create: (_) => locator<CartViewModel>()..loadUserCart(),
              child: const CartScreen(),
            ),
      ),
      GoRoute(
        path: '/orders',
        name: 'orders',
        builder:
            (context, state) => ChangeNotifierProvider(
              create: (_) => locator<OrderViewModel>(),
              child: const OrderListScreen(),
            ),
      ),
      GoRoute(
        path: '/orders/:id',
        name: 'order-detail',
        builder:
            (context, state) => ChangeNotifierProvider(
              create:
                  (_) =>
                      locator<OrderViewModel>()
                        ..loadOrderDetails(state.pathParameters['id']!),
              child: OrderDetailScreen(orderId: state.pathParameters['id']!),
            ),
      ),
      GoRoute(
        path: '/pdf_viewer',
        name: 'pdf_viewer',
        builder:
            (context, state) => ChangeNotifierProvider(
              create: (_) => locator<PdfViewerViewModel>(),
              child: PdfViewerScreen(),
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
