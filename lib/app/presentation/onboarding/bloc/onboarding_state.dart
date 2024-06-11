import 'package:equatable/equatable.dart';

class OnboardingState extends Equatable {
  @override
  int currentIndex = 0;
  List<Object?> get props => [
        currentIndex,
      ];
}
