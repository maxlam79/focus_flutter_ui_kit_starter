import 'package:flutter/cupertino.dart';

import '../../exports.dart';

abstract class FUIPopupMenuTheme {

  /// Defaults
  static const IconData defaultPopupMenuBtnIcon = CupertinoIcons.ellipsis_vertical;

  /// Sizes
  static const double btnIconSize = 14;
  static const double itemIconSize = 14;
  static const double itemFontSize = 14;
  static const double itemHeight = 15;
  static const EdgeInsets itemPadding = EdgeInsets.all(10);

  /// Colors
  Color get btnIconColor;
  Color get itemBackgroundColor;
  Color get itemTextColor;

  /// Text Styles
  TextStyle get itemTs;
}

class FUIPopupMenuThemeLight extends FUIPopupMenuTheme {
  FUIThemeCommonColorsLight fuiColors = FUIThemeCommonColorsLight();

  /// Colors
  @override
  Color get btnIconColor => fuiColors.shade3;

  @override
  Color get itemBackgroundColor => fuiColors.bg0;

  @override
  Color get itemTextColor => fuiColors.shade3;

  /// Text Styles
  @override
  TextStyle get itemTs => TextStyle(
        fontFamily: FUITypographyTheme.fontFamilyPrimary,
        fontSize: FUIPopupMenuTheme.itemFontSize,
        fontWeight: FontWeight.w500,
        color: itemTextColor,
        decoration: TextDecoration.none,
      );
}
