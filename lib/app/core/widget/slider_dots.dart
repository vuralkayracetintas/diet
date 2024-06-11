import 'package:flutter/material.dart';

class SliderDots extends StatelessWidget {
  SliderDots({
    super.key,
    required this.value,
    required this.onboardingIndex,
  });

  final List<String> value;
  int onboardingIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(value.length, (index) {
        bool isActive = index == onboardingIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 1.0),
          width: 10.0,
          height: 10.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6.0),
            color: isActive
                ? Colors.green
                : const Color.fromRGBO(217, 217, 217, 1),
          ),
        );
      }),
    );
  }
}
