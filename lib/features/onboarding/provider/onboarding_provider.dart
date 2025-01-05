import 'package:quiz_me/main/imports.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingProvider extends ChangeNotifier {
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
