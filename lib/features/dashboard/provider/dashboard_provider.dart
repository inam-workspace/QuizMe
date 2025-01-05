import 'package:quiz_me/main/imports.dart';

class DashboardProvider extends ChangeNotifier {
  final guideProvider =
      Provider.of<AddGuideProvider>(Push.context, listen: false);
  final drawerController = AdvancedDrawerController();
  final pageController = PageController(initialPage: 0);
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;
  set setCurrentIndex(int index) {
    guideProvider.searchController.clear();
    pageController.jumpToPage(index);
    _currentIndex = index;
    notifyListeners();
  }
}
