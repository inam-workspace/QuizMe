import 'package:flutter/material.dart';

class AppColors {
  /// App primary color
  static const Color primary = Color(0xFFFF2C79);

  /// App error color
  static const Color error = Color(0xFFFF003C);

  /// App background color
  static const Color background = Color(0xFFFFFFFF);

  /// App suface color
  static const Color suface = Color(0xFF000000);

  /// App disable color
  static const Color disable = Color(0xFFFFF0F6);

  /// App hint color
  static const Color hint = Color(0xFFBCBCBC);

  /// Extra card color
  static const Color card = Color(0xFFFFF5F9);

  static const LinearGradient gradient = LinearGradient(
    colors: [
      Color(0xFFD9235E),
      Color(0xFF7A0F21),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const BoxShadow boxShadow = BoxShadow(
    color: Color(0x0F37620D),
    offset: Offset(0, 0),
    blurRadius: 15,
    spreadRadius: 0,
  );

  static MaterialColor primarySwatch = getColorFromHex(primary.value);

  static MaterialColor getColorFromHex(int hexValue) {
    Map<int, Color> colorMap = {
      50: Color(hexValue),
      100: Color(hexValue),
      200: Color(hexValue),
      300: Color(hexValue),
      400: Color(hexValue),
      500: Color(hexValue),
      600: Color(hexValue),
      700: Color(hexValue),
      800: Color(hexValue),
      900: Color(hexValue),
    };
    return MaterialColor(hexValue, colorMap);
  }
}
