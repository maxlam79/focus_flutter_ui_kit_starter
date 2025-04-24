import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

abstract class FUISpinnerTheme {
  /// Sizes
  static const IconData defaultIcon = LineAwesome.circle_notch_solid;
  static const double defaultSize = 30;
  static const EdgeInsets padding = EdgeInsets.all(10);

  /// Animation
  static const Duration rotationAniDuration = Duration(seconds: 50);
  static const Curve rotationAniCurve = Curves.linear;
}

class FUISpinnerThemeLight extends FUISpinnerTheme {}
