import 'package:flutter/cupertino.dart';

abstract class FUITimelineTileTheme {

  /// Size
  static const double defaultIndicatorHeightSmall = 10;
  static const double defaultIndicatorWidthSmall = 10;
  static const double defaultIndicatorHeightMedium = 13;
  static const double defaultIndicatorWidthMedium = 13;
  static const double defaultIndicatorHeightLarge = 15;
  static const double defaultIndicatorWidthLarge = 15;

  static const EdgeInsets defaultIndicatorPaddingSmall = EdgeInsets.all(5);
  static const EdgeInsets defaultIndicatorPaddingMedium = EdgeInsets.all(7);
  static const EdgeInsets defaultIndicatorPaddingLarge = EdgeInsets.all(9);

  static const double defaultLineThicknessSmall = 0.8;
  static const double defaultLineThicknessMedium = 1;
  static const double defaultLineThicknessLarge = 1.3;

}

class FUITimelineTileThemeLight extends FUITimelineTileTheme {

}
