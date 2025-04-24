import 'package:flutter/material.dart';

import '../../exports.dart';

abstract class FUITooltipTheme {

  /// Sizes
  static const double tailLength = 5;
  static const double tailBaseWidth = 10;
  static const double fontSizeSmall = 10;
  static const double fontSizeMedium = 11;
  static const double fontSizeLarge = 12;
  static const EdgeInsets padding = EdgeInsets.all(7);

  /// Text Styles
  TextStyle tsBase = const TextStyle(
    fontFamily: FUITypographyTheme.fontFamilyPrimary,
    fontWeight: FontWeight.w500,
    decoration: TextDecoration.none,
  );

  TextStyle get tsSmall;
  TextStyle get tsMedium;
  TextStyle get tsLarge;

}

class FUITooltipThemeLight extends FUITooltipTheme {
  @override
  TextStyle get tsSmall => tsBase.copyWith(
        fontSize: FUITooltipTheme.fontSizeSmall,
      );

  @override
  TextStyle get tsMedium => tsBase.copyWith(
        fontSize: FUITooltipTheme.fontSizeMedium,
      );

  @override
  TextStyle get tsLarge => tsBase.copyWith(
        fontSize: FUITooltipTheme.fontSizeLarge,
      );
}
