import 'package:quiz_me/main/imports.dart';

class NotesPreviewProvider extends ChangeNotifier {
  final GuideDetailsEntity guideDetails;

  List<DropdownMenuItem> _dropdownList = [];
  List<DropdownMenuItem> get dropdownList => _dropdownList;
  set setDropdownList(List<DropdownMenuItem> list) {
    _dropdownList = list;
    notifyListeners();
  }

  String _contentID = '';
  String get contentID => _contentID;
  set setContentID(String id) {
    _contentID = id;
    notifyListeners();
  }

  NotesPreviewProvider({required this.guideDetails}) {
    setContentID = guideDetails.chaptersDetail.first.id;
    List<DropdownMenuItem> dropdown = [];
    for (var element in guideDetails.chaptersDetail) {
      dropdown.add(
        DropdownMenuItem(
          value: element.id,
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
