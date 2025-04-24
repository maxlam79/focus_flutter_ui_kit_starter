import 'package:flutter/cupertino.dart';

import '../../exports.dart';

abstract class FUICalendarTheme {
  /// Calendar Date Wheel
  static const IconData cdwDefaultLeftArrowIcon = CupertinoIcons.arrowtriangle_left_circle;
  static const IconData cdwDefaultRightArrowIcon = CupertinoIcons.arrowtriangle_right_circle;

  static const double cdwHeight = 110;
  static const Size cdwMonthBoxSize = Size(40, 22);
  static const Size cdwDayBoxSize = Size(40, 20);
  static const Size cdwDateBoxSize = Size(40, 26);

  static const double cdwYearFontSize = 56;
  static const double cdwMonthFontSize = 18;
  static const double cdwDayFontSize = 16;
  static const double cdwDateFontSize = 26;
  static const double cdwPrevYearBtnIconSize = 32;
  static const double cdwNextYearBtnIconSize = 32;
  static const EdgeInsets yearPageBtnPadding = EdgeInsets.only(bottom: 10);

  /// Calendar Date Wheel - TextStyles
  TextStyle get cdwYearTs;
  TextStyle get cdwMonthTs;
  TextStyle get cdwMonthSelectedTs;
  TextStyle get cdwDayTs;
  TextStyle get cdwDaySelectedTs;
  TextStyle get cdwDateTs;
  TextStyle get cdwDateSelectedTs;

  /// Calendar View
  static const EdgeInsets cvPadding = EdgeInsets.all(10);
  static const double cvMinHeight = 200;
  static const EdgeInsets cvTitlePadding = EdgeInsets.only(left: 10, bottom: 10);
  static const double cvDesiredItemWidth = 300;
  static const double cvMinSpacing = 10;
  static const EdgeInsets cvAllDayItemPadding = EdgeInsets.only(left: 10, right: 10);

  /// Calendar Item
  static const double ciContainerMinHeight = 150;
  static const double ciAllDayContainerMinHeight = 80;
  static const EdgeInsets ciContainerPadding = EdgeInsets.all(15);
  static const double ciDateFontSize = 12;
  static const double ciEventNameFontSize = 16;
  static const double ciTimeFontSize = 12;
  static const double ciOptionIconSize = 16;
  static const double ciDescFontSize = 12;
  static const double ciDecoBarThicknessWidth = 2;
  static const double ciTagsSpacing = 5;
  static const BorderRadius ciDecoBarBorderRadius = BorderRadius.all(Radius.circular(5));
  static const double ciAvatarStackMinConverge = -0.1;
  static const double ciAvatarStackMaxConverge = 0.2;
  static const double ciAvatarStackHeight = 38;
  static const double ciBreakFontSize = 14;
  static const double ciBreakBorderWidth = 0.5;
  static const EdgeInsets ciBreakInnerPadding = EdgeInsets.only(top: 15, bottom: 15);
  static const BorderRadius ciBoxBorderRadius = BorderRadius.all(Radius.circular(6));

  /// Calendar Item - Colors
  Color get ciBackgroundColor;
  Color get ciBorderColor;

  /// TCalendar Item - extStyles
  TextStyle get ciDateTs;
  TextStyle get ciEventNameTs;
  TextStyle get ciTimeTs;
  TextStyle get ciVenueTs;
  TextStyle get ciDescTs;
}

class FUICalendarThemeLight extends FUICalendarTheme {
  FUIThemeCommonColors fuiColors = FUIThemeCommonColorsLight();

  /// Calendar Date Wheel
  @override
  TextStyle get cdwYearTs => TextStyle(
        fontFamily: FUITypographyTheme.fontFamilyPrimary,
        fontSize: FUICalendarTheme.cdwYearFontSize,
        fontWeight: FontWeight.w900,
        color: fuiColors.textHeading,
        decoration: TextDecoration.none,
      );

  @override
  TextStyle get cdwMonthTs => TextStyle(
        fontFamily: FUITypographyTheme.fontFamilyPrimary,
        fontSize: FUICalendarTheme.cdwMonthFontSize,
        fontWeight: FontWeight.w900,
        color: fuiColors.textHeading,
        decoration: TextDecoration.none,
      );

  @override
  TextStyle get cdwMonthSelectedTs => TextStyle(
        fontFamily: FUITypographyTheme.fontFamilyPrimary,
        fontSize: FUICalendarTheme.cdwMonthFontSize,
        fontWeight: FontWeight.w900,
        color: fuiColors.primary,
        decoration: TextDecoration.none,
      );

  @override
  TextStyle get cdwDayTs => TextStyle(
        fontFamily: FUITypographyTheme.fontFamilyPrimary,
        fontSize: FUICalendarTheme.cdwDayFontSize,
        fontWeight: FontWeight.w700,
        color: fuiColors.shade3,
        decoration: TextDecoration.none,
      );

  @override
  TextStyle get cdwDaySelectedTs => TextStyle(
        fontFamily: FUITypographyTheme.fontFamilyPrimary,
        fontSize: FUICalendarTheme.cdwDayFontSize,
        fontWeight: FontWeight.w900,
        color: fuiColors.primary,
        decoration: TextDecoration.none,
      );

  @override
  TextStyle get cdwDateTs => TextStyle(
        fontFamily: FUITypographyTheme.fontFamilyPrimary,
        fontSize: FUICalendarTheme.cdwDateFontSize,
        fontWeight: FontWeight.w600,
        color: fuiColors.shade3,
        decoration: TextDecoration.none,
      );

  @override
  TextStyle get cdwDateSelectedTs => TextStyle(
        fontFamily: FUITypographyTheme.fontFamilyPrimary,
        fontSize: FUICalendarTheme.cdwDateFontSize,
        fontWeight: FontWeight.w900,
        color: fuiColors.primary,
        decoration: TextDecoration.none,
      );

  /// Calendar Item
  @override
  Color get ciBackgroundColor => fuiColors.bg0;

  @override
  Color get ciBorderColor => fuiColors.bg0;

  @override
  TextStyle get ciDateTs => TextStyle(
        fontFamily: FUITypographyTheme.fontFamilyPrimary,
        fontSize: FUICalendarTheme.ciDateFontSize,
        fontWeight: FontWeight.normal,
        color: fuiColors.textHinted,
        decoration: TextDecoration.none,
      );

  @override
  TextStyle get ciEventNameTs => TextStyle(
        fontFamily: FUITypographyTheme.fontFamilyPrimary,
        fontSize: FUICalendarTheme.ciEventNameFontSize,
        fontWeight: FontWeight.w700,
        color: fuiColors.textHeading,
        decoration: TextDecoration.none,
      );

  @override
  TextStyle get ciTimeTs => TextStyle(
        fontFamily: FUITypographyTheme.fontFamilyPrimary,
        fontSize: FUICalendarTheme.ciTimeFontSize,
        fontWeight: FontWeight.w600,
        color: fuiColors.textBody,
        decoration: TextDecoration.none,
      );

  @override
  TextStyle get ciVenueTs => TextStyle(
        fontFamily: FUITypographyTheme.fontFamilyPrimary,
        fontSize: FUICalendarTheme.ciTimeFontSize,
        fontWeight: FontWeight.w600,
        color: fuiColors.textBody,
        decoration: TextDecoration.none,
      );

  @override
  TextStyle get ciDescTs => TextStyle(
        fontFamily: FUITypographyTheme.fontFamilyPrimary,
        fontSize: FUICalendarTheme.ciDescFontSize,
        fontWeight: FontWeight.normal,
        color: fuiColors.textBody,
        decoration: TextDecoration.none,
      );
}
