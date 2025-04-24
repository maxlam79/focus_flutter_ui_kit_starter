import 'package:flutter/material.dart';

import '../../exports.dart';

abstract class FUIWizardTheme {
  /// Pane
  static const double defaultContentViewHeight = 450;
  static const double defaultPageItemsSectionLeftRightWidth = 200; // Only for left and right positioning
  static const double defaultTabPaddingLeftRight = 20;
  static const double defaultTabPaddingTopBottom = 20;

  /// Label
  static const double labelLine1Style1FontSize = 12;
  static const double labelLine2Style1FontSize = 18;

  static const double labelLine1Style2FontSize = 18;
  static const double labelLine2Style2FontSize = 12;
  static const EdgeInsets labelPadding = EdgeInsets.only(bottom: 5);

  /// Item
  static const double defaultItemSpaceBetween = 25;

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

  /// Text Styles
  TextStyle tsBase = const TextStyle(
    fontFamily: FUITypographyTheme.fontFamilyPrimary,
    decoration: TextDecoration.none,
  );

  TextStyle get tsLabelLine1Style1;

  TextStyle get tsLabelLine2Style1;

  TextStyle get tsLabelLine1Style2;

  TextStyle get tsLabelLine2Style2;
}

class FUIWizardThemeLight extends FUIWizardTheme {
  FUIThemeCommonColors colors = FUIThemeCommonColorsLight();

  @override
  TextStyle get tsLabelLine1Style1 => tsBase.copyWith(
        color: colors.textHeading,
        fontWeight: FontWeight.w800,
        fontSize: FUIWizardTheme.labelLine1Style1FontSize,
      );

  @override
  TextStyle get tsLabelLine2Style1 => tsBase.copyWith(
        color: colors.textBody,
        fontWeight: FontWeight.w400,
        fontSize: FUIWizardTheme.labelLine2Style1FontSize,
      );

  @override
  TextStyle get tsLabelLine1Style2 => tsBase.copyWith(
        color: colors.textHeading,
        fontWeight: FontWeight.w800,
        fontSize: FUIWizardTheme.labelLine1Style2FontSize,
      );

  @override
  TextStyle get tsLabelLine2Style2 => tsBase.copyWith(
        color: colors.textHeading,
        fontWeight: FontWeight.w400,
        fontSize: FUIWizardTheme.labelLine2Style2FontSize,
      );
}
