import 'package:quiz_me/main/imports.dart';

class MockTestPreviewProvider extends ChangeNotifier {
  List<MockTestType> testOptions = [
    MockTestType.mcq,
    MockTestType.statement,
    MockTestType.custom,
  ];

  MockTestType _currentType = MockTestType.mcq;
  MockTestType get currentType => _currentType;
  set setCurrentType(MockTestType type) {
    _currentType = type;
    notifyListeners();
  }
}
