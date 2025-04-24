import 'package:flutter/material.dart';

import '../../exports.dart';

abstract class FUIPanelTheme {
  /// Size
  static const double headerFontSize = 14;
  static const double defaultHeight = 400;
  static const double defaultWidth = double.infinity;

  /// Panel Box Shape Border Radius
  static BorderRadius boxBorderRadius = const BorderRadius.all(Radius.circular(6));

  /// Border thickness
  static const double borderThickness = 1;
  static const double mouseOverBorderThickness = 0.1;
  static const double headerSeparatorThickness = 1;
  static const double footerSeparatorThickness = 1;

  /// Top icon button size
  static double headerIconButtonSize = 16;

  /// Paddings
  static const EdgeInsets headerPadding = EdgeInsets.only(
    left: 25,
    right: 25,
    top: 15,
    bottom: 8,
  );

  static const EdgeInsets headerIconRowPadding = EdgeInsets.only(
    top: 5,
    right: 20,
  );

  static const EdgeInsets panelContentPadding = EdgeInsets.only(
    right: 25,
    left: 25,
    top: 10,
    bottom: 13,
  );

  static const EdgeInsets footerPadding = EdgeInsets.only(
    left: 25,
    right: 25,
    top: 5,
    bottom: 10,
  );

  static const EdgeInsets panelHeaderIconPadding = EdgeInsets.only(
    left: 2,
  );

  /// Mouse over shadow
  static const double mouseOverShadowElevate = 25;
  static const double mouseOverShadowOffset = 3;
  static const double mouseOverShadowSpreadRadius1 = 0;
  static const double mouseOverShadowSpreadRadius2 = 2;

  /// Colors
  Color get headerIconButtonColor;

  Color get mouseOverShadowColor1;

  Color get mouseOverShadowColor2;

  Color get mouseOverShadowColor3;

  Color get mouseOverShadowColor4;

  /// TextStyles
  TextStyle get headingTitle;
}

class FUIPanelThemeLight extends FUIPanelTheme {
  FUIThemeCommonColors fuiColors = FUIThemeCommonColorsLight();

  @override
  Color get headerIconButtonColor => fuiColors.shade3;

  @override
  Color get mouseOverShadowColor1 => Colors.grey.shade300;

  @override
  Color get mouseOverShadowColor2 => Colors.grey.shade400;

  @override
  Color get mouseOverShadowColor3 => Colors.white;

  @override
  Color get mouseOverShadowColor4 => Colors.white;

  @override
  TextStyle get headingTitle => TextStyle(
        fontFamily: FUITypographyTheme.fontFamilyPrimary,
        fontSize: FUIPanelTheme.headerFontSize,
        fontWeight: FontWeight.w800,
        color: fuiColors.textHeading,
        decoration: TextDecoration.none,
        overflow: TextOverflow.ellipsis,
      );
}
