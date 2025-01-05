import 'dart:ui';

import 'package:quiz_me/main/imports.dart';

double referWidth = 375.0;
double referHeight = 900.0;
final view = PlatformDispatcher.instance.implicitView!;
final screenHeight = view.physicalSize.height / view.devicePixelRatio;
final screenWidth = view.physicalSize.width / view.devicePixelRatio;

double h(height) {
  return screenHeight * (height / referHeight);
}

double w(width) {
  return screenWidth * (width / referWidth);
}

double t(size) {
  return size * (screenWidth / referWidth);
}

bool isTablet() {
  return screenWidth > 600;
}

Size textSize(Text text) {
  final TextPainter textPainter = TextPainter(
    text: TextSpan(text: text.data, style: text.style),
    maxLines: 1,
    textDirection: TextDirection.ltr,
  )..layout(minWidth: 0, maxWidth: double.infinity);
  return textPainter.size;
}

