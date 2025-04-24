import 'package:color_shade/color_shade.dart';
import 'package:flutter/material.dart';

import '../../theme/fui_theme.dart';
import '../typography/fui_typography_theme.dart';

abstract class FUIToastTheme {
  /// *** Used by Toast 1 and 2: ***
  /// Size
  static const double toast12FontSize = 12;
  static const double toast12Radius = 10;
  static const double toast12BackgroundOpacity = 0.8;

  /// Defaults
  static const Duration toast12Duration = Duration(seconds: 5);
  static const Duration toast12AnimationDuration = Duration(milliseconds: 300);
  static const EdgeInsets toast12ContainerPadding = EdgeInsets.all(8);
  static const EdgeInsets toast12TextPadding = EdgeInsets.all(10);
  static const EdgeInsets toast12SideIconPadding = EdgeInsets.all(10);
  static const EdgeInsets toast12CloseIconPadding = EdgeInsets.only(left: 30, right: 10, bottom: 10, top: 10);

  /// Text Style
  TextStyle get tsToast12MsgWhite;

  TextStyle get tsToast12MsgBlack;

  /// *** Used by Toast3: ***
  /// Size
  static const double toast3TitleFontSize = 14;
  static const double toast3DescFontSize = 12;
  static const double toast3DecoBarSize = 8;
  static const double toast3CloseIconSize = 16;
  static const double toast3BorderThickness = 1;
  static const double toast3MinWidth = 300;
  static const double toast3BackgroundOpacity = 0.9;

  /// Defaults
  static const Duration toast3Duration = Duration(milliseconds: 2000);
  static const Duration toast3AnimationDuration = Duration(milliseconds: 300);
  static const EdgeInsets toast3Padding = EdgeInsets.all(15);
  static const EdgeInsets toast3Margin = EdgeInsets.only(left: 20, right: 20);
  static const EdgeInsets toast3SideWidgetPadding = EdgeInsets.all(10);
  static const EdgeInsets toast3CloseIconPadding = EdgeInsets.only(
    left: 10,
    right: 10,
    top: 10,
    bottom: 0,
  );
  static const double toast3ContentMaxWidthFactor = 0.7;

  /// Shadow
  // static const double shadowElevate = 25;
  // static const double shadowOffset = 3;
  // static const double shadowSpreadRadius1 = 0;
  // static const double shadowSpreadRadius2 = 2;

  /// Text Style
  TextStyle get tsToast3Title;

  TextStyle get tsToast3Desc;

  /// Colors
  Color get toast3BackgroundColor;

  Color get toast3BorderColor;
// Color get shadowColor1;
// Color get shadowColor2;
// Color get shadowColor3;
// Color get shadowColor4;
}

class FUIToastThemeLight extends FUIToastTheme {
  final FUIThemeCommonColors colors = FUIThemeCommonColorsLight();

  @override
  TextStyle get tsToast12MsgWhite => TextStyle(
        fontFamily: FUITypographyTheme.fontFamilyPrimary,
        fontSize: FUIToastTheme.toast12FontSize,
        fontWeight: FontWeight.w500,
        color: colors.shade0,
        decoration: TextDecoration.none,
      );

  @override
  TextStyle get tsToast12MsgBlack => TextStyle(
        fontFamily: FUITypographyTheme.fontFamilyPrimary,
        fontSize: FUIToastTheme.toast12FontSize,
        fontWeight: FontWeight.w500,
        color: colors.textHeading,
        decoration: TextDecoration.none,
      );

  @override
  TextStyle get tsToast3Title => TextStyle(
        fontFamily: FUITypographyTheme.fontFamilyPrimary,
        fontSize: FUIToastTheme.toast3TitleFontSize,
        fontWeight: FontWeight.w700,
        color: colors.textHeading,
        decoration: TextDecoration.none,
      );

  @override
  TextStyle get tsToast3Desc => TextStyle(
        fontFamily: FUITypographyTheme.fontFamilyPrimary,
        fontSize: FUIToastTheme.toast3TitleFontSize,
        fontWeight: FontWeight.w500,
        color: colors.textBody,
        decoration: TextDecoration.none,
      );

  @override
  Color get toast3BackgroundColor => colors.shade0.shade100;

  @override
  Color get toast3BorderColor => colors.shade1;
//
// @override
// Color get shadowColor1 => Colors.grey.shade300;
//
// @override
// Color get shadowColor2 => Colors.grey.shade400;
//
// @override
// Color get shadowColor3 => Colors.white;
//
// @override
// Color get shadowColor4 => Colors.white;
}
