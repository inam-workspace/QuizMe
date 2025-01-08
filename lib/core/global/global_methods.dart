import 'package:quiz_me/main/imports.dart';

showWarningToast(String title, String message) {
  final context = Push.context;
  toastification.show(
    context: context,
    type: ToastificationType.warning,
    style: ToastificationStyle.flatColored,
    autoCloseDuration: const Duration(seconds: 2),
    title: Text(title),
    description: Text(message),
    alignment: Alignment.topCenter,
    animationDuration: const Duration(milliseconds: 300),
    icon: Text(
      '⚠️',
      style: TextStyle(fontSize: h(36)),
    ),
    showIcon: true,
    primaryColor: Colors.orange.shade500,
    backgroundColor: Theme.of(context).cardColor,
    foregroundColor: Theme.of(context).colorScheme.scrim,
    padding: gapSymmetric(horizontal: 12, vertical: 16),
    margin: gapSymmetric(horizontal: 12, vertical: 8),
    borderRadius: BorderRadius.circular(10),
    showProgressBar: false,
    dragToClose: true,
    applyBlurEffect: false,
  );
}

showSuccessToast(String title, String message) {
  final context = Push.context;
  toastification.show(
    context: context,
    type: ToastificationType.success,
    style: ToastificationStyle.flatColored,
    autoCloseDuration: const Duration(seconds: 3),
    title: Text(title),
    description: Text(message),
    alignment: Alignment.bottomLeft,
    animationDuration: const Duration(milliseconds: 300),
    icon: Text(
      '🎉',
      style: TextStyle(fontSize: h(36)),
    ),
    showIcon: true,
    primaryColor: Colors.green,
    backgroundColor: Theme.of(context).cardColor,
    foregroundColor: Theme.of(context).colorScheme.scrim,
    padding: gapSymmetric(horizontal: 12, vertical: 16),
    margin: gapSymmetric(horizontal: 12, vertical: 8),
    borderRadius: BorderRadius.circular(10),
    showProgressBar: false,
    dragToClose: true,
    applyBlurEffect: false,
  );
}

Color getColor(String colorString) {
  return Color(int.parse(colorString, radix: 16));
}

String get uniqueID {
  String dateTimeString = DateTime.now().millisecondsSinceEpoch.toString();
  List<int> bytes = utf8.encode(dateTimeString);
  String base64String = base64Encode(bytes);
  return base64String;
}
