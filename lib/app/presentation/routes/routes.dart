import 'package:diet/app/presentation/healty/healty_view.dart';
import 'package:diet/app/presentation/splash/view/splash_view.dart';
import 'package:diet/main.dart';
import 'package:flutter/material.dart';

final class Routes {
  static const home = '/home';
  static const health = '/health';
  static const distance = '/distance';
  static const splash = '/splash';

  static Route<dynamic> onGenerateRoutes(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case splash:
        return _materialPageRoute(const SplashView());
      case home:
        return _materialPageRoute(const SplashView());
      case health:
        return _materialPageRoute(HealthApp());

      default:
        return _materialPageRoute(const SplashView());
    }
  }

  static MaterialPageRoute<dynamic> _materialPageRoute(Widget page) =>
      MaterialPageRoute(builder: (context) => page);
}
