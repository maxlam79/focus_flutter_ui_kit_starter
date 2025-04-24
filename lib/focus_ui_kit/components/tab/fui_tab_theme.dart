import 'package:flutter/material.dart';

import '../../exports.dart';

abstract class FUITabTheme {
  /// Sizes
  static const double tabHeadIconSize = 14;
  static const double tabHeadHeight = 30;
  static const double defaultMaxHeight = 300;
  static const double defaultMaxWidth = double.infinity;

  /// Tab Pane
  static const FUIAnimationType tabContentAniType = FUIAnimationType.fadeIn;
  static const Duration tabContentAniDuration = Duration(milliseconds: 1000);

  /// Tab Head
  static const double tabHeadLabelFontSize = 14;
  static const EdgeInsets tabHeadLabelPadding = EdgeInsets.all(5);
  static const EdgeInsets tabHeadPadding = EdgeInsets.all(5);
  static const SizedBox tabHeadIconTextHSpace = FUISpacer.hSpace10;
  static const SizedBox tabHeadIconTextVSpace = FUISpacer.vSpace10;

  /// Deco bar
  static const double decoBarHeight = 2;
  static const double decoBarAniCtrlLowerBound = 0;
  static const double decoBarAniCtrlUpperBound = 1;
  static const double decoBarAniLowerBound = 0;
  static const double decoBarAniUpperBound = 100;
  static const double decoBarBorderWidth = 1;
  static const BorderRadius decoBarBorderRadius = BorderRadius.all(Radius.circular(5));
  static const Duration decoBarAniDuration = Duration(milliseconds: 300);
  static const Curve decoBarAniCurve = Curves.decelerate;

  /// Tab Content View
  static const EdgeInsets tabContentViewPadding = EdgeInsets.all(5);

  /// TextStyles
  TextStyle get tsTabHeadLabelActive;
  TextStyle get tsTabHeadLabel;
}

class FUITabThemeLight extends FUITabTheme {
  FUIThemeCommonColors fuiColors = FUIThemeCommonColorsLight();

  @override
  TextStyle get tsTabHeadLabelActive => TextStyle(
        fontFamily: FUITypographyTheme.fontFamilyPrimary,
        fontSize: FUITabTheme.tabHeadLabelFontSize,
        fontWeight: FontWeight.w800,
        color: fuiColors.textHeading,
        decoration: TextDecoration.none,
      );

  @override
  TextStyle get tsTabHeadLabel => TextStyle(
    fontFamily: FUITypographyTheme.fontFamilyPrimary,
    fontSize: FUITabTheme.tabHeadLabelFontSize,
    fontWeight: FontWeight.w700,
    color: fuiColors.shade3,
    decoration: TextDecoration.none,
  );
}
