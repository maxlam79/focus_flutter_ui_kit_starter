import 'package:flutter/cupertino.dart';

abstract class FUIPaneTheme {
  static const double defaultHeight = 400;
  static const double defaultWidth = double.infinity;
  static const EdgeInsets contentPadding = EdgeInsets.all(25);
  static const double opacityDuringDisabled = 0.6;
  static const Duration opacityAniDuration = Duration(milliseconds: 300);
}

class FUIPaneThemeLight extends FUIPaneTheme {}
