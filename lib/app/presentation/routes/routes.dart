import 'package:diet/main.dart';
import 'package:flutter/material.dart';

final class Routes {
  static const home = '/home';

  static Route<dynamic> onGenerateRoutes(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case home:
        return _materialPageRoute(const MyHomePage(title: ''));

      default:
        return _materialPageRoute(const MyHomePage(title: 'title'));
    }
  }

  static MaterialPageRoute<dynamic> _materialPageRoute(Widget page) =>
      MaterialPageRoute(builder: (context) => page);
}
