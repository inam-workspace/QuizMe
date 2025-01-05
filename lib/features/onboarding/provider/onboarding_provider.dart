import 'package:quiz_me/main/imports.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingProvider extends ChangeNotifier {
  List<Map<String, dynamic>> onboardingData = [
    {
      'title': 'Your Learning Hub Awaits!',
      'subtitle':
          'Effortlessly access quizzes, flashcards, mock tests, and notes right from the landing page. Everything you need is just a tap away!',
      'image': 'assets/images/onboard_1.png',
    },
    {
      'title': 'Build Your Perfect Study Guide',
      'subtitle':
          'Upload or select your materials – PDFs, images, or even YouTube links – to craft a tailored study guide just for you.',
      'image': 'assets/images/onboard_2.png',
    },
    {
      'title': 'Choose Your Quiz Style',
      'subtitle':
          'Pick from MCQs, True/False, or Correct Answer formats to match your learning preference and challenge yourself.',
      'image': 'assets/images/onboard_3.png',
    },
    {
      'title': 'View Your Results and Improve',
      'subtitle':
          'Check your results and gain insights to track progress. Identify areas to focus on and achieve your learning goals!',
      'image': 'assets/images/onboard_4.png',
    },
  ];

  final controller = PageController();
  int _page = 0;
  int get page => _page;
  set setPage(int page) {
    _page = page;
    notifyListeners();
  }

  nextPage() {
    if (page == 3) {
      clearOnboarding();
      Push.replace(route: '/loginScreen');
      return;
    }

    controller.nextPage(
      duration: Duration(milliseconds: 375),
      curve: Curves.easeIn,
    );
  }

  OnboardingProvider() {
    controller.addListener(() {
      setPage = controller.page!.round();
    });
  }

  clearOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('onboarding', true);
  }
}
