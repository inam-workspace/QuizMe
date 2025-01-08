import 'package:quiz_me/main/imports.dart';

class DrawerProvider extends ChangeNotifier {
  final user = AppController.instance.currentUser;

  uploadProfile() async {
    await FilePicker.platform
        .pickFiles(
      allowMultiple: false,
      type: FileType.image,
    )
        .then((result) {
      if (result != null) {
        final filePath = result.files.single.path;
        if (filePath != null) {
          GetAuth.instance.updateProfileImage(
            user!.uid,
            File(filePath).readAsBytesSync(),
          );
        }
      }
    });
  }
}
