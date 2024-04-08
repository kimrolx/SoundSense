class OnboardingModel {
  final String title;
  final String description;

  OnboardingModel({
    required this.title,
    required this.description,
  });
}

class OnboardingContent {
  final List<OnboardingModel> onboardingPages = [
    OnboardingModel(
      title: "SoundSense",
      description: "asdasdasdasdasdasd",
    ),
    OnboardingModel(
      title: "qweqwe",
      description: "asdasdasdaqweqweqweqwesdasdasd",
    ),
    OnboardingModel(
      title: "asdaszxczxczxcdasd",
      description: "xzcxcxczzxczxcxcxc",
    ),
  ];
}
