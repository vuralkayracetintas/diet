import 'package:diet/app/core/navigation_helper/navigation_helper.dart';

import 'package:diet/app/presentation/routes/routes.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  runApp(const MyApp());
}

/// My App Start Widget
class MyApp extends StatelessWidget {
  ///
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      navigatorKey: Navigation.navigationKey,
      onGenerateRoute: Routes.onGenerateRoutes,
      initialRoute: Routes.splash,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
