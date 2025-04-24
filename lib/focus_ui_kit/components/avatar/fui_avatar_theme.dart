import 'package:flutter/material.dart';

import '../../exports.dart';

abstract class FUIAvatarTheme {

  /// Sizes
  static const double radiusSmall = 14;
  static const double radiusMedium = 16;
  static const double radiusLarge = 18;
  static const double infoFontSize = 13;
  static const double infoBorderWidth = 1;
  static const double minCoverage = 0.1;
  static const double maxCoverage = 0.3;

  Color get infoBorderColor;
  Color get infoBackgroundColor;

  TextStyle get tsInfo;
}

class FUIAvatarThemeLight extends FUIAvatarTheme {

  FUIThemeCommonColors fuiColors = FUIThemeCommonColorsLight();

  @override
  Color get infoBorderColor => fuiColors.primary;

  @override
  Color get infoBackgroundColor => fuiColors.primary;

  @override
  TextStyle get tsInfo => const TextStyle(
    fontFamily: FUITypographyTheme.fontFamilyPrimary,
    fontWeight: FontWeight.w600,
    fontSize: FUIAvatarTheme.infoFontSize,
    decoration: TextDecoration.none,
  );
}