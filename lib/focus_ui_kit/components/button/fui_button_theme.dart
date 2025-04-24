import 'package:flutter/material.dart';

import '../../exports.dart';

abstract class FUIButtonTheme {
  /// Enable/Disable
  static const Duration opacityAnimationDuration = Duration(milliseconds: 500);
  static const double opacityDisabled = 0.7;

  /// Size Factor
  // static const double widthFactorSmall = 1.5;
  // static const double widthFactorMedium = 1.6;
  // static const double widthFactorLarge = 1.8;
  //
  // static const double heightFactorSmall = 1.4;
  // static const double heightFactorMedium = 1.7;
  // static const double heightFactorLarge = 2.0;

  static const double widthBufferSmall = 28;
  static const double widthBufferMedium = 30;
  static const double widthBufferLarge = 45;

  static const double heightBufferSmall = 15;
  static const double heightBufferMedium = 18;
  static const double heightBufferLarge = 25;

  static const double textLinkWidthBufferSmall = 5;
  static const double textLinkWidthBufferMedium = 5;
  static const double textLinkWidthBufferLarge = 6;

  static const double textLinkHeightBufferSmall = 1;
  static const double textLinkHeightBufferMedium = 1;
  static const double textLinkHeightBufferLarge = 1;

  static const double fontSizeSmall = 11;
  static const double fontSizeMedium = 13;
  static const double fontSizeLarge = 15;

  static const double circleIconSizeSmall = 20;
  static const double circleIconSizeMedium = 27;
  static const double circleIconSizeLarge = 33;
  static const double circleIconPaddingSizeSmall = 3;
  static const double circleIconPaddingSizeMedium = 6;
  static const double circleIconPaddingSizeLarge = 10;

  /// For Block and Outlined Buttons
  static const double iconSizeSmall = 12;
  static const double iconSizeMedium = 15;
  static const double iconSizeLarge = 17;

  // static const double widthSpacerForCalc = 15;
  static const double widthSpacerForCalc = 25;
  static const double textLinkWidthSpacerForCalc = 8;
  static const double heightSpacerForCalc = 7;

  static const double shapeRoundedBorderRadius = 50;
  static const double shapeSquareBorderRadius = 5;

  /// For linked text buttons
  static const double linkedTextButtonTextDecorationThickness = 1;
  static const TextDecorationStyle linkedTextButtonTextDecorationStyle = TextDecorationStyle.solid;

  /// Colors
  Color get buttonOverlayColor;

  /// Button Styles
  ButtonStyle get iconButtonStyle;

  ButtonStyle get menuButtonStyle;

  /// Text Styles
  TextStyle get textIconButtonWhite;

  TextStyle get textIconButtonBlack;

  TextStyle get linkedButtonTextStyle;

  TextStyle get linkedButtonHoverTextStyle;
}

class FUIButtonThemeLight extends FUIButtonTheme {
  final FUIThemeCommonColors fuiColors = FUIThemeCommonColorsLight();

  /// Colors
  @override
  Color get buttonOverlayColor => Colors.black12;

  /// Button Styles
  @override
  ButtonStyle get iconButtonStyle => IconButton.styleFrom(
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        splashFactory: NoSplash.splashFactory,
      );

  @override
  ButtonStyle get menuButtonStyle => TextButton.styleFrom(
        backgroundColor: Colors.transparent,
        splashFactory: NoSplash.splashFactory,
      );

  /// Text Styles
  @override
  TextStyle get textIconButtonWhite => TextStyle(
        color: fuiColors.shade0,
        fontFamily: FUITypographyTheme.fontFamilyPrimary,
        fontWeight: FontWeight.w400,
        decoration: TextDecoration.none,
      );

  @override
  TextStyle get textIconButtonBlack => TextStyle(
        color: fuiColors.textHeading,
        fontFamily: FUITypographyTheme.fontFamilyPrimary,
        fontWeight: FontWeight.w400,
        decoration: TextDecoration.none,
      );

  @override
  TextStyle get linkedButtonTextStyle => TextStyle(
        color: fuiColors.primary,
        fontFamily: FUITypographyTheme.fontFamilyPrimary,
        fontWeight: FontWeight.w600,
        decoration: TextDecoration.none,
      );

  @override
  TextStyle get linkedButtonHoverTextStyle => TextStyle(
        color: fuiColors.primary,
        fontFamily: FUITypographyTheme.fontFamilyPrimary,
        fontWeight: FontWeight.w700,
        decoration: TextDecoration.none,
      );
}
