import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavigationService {
  static final NavigationService _instance = NavigationService._internal();
  factory NavigationService() => _instance;
  NavigationService._internal();

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(String routeName, {dynamic arguments}) {
    if (navigatorKey.currentContext == null) return Future.value();
    return GoRouter.of(
      navigatorKey.currentContext!,
    ).push('/$routeName', extra: arguments);
  }

  Future<dynamic> navigateToReplacement(String routeName, {dynamic arguments}) {
    if (navigatorKey.currentContext == null) return Future.value();
    return GoRouter.of(
      navigatorKey.currentContext!,
    ).pushReplacement('/$routeName', extra: arguments);
  }

  void goBack() {
    if (navigatorKey.currentContext == null) return;
    return GoRouter.of(navigatorKey.currentContext!).pop();
  }

  void popUntil(String routeName) {
    // if (navigatorKey.currentContext == null) return;
    // while (GoRouter.of(navigatorKey.currentContext!).canPop() &&
    //     GoRouter.of(navigatorKey.currentContext!).location != '/$routeName') {
    //   GoRouter.of(navigatorKey.currentContext!).pop();
    // }
  }
}
