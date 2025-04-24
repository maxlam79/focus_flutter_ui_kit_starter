import 'package:flutter/material.dart';

import '../../layout/fui_spacer.dart';
import '../../theme/fui_theme.dart';
import '../typography/fui_typography_theme.dart';

abstract class FUIAccordionTheme {

  /// Accordion Head
  static const double accordionHeadLabelFontSize = 14;
  static const double accordionHeadIconSize = 14;
  static const double accordionHeadHeight = 30;
  static const EdgeInsets accordionHeadLabelPadding = EdgeInsets.all(12);
  static const EdgeInsets accordionHeadPadding = EdgeInsets.all(5);
  static const SizedBox accordionHeadIconTextHSpace = FUISpacer.hSpace10;
  static const SizedBox accordionHeadIconTextVSpace = FUISpacer.vSpace10;
  static const Duration sideDecoExpAniIconDuration = Duration(milliseconds: 800);
  static const String sideDecoExpAniIconLottiePath = 'assets/lottie/plus-minus.json';
  static const double sideDecoExpAniIconWidth = 15;
  static const double sideDecoExpAniIconHeight = 15;
  static const EdgeInsets sideDecoExpAniIconPadding = EdgeInsets.only(right: 5);

  /// Deco bar
  static const double decoBarThickness = 2;
  static const double decoBarAniCtrlLowerBound = 0;
  static const double decoBarAniCtrlUpperBound = 1;
  static const double decoBarAniLowerBound = 0;
  static const double decoBarAniUpperBound = 100;
  static const double decoBarBorderWidth = 1;
  static const BorderRadius decoBarBorderRadius = BorderRadius.all(Radius.circular(5));
  static const Duration decoBarAniDuration = Duration(milliseconds: 300);
  static const Curve decoBarAniCurve = Curves.decelerate;

  /// Content View
  static const double accordionContentViewHeight = 200;
  static const Duration accordionContentViewAniDuration = Duration(milliseconds: 300);
  static const EdgeInsets accordionContentViewPadding = EdgeInsets.all(5);

  /// Colors
  Color get decoBarActiveColor;
  Color get decoBarInactiveColor;

  /// TextStyles
  TextStyle get tsAccordionHeadLabelExpanded;
  TextStyle get tsAccordionHeadLabel;
}

class FUIAccordionThemeLight extends FUIAccordionTheme {
  FUIThemeCommonColors fuiColors = FUIThemeCommonColorsLight();

  @override
  Color get decoBarActiveColor => fuiColors.primary;

  @override
  Color get decoBarInactiveColor => fuiColors.shade2;

  @override
  TextStyle get tsAccordionHeadLabel => TextStyle(
        fontFamily: FUITypographyTheme.fontFamilyPrimary,
        fontSize: FUIAccordionTheme.accordionHeadLabelFontSize,
        fontWeight: FontWeight.w700,
        color: fuiColors.shade3,
        decoration: TextDecoration.none,
      );

  @override
  TextStyle get tsAccordionHeadLabelExpanded => tsAccordionHeadLabel.copyWith(
        fontWeight: FontWeight.w800,
        color: fuiColors.textHeading,
      );
}
