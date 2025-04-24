import 'package:flutter/material.dart';

import '../../exports.dart';

abstract class FUITextPillTheme {
  /// Sizes
  static const double fontSizeSmall = 10;
  static const double fontSizeMedium = 11;
  static const double fontSizeLarge = 12;

  static const double containerPlusWidthSmall = 14;
  static const double containerPlusWidthMedium = 15;
  static const double containerPlusWidthLarge = 16;

  static const double containerPlusHeightSmall = 9;
  static const double containerPlusHeightMedium = 10;
  static const double containerPlusHeightLarge = 11;

  static const EdgeInsets paddingSmall = EdgeInsets.all(2);
  static const EdgeInsets paddingMedium = EdgeInsets.all(3);
  static const EdgeInsets paddingLarge = EdgeInsets.all(4);

  // static const double fontSizeSmall = 12;
  // static const double fontSizeMedium = 13;
  // static const double fontSizeLarge = 14;
  //
  // static const double containerPlusWidthSmall = 16;
  // static const double containerPlusWidthMedium = 17;
  // static const double containerPlusWidthLarge = 18;
  //
  // static const double containerPlusHeightSmall = 11;
  // static const double containerPlusHeightMedium = 12;
  // static const double containerPlusHeightLarge = 13;
  //
  // static const EdgeInsets paddingSmall = EdgeInsets.all(3);
  // static const EdgeInsets paddingMedium = EdgeInsets.all(4);
  // static const EdgeInsets paddingLarge = EdgeInsets.all(5);

  static const BorderRadius borderRadiusRound = BorderRadius.all(Radius.circular(30));
  static const BorderRadius borderRadiusSquare = BorderRadius.all(Radius.circular(5));

  /// TextStyles
  TextStyle get textPillWhiteSmall;
  TextStyle get textPillWhiteMedium;
  TextStyle get textPillWhiteLarge;
  TextStyle get textPillBlackSmall;
  TextStyle get textPillBlackMedium;
  TextStyle get textPillBlackLarge;
}

class FUITextPillThemeLight extends FUITextPillTheme {
  final FUIThemeCommonColors colors = FUIThemeCommonColorsLight();

  @override
  TextStyle get textPillWhiteSmall => _discernTextStyleWhite(FUITextPillTheme.fontSizeSmall);

  @override
  TextStyle get textPillWhiteMedium => _discernTextStyleWhite(FUITextPillTheme.fontSizeMedium);

  @override
  TextStyle get textPillWhiteLarge => _discernTextStyleWhite(FUITextPillTheme.fontSizeLarge);

  @override
  TextStyle get textPillBlackSmall => _discernTextStyleBlack(FUITextPillTheme.fontSizeSmall);

  @override
  TextStyle get textPillBlackMedium => _discernTextStyleBlack(FUITextPillTheme.fontSizeMedium);

  @override
  TextStyle get textPillBlackLarge => _discernTextStyleBlack(FUITextPillTheme.fontSizeLarge);

  TextStyle _discernTextStyleWhite(double fontSize) {
    return TextStyle(
      color: colors.shade0,
      fontFamily: FUITypographyTheme.fontFamilyPrimary,
      fontSize: fontSize,
      fontWeight: FontWeight.w600,
      decoration: TextDecoration.none,
    );
  }

  TextStyle _discernTextStyleBlack(double fontSize) {
    return TextStyle(
      color: colors.textHeading,
      fontFamily: FUITypographyTheme.fontFamilyPrimary,
      fontSize: fontSize,
      fontWeight: FontWeight.w600,
      decoration: TextDecoration.none,
    );
  }
}
