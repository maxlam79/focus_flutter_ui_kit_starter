import 'package:flutter/material.dart';

abstract class FUIPaceBarTheme {

  /// Sizes & Settings
  static const double paceBarSize = 4;
  static const double paceBarAniCtrlLowerBound = 0;
  static const double paceBarAniCtrlUpperBound = 1;
  static const double paceBarAniLowerBound = 0;
  static const double paceBarAniUpperBound = 100;
  static const double paceBarBorderWidth = 1;
  static const BorderRadius paceBarBorderRadius = BorderRadius.all(Radius.circular(30));
  static const Duration paceBarAniDuration = Duration(milliseconds: 1000);
}

class FUIPaceBarThemeLight extends FUIPaceBarTheme {}
