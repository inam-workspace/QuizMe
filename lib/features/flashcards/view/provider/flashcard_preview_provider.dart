import 'package:quiz_me/main/imports.dart';

class FlashcardsPreviewProvider extends ChangeNotifier {
  bool isDispose = false;

  @override
  notifyListeners() {
    if (isDispose) return;
    super.notifyListeners();
  }

  @override
  void dispose() {
    isDispose = true;
    super.dispose();
  }

  final GuideDetailsEntity guideDetails;

  List<DropdownMenuItem> _dropdownList = [];
  List<DropdownMenuItem> get dropdownList => _dropdownList;
  set setDropdownList(List<DropdownMenuItem> list) {
    _dropdownList = list;
    notifyListeners();
  }

  String _currentChapter = '';
  String get currentChapter => _currentChapter;
  set setCurrentChapter(String chapter) {
    _currentChapter = chapter;
    notifyListeners();
  }

  FlashcardsPreviewProvider({required this.guideDetails}) {
    setCurrentChapter = guideDetails.chaptersDetail.first.title;
    List<DropdownMenuItem> dropdown = [];
    for (var element in guideDetails.chaptersDetail) {
      dropdown.add(
        DropdownMenuItem(
          value: element.title,
          child: Text(
            element.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(Push.context).textTheme.bodySmall,
          ),
        ),
      );
    }
    setDropdownList = dropdown;
  }
}
