/// OnBoarding Data Model
class OnBoarding {
  /// Required - Title of the onboarding screen
  OnBoarding({
    required this.title,
    required this.description,
    required this.imagePath,
  });

  /// onboarding title
  String title;

  /// onboarding description
  String description;

  /// onboarding imagePath
  String imagePath;
}
