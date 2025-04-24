import 'package:flutter/material.dart';

import '../../exports.dart';

abstract class FUIMenuTheme {

  /// Menu Drawer
  static const double contentLeftMargin = 30;
  static const double drawerWidth = 350;
  static const double closeBtnTopMargin = 20;

  static const EdgeInsets marginCloseBtn = EdgeInsets.only(left: 30, top: 20,);
  static const EdgeInsets marginTitleRow = EdgeInsets.only(left: 30, top: 50, bottom: 30);
  static const EdgeInsets marginFooter1 = EdgeInsets.only(bottom: 15, right: 15);
  static const EdgeInsets marginFooter2 = EdgeInsets.only(bottom: 5);

  /// Font Sizes
  static const double fontSizeMenuTitle = 44;
  static const double fontSizeMenuMainCat = 22;
  static const double fontSizeMenuSubCat = 16;
  static const double fontSizeMenuFooter = 11;

  /// Manu Item
  static const double menuItemMarginTop = 10;
  static const double menuItemMarginLeft = 30;
  static const double menuItemTextIconSpace = 12;
  static const double menuItemIconWidth = fontSizeMenuMainCat;
  static const double menuItemHeight = 40;

  /// Sub-Menu Item
  static const double subMenuItemMarginLeft = 30;
  static const double subMenuItemTextIconSpace = 18;
  static const double subMenuIconWidth = fontSizeMenuSubCat;
  static const double subMenuItemHeight = 35;

  /// Colors
  Color get menuTitle;
  Color get menuSubTitle;
  Color get menuMainCat;
  Color get menuMainCatSelected;
  Color get menuSubCat;

  Color get menuSubCatSelected;

  /// Text Style
  TextStyle get mainMenuTitle;
  TextStyle get mainMenuMainCatText;
  TextStyle get mainMenuMainCatTextSelected;
  TextStyle get mainMenuSubCatText;
  TextStyle get mainMenuSubCatTextSelected;
  TextStyle get mainMenuFooter;
}

class FUIMenuThemeLight extends FUIMenuTheme {
  FUIThemeCommonColors colors = FUIThemeCommonColorsLight();

  /// Colors
  @override
  Color get menuTitle => colors.secondary;

  @override
  Color get menuSubTitle => colors.secondary;

  @override
  Color get menuMainCat => colors.secondary;

  @override
  Color get menuMainCatSelected => colors.primary;

  @override
  Color get menuSubCat => colors.shade3;

  @override
  Color get menuSubCatSelected => colors.primary;

  /// *** For Left/Main Menu ***
  @override
  TextStyle get mainMenuTitle => TextStyle(
        fontFamily: FUITypographyTheme.fontFamilyPrimary,
        fontSize: FUIMenuTheme.fontSizeMenuTitle,
        fontWeight: FontWeight.w700,
        color: menuTitle,
      );

  @override
  TextStyle get mainMenuMainCatText => TextStyle(
        fontFamily: FUITypographyTheme.fontFamilyPrimary,
        fontSize: FUIMenuTheme.fontSizeMenuMainCat,
        fontWeight: FontWeight.w700,
        color: menuMainCat,
      );

  @override
  TextStyle get mainMenuMainCatTextSelected => TextStyle(
        fontFamily: FUITypographyTheme.fontFamilyPrimary,
        fontSize: FUIMenuTheme.fontSizeMenuMainCat,
        fontWeight: FontWeight.w900,
        color: menuMainCatSelected,
      );

  @override
  TextStyle get mainMenuSubCatText => TextStyle(
        fontFamily: FUITypographyTheme.fontFamilyPrimary,
        fontSize: FUIMenuTheme.fontSizeMenuSubCat,
        fontWeight: FontWeight.w700,
        color: menuSubCat,
      );

  @override
  TextStyle get mainMenuSubCatTextSelected => TextStyle(
        fontFamily: FUITypographyTheme.fontFamilyPrimary,
        fontSize: FUIMenuTheme.fontSizeMenuSubCat,
        fontWeight: FontWeight.w700,
        color: menuSubCatSelected,
      );

  @override
  TextStyle get mainMenuFooter => TextStyle(
        fontFamily: FUITypographyTheme.fontFamilyPrimary,
        fontSize: FUIMenuTheme.fontSizeMenuFooter,
        fontWeight: FontWeight.normal,
        color: colors.textHinted,
      );
}
