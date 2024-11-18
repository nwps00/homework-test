import 'package:flutter/material.dart';
import 'package:market_app/style/color_theme.dart';

class FontTheme {
  static TextStyle headlineLarge = const TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 32,
    color: ColorTheme.onSurface,
  );
  static TextStyle titleLarge = const TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w400,
    color: ColorTheme.onSurface,
  );
  static TextStyle titleMedium = const TextStyle(
      fontSize: 16, fontWeight: FontWeight.w500, color: ColorTheme.onSurface);
  static TextStyle titleSmall =
      const TextStyle(fontSize: 14, color: ColorTheme.onSurface);
  static TextStyle labelLarge = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: ColorTheme.onSurface,
  );
}
