import 'package:flutter/material.dart';

import '../../exports.dart';

abstract class FUISectionTheme {

  /// For Sections
  static const double commonPaddingValue = 25;
  static const double parallaxHeight = 400;

  static const EdgeInsets eiSecPaddingAll = EdgeInsets.all(commonPaddingValue);
  static const EdgeInsets eiSecPaddingMore = EdgeInsets.all(commonPaddingValue * 2);
  static const EdgeInsets eiSecPaddingOnlyHorizontal = EdgeInsets.only(left: commonPaddingValue, right: commonPaddingValue, top: 0, bottom: 0);
  static const EdgeInsets eiSecPaddingOnlyVertical = EdgeInsets.only(left: 0, right: 0, top: commonPaddingValue, bottom: commonPaddingValue);
  static const EdgeInsets eiSecPaddingZeroTop = EdgeInsets.only(left: commonPaddingValue, right: commonPaddingValue, top: 0, bottom: commonPaddingValue);
  static const EdgeInsets eiSecPaddingZeroBottom = EdgeInsets.only(left: commonPaddingValue, right: commonPaddingValue, top: commonPaddingValue, bottom: 0);
  static const EdgeInsets eiSecPaddingZeroTopBottom = EdgeInsets.only(left: commonPaddingValue, right: commonPaddingValue, top: 0, bottom: 0);

  /// For Section Containers
  static const EdgeInsets eiSecContainerPaddingAll = EdgeInsets.all(commonPaddingValue);
  static const EdgeInsets eiSecContainerPaddingMore = EdgeInsets.all(commonPaddingValue * 2);
  static const EdgeInsets eiSecContainerPaddingOnlyHorizontal = EdgeInsets.only(left: commonPaddingValue, right: commonPaddingValue, top: 0, bottom: 0);
  static const EdgeInsets eiSecContainerPaddingOnlyVertical = EdgeInsets.only(left: 0, right: 0, top: commonPaddingValue, bottom: commonPaddingValue);
  static const EdgeInsets eiSecContainerPaddingZeroTop = EdgeInsets.only(left: commonPaddingValue, right: commonPaddingValue, top: 0, bottom: commonPaddingValue);
  static const EdgeInsets eiSecContainerPaddingZeroBottom = EdgeInsets.only(left: commonPaddingValue, right: commonPaddingValue, top: commonPaddingValue, bottom: 0);

  /// Colors
  Color get section1;
  Color get section2;

  /// For Highlight Box
  static const EdgeInsets highlightBoxPadding = EdgeInsets.all(commonPaddingValue);
  static const double highlightBoxBorderThickness = 2;
  static const double highlightBoxDefaultIconSize = 60;
}

class FUISectionThemeLight extends FUISectionTheme {

  FUIThemeCommonColors colors = FUIThemeCommonColorsLight();

  /// Colors
  @override Color get section1 => colors.shade0;
  @override Color get section2 => colors.shade1;

}