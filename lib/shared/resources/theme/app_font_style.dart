import 'package:flutter/material.dart';

class AppFontStyle {
  static const _fontFamily = "TT Bluescreens";

  static const TextStyle displayLarge = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 65,
  );

  static const TextStyle displayMedium = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 55,
  );

  static const TextStyle displaySmall = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 42,
  );

  static const TextStyle headlineLarge = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 36,
  );

  static const TextStyle headlineMedium = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 32,
  );

  static const TextStyle headlineSmall = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 28,
  );

  static const TextStyle titleLarge = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 28,
  );

  static const TextStyle titleMedium = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 22,
  );

  static const TextStyle titleSmall = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 18,
  );

  static const TextStyle bodyLarge = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.normal,
    fontSize: 26,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.normal,
    fontSize: 21,
  );

  static const TextStyle bodySmall = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.normal,
    fontSize: 20,
  );

  static const TextStyle labelSmall = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 11,
  );

  static const TextStyle labelMedium = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 12,
  );

  static const TextStyle labelLarge = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 14,
  );
}

extension TextStyleExt on TextStyle {
  /// set fontSize to [fontSize]
  TextStyle fs(double fontSize) => copyWith(fontSize: fontSize);

  /// set Color to [color]
  TextStyle cl(Color color) => copyWith(color: color);
}
