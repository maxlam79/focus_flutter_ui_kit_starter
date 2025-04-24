import 'package:flutter/material.dart';

import '../../theme/fui_theme.dart';
import '../typography/fui_typography_theme.dart';

abstract class FUIDataTable2Theme {
  /// Sizes
  static const double tableHeight = 400;
  static const double columnSpacing = 10;
  static const double horizontalMargin = 10;
  static const double spinnerSize = 30;
  static const double dataRowHeightSmall = 40;
  static const double dataRowHeightMedium = 50;
  static const double dataRowHeightLarge = 65;
  static const double headingRowHeightSmall = 40;
  static const double headingRowHeightMedium = 50;
  static const double headingRowHeightLarge = 65;
  static const double fontSizeHeadingSmall = 11;
  static const double fontSizeDataSmall = 11;
  static const double fontSizeHeadingMedium = 13;
  static const double fontSizeDataMedium = 13;
  static const double fontSizeHeadingLarge = 15;
  static const double fontSizeDataLarge = 15;
  static const double sortArrowSizeSmall = 13;
  static const double sortArrowSizeMedium = 15;
  static const double sortArrowSizeLarge = 17;
  static const double sortArrowInactiveOpacity = 0.5;
  static const EdgeInsets sortArrowNextPadding = EdgeInsets.only(left: 10, right: 15);

  /// Colors
  Color get rowColor;

  Color get rowSelectedColor;

  Color get checkboxBorderColor;

  Color get spinnerBarrierColor;

  /// Text Styles
  TextStyle get tsHeadingSmall;

  TextStyle get tsDataSmall;

  TextStyle get tsHeadingMedium;

  TextStyle get tsDataMedium;

  TextStyle get tsHeadingLarge;

  TextStyle get tsDataLarge;
}

class FUIDataTable2ThemeLight extends FUIDataTable2Theme {
  FUIThemeCommonColors fuiColors = FUIThemeCommonColorsLight();

  @override
  Color get rowColor => Colors.transparent;

  @override
  Color get rowSelectedColor => fuiColors.shade1;

  @override
  Color get checkboxBorderColor => fuiColors.shade3;

  @override
  Color get spinnerBarrierColor => fuiColors.shade0.withValues(alpha: 0.6);

  @override
  TextStyle get tsHeadingSmall => const TextStyle(
        fontFamily: FUITypographyTheme.fontFamilyPrimary,
        fontSize: FUIDataTable2Theme.fontSizeHeadingSmall,
        fontWeight: FontWeight.w600,
        decoration: TextDecoration.none,
      );

  @override
  TextStyle get tsDataSmall => TextStyle(
        fontFamily: FUITypographyTheme.fontFamilyPrimary,
        fontSize: FUIDataTable2Theme.fontSizeDataSmall,
        fontWeight: FontWeight.w400,
        color: fuiColors.textBody,
        decoration: TextDecoration.none,
      );

  @override
  TextStyle get tsHeadingMedium => const TextStyle(
        fontFamily: FUITypographyTheme.fontFamilyPrimary,
        fontSize: FUIDataTable2Theme.fontSizeHeadingMedium,
        fontWeight: FontWeight.w600,
        decoration: TextDecoration.none,
      );

  @override
  TextStyle get tsDataMedium => TextStyle(
        fontFamily: FUITypographyTheme.fontFamilyPrimary,
        fontSize: FUIDataTable2Theme.fontSizeDataMedium,
        fontWeight: FontWeight.w400,
        color: fuiColors.textBody,
        decoration: TextDecoration.none,
      );

  @override
  TextStyle get tsHeadingLarge => const TextStyle(
        fontFamily: FUITypographyTheme.fontFamilyPrimary,
        fontSize: FUIDataTable2Theme.fontSizeHeadingLarge,
        fontWeight: FontWeight.w600,
        decoration: TextDecoration.none,
      );

  @override
  TextStyle get tsDataLarge => TextStyle(
        fontFamily: FUITypographyTheme.fontFamilyPrimary,
        fontSize: FUIDataTable2Theme.fontSizeDataLarge,
        fontWeight: FontWeight.w400,
        color: fuiColors.textBody,
        decoration: TextDecoration.none,
      );
}
