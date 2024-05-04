import 'package:flutter/material.dart';

abstract class ThemeColors {
  static const MaterialColor primaryMaterial = MaterialColor(0xFF3ABFFA, <int, Color>{
    50: Color(0xFFE7F7FE),
    100: Color(0xFFC4ECFE),
    200: Color(0xFF9DDFFD),
    300: Color(0xFF75D2FC),
    400: Color(0xFF58C9FB),
    500: Color(0xFF3ABFFA),
    600: Color(0xFF34B9F9),
    700: Color(0xFF2CB1F9),
    800: Color(0xFF25A9F8),
    900: Color(0xFF189BF6),
  });
  static const Color primary = Color(0xFF3ABFFA);
  static const Color primaryBg = Color(0xFFEEEEEE);
  static const Color white = Color(0xFFFFFFFF);
  static const Color grey = Color(0xFF2E2E2E);
  static const Color greyText = Color(0xFF646464);
  static const Color green = Color(0xFF5CB85C);
  static const Color black = Color(0xFF434343);
  static const Color red = Color(0xFFEA2C2C);
}
