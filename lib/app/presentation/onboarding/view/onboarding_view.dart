import 'package:diet/app/core/extension/build_context_extension.dart';
import 'package:diet/app/core/widget/slider_dots.dart';
import 'package:diet/app/presentation/onboarding/data/onboarding_data.dart';
import 'package:diet/app/presentation/onboarding/model/onboarding_model.dart';
import 'package:flutter/material.dart';

/// Onboarding View
final class OnboardingView extends StatefulWidget {
  /// Onboarding view const
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final pageController = PageController();
  final pages = List<Widget>.generate(
    onboardingData.length,
    (index) {
      final data = onboardingData[index];
      return ContentWidget(data: data);
    },
  );
  var currIndex = 0;

  void changeIndex(int index) {
    setState(() {
      currIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    /// Onboarding title value

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(),
            Expanded(
              flex: 8,
              child: PageView.builder(
                controller: pageController,
                itemCount: onboardingData.length,
                itemBuilder: (context, index) => pages[index],
                onPageChanged: changeIndex,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: ButtonWidget(
                  onTap: () async {
                    await pageController.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  },
                  length: onboardingData.length,
                  currIndex: currIndex,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                onboardingData.length,
                (index) {
                  return buildDot(index, currIndex);
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildDot(int index, int currentIndex) {
    return Container(
      width: 20,
      height: 20,
      margin: const EdgeInsets.only(right: 3),
      decoration: BoxDecoration(
        color: const Color(0xFF555555),
        borderRadius: BorderRadius.circular(5),
        gradient: currentIndex == index
            ? const LinearGradient(
                colors: [Color(0xFFEE5266), Color(0xFFDC2D96)],
              )
            : null,
      ),
    );
  }
}

/// Content widget for the onboarding page
class ContentWidget extends StatelessWidget {
  const ContentWidget({
    required this.data,
    super.key,
  });

  /// Onboard page to show
  final OnBoarding data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // Image.asset(
        //   data.image,
        //   height: 400,
        // ),
        // context.lowHeightSB,
        SizedBox(
          height: 81,
          width: 320,
          child: Text(
            data.title,
            style: const TextStyle(fontSize: 27, fontWeight: FontWeight.w900),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          height: 120,
          width: 314,
          child: Text(
            data.description,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}

///Common button widget for onBoarding page
class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    required this.onTap,
    required this.length,
    required this.currIndex,
    Key? key,
  });

  /// Callback function for button
  final VoidCallback onTap;

  /// onBoarding pages count
  final int length;

  /// index control for button title and function
  final int currIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 58,
      width: 330,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(17),
        gradient: const LinearGradient(
          colors: [Color(0xFFEE5266), Color(0xFFDC2D96)],
        ),
      ),
      child: InkWell(
        onTap: onTap,
        child: Center(
          child: Text(
            currIndex == (length - 1) ? "Start" : "Next",
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }
}
