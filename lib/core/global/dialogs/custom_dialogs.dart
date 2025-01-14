import 'dart:ui';
import 'package:quiz_me/main/imports.dart';

showCustomDialog({required Widget content, bool barrierDismissible = true}) {
  final context = Push.context;
  return showDialog(
    barrierColor: Theme.of(context).colorScheme.scrim.withOpacity(0.25),
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (BuildContext context) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
        child: Dialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          elevation: 10,
          insetPadding: gapSymmetric(horizontal: 12),
          shadowColor: Theme.of(context).scaffoldBackgroundColor,
          surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          clipBehavior: Clip.hardEdge,
          child: Padding(
            padding: gapAll(12),
            child: content,
          ),
        ),
      );
    },
  );
}

showProcessingDialog() {
  final context = Push.context;
  return showDialog(
    barrierColor: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.25),
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
        child: Dialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          elevation: 10,
          insetPadding: gapSymmetric(horizontal: 12),
          shadowColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          clipBehavior: Clip.hardEdge,
          child: PopScope(
            canPop: true,
            child: Padding(
              padding: gapAll(12),
              child: Image.asset(
                'assets/animation/loading.gif',
                height: h(75),
              ),
            ),
          ),
        ),
      );
    },
  );
}

void showLoadingIndicator(String text) {
  showDialog(
    context: Push.context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return PopScope(
        canPop: false,
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(12.0),
            ),
          ),
          backgroundColor: Colors.black.withOpacity(0.75),
          content: Container(
            padding: gapAll(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [_getLoadingIndicator(), _getHeading(), _getText(text)],
            ),
          ),
        ),
      );
    },
  );
}

Widget _getLoadingIndicator() {
  return Padding(
    padding: gapOnly(bottom: 16),
    child: SizedBox(
      width: h(32),
      height: h(32),
      child: Platform.isAndroid
          ? CircularProgressIndicator(strokeWidth: w(3))
          : CupertinoActivityIndicator(),
    ),
  );
}

Widget _getHeading() {
  return Padding(
    padding: EdgeInsets.only(bottom: 4),
    child: Text(
      'Please wait …',
      style: TextStyle(color: Colors.white, fontSize: 16),
      textAlign: TextAlign.center,
    ),
  );
}

Widget _getText(String displayedText) {
  return Text(
    displayedText,
    style: TextStyle(color: Colors.white, fontSize: 14),
    textAlign: TextAlign.center,
  );
}
