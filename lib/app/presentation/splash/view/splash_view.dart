import 'package:diet/app/core/navigation_helper/navigation_helper.dart';

import 'package:diet/app/presentation/onboarding/view/onboarding_view.dart';

import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    navigateToHome();
  }

  navigateToHome() async {
    await Future.delayed(const Duration(milliseconds: 1500), () {
      // NavigationService.instance.navigateToPageRemoveAll(path: '/welcome');
      Navigation.pushAndRemoveAll<OnboardingView>(page: const OnboardingView());
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Image(image: AssetImage('assets/images/logo.jpeg')),
      ),
    );
  }
}
