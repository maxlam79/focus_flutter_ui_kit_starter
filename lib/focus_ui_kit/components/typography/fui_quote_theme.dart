import 'package:flutter/material.dart';

import '../../exports.dart';

abstract class FUIQuoteTheme {
  static const double fontSizeQuote = 56;
  static const double fontSizeQuoteTextContent = 16;
  static const double fontSizeQuoteBottomLine1 = 14;
  static const double fontSizeQuoteBottomLine2 = 12;

  /// Text Styles
  TextStyle get quoteSymbol;

  TextStyle get quoteContent;

  TextStyle get quoteBottomLine1;

  TextStyle get quoteBottomLine2;
}

class FUIQuoteThemeLight extends FUIQuoteTheme {
  final FUIThemeCommonColors colors = FUIThemeCommonColorsLight();

  @override
  TextStyle get quoteSymbol => TextStyle(
        color: colors.shade2,
        fontFamily: FUITypographyTheme.fontFamilyPrimary,
        fontSize: 22,
        fontWeight: FontWeight.w900,
        decoration: TextDecoration.none,
      );

  @override
  TextStyle get quoteContent => TextStyle(
        color: colors.shade4,
        fontFamily: FUITypographyTheme.fontFamilyPrimary,
        fontSize: FUIQuoteTheme.fontSizeQuoteTextContent,
        fontWeight: FontWeight.w600,
        decoration: TextDecoration.none,
      );

  @override
  TextStyle get quoteBottomLine1 => TextStyle(
        color: colors.shade3,
        fontFamily: FUITypographyTheme.fontFamilyPrimary,
        fontSize: FUIQuoteTheme.fontSizeQuoteBottomLine1,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w500,
        decoration: TextDecoration.none,
      );

  @override
  TextStyle get quoteBottomLine2 => TextStyle(
        color: colors.shade3,
        fontFamily: FUITypographyTheme.fontFamilyPrimary,
        fontSize: FUIQuoteTheme.fontSizeQuoteBottomLine2,
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.w500,
        decoration: TextDecoration.none,
      );
}
