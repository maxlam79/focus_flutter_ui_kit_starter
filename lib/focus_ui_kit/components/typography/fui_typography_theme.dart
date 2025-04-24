import 'package:flutter/material.dart';

import '../../theme/fui_theme.dart';

abstract class FUITypographyTheme {
  /// Font Family Names
  static const String fontFamilyPrimary = 'Inter';
  static const String fontFamilyCodeDisplay = 'JetBrainsMono';

  /// Font Sizes
  /// - Headings
  static const double fontSizePreH = 12;
  static const double fontSizeH1 = 44;
  static const double fontSizeH2 = 30;
  static const double fontSizeH3 = 27;
  static const double fontSizeH4 = 22;
  static const double fontSizeH5 = 18;
  static const double fontSizeRegular = 13;
  static const double fontSizeSmallText = 12;
  static const double fontSizeFieldLabel = 13;

  /// Other Style Attributes
  static const double letterSpacing = 0;
  static const double wordSpacing = 0;
  static const int indentSpace = 4;

  /// Font Container Paddings
  static const EdgeInsets fontPaddingPreH = EdgeInsets.only(top: 5, bottom: 2);
  static const EdgeInsets fontPaddingH1 = EdgeInsets.only(top: 14, bottom: 8);
  static const EdgeInsets fontPaddingH2 = EdgeInsets.only(top: 13, bottom: 8);
  static const EdgeInsets fontPaddingH3 = EdgeInsets.only(top: 12, bottom: 8);
  static const EdgeInsets fontPaddingH4 = EdgeInsets.only(top: 11, bottom: 8);
  static const EdgeInsets fontPaddingH5 = EdgeInsets.only(top: 10, bottom: 8);
  static const EdgeInsets fontPaddingRegular = EdgeInsets.only(top: 2, bottom: 2);
  static const EdgeInsets fontPaddingSmallText = EdgeInsets.only(top: 2, bottom: 2);

  TextStyle get defaultTextStyle;
  TextStyle get preH;
  TextStyle get h1;
  TextStyle get h2;
  TextStyle get h3;
  TextStyle get h4;
  TextStyle get h5;
  TextStyle get regular;
  TextStyle get smallText;
  TextStyle get highlight;
  TextStyle get fieldLabel;
}

class FUITypographyThemeLight extends FUITypographyTheme {
  FUIThemeCommonColors colors = FUIThemeCommonColorsLight();

  @override
  TextStyle get defaultTextStyle => const TextStyle(
        fontFamily: FUITypographyTheme.fontFamilyPrimary,
        decoration: TextDecoration.none,
      );

  @override
  TextStyle get preH => defaultTextStyle.copyWith(
        fontSize: FUITypographyTheme.fontSizePreH,
        fontWeight: FontWeight.w700,
        color: colors.textHeading,
      );

  @override
  TextStyle get h1 => defaultTextStyle.copyWith(
        fontSize: FUITypographyTheme.fontSizeH1,
        fontWeight: FontWeight.w900,
        color: colors.textHeading,
      );

  @override
  TextStyle get h2 => defaultTextStyle.copyWith(
        fontSize: FUITypographyTheme.fontSizeH2,
        fontWeight: FontWeight.w800,
        color: colors.textHeading,
      );

  @override
  TextStyle get h3 => defaultTextStyle.copyWith(
        fontSize: FUITypographyTheme.fontSizeH3,
        fontWeight: FontWeight.w700,
        color: colors.textHeading,
      );

  @override
  TextStyle get h4 => defaultTextStyle.copyWith(
        fontSize: FUITypographyTheme.fontSizeH4,
        fontWeight: FontWeight.w600,
        color: colors.textHeading,
      );

  @override
  TextStyle get h5 => defaultTextStyle.copyWith(
        fontSize: FUITypographyTheme.fontSizeH5,
        fontWeight: FontWeight.w500,
        color: colors.textHeading,
      );

  @override
  TextStyle get regular => defaultTextStyle.copyWith(
        fontSize: FUITypographyTheme.fontSizeRegular,
        fontWeight: FontWeight.w500,
        color: colors.textBody,
      );

  @override
  TextStyle get smallText => defaultTextStyle.copyWith(
        fontSize: FUITypographyTheme.fontSizeSmallText,
        fontWeight: FontWeight.w500,
        color: colors.textHinted,
      );

  @override
  TextStyle get highlight => defaultTextStyle.copyWith(
        fontSize: FUITypographyTheme.fontSizeRegular,
        fontWeight: FontWeight.w400,
        color: colors.shade0,
        backgroundColor: colors.primary,
      );

  @override
  TextStyle get fieldLabel => defaultTextStyle.copyWith(
        fontSize: FUITypographyTheme.fontSizeFieldLabel,
        fontWeight: FontWeight.w600,
        color: colors.shade3,
      );
}
