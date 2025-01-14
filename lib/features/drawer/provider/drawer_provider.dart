import 'package:quiz_me/main/imports.dart';

class DrawerProvider extends ChangeNotifier {
  final user = AppController.instance.currentUser;
  final appProvider = Provider.of<AppController>(Push.context, listen: false);

  uploadProfile() async {
    await FilePicker.platform
        .pickFiles(
      allowMultiple: false,
      type: FileType.image,
    )
        .then(
      (result) async {
        if (result != null) {
          final filePath = result.files.single.path;
          if (filePath != null) {
            showLoadingIndicator('Uploading your profile picture');
            await GetAuth.instance
                .updateProfileImage(
              user!.uid,
              File(filePath).readAsBytesSync(),
            )
                .then(
              (value) async {
                final failOrResult =
                    await GetAuth.instance.getAuthDetails(user!.uid);
                failOrResult.fold(
                  (fail) {
                    Push.back();
                  },
                  (authModel) {
                    appProvider.setAndNotifyAuthDetails = authModel;
                    Push.back();
                  },
                );
              },
            );
          }
        }
      },
    );
  }

  privacyPolicy() async {
    const url = 'https://sites.google.com/view/quiz-me-app/home';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }
}
