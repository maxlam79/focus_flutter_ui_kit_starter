import 'package:flutter/material.dart';

import '../../exports.dart';

abstract class FUICodeDisplayBoxTheme {
  static const double fontSize = 13;
  static const EdgeInsets paddingCodeDisplayBox = EdgeInsets.all(12);

  /// Text Styles
  TextStyle get tsCodeDisplayBox;
}

class FUICodeDisplayBoxThemeLight extends FUICodeDisplayBoxTheme {
  @override
  TextStyle get tsCodeDisplayBox => const TextStyle(
        fontFamily: FUITypographyTheme.fontFamilyCodeDisplay,
        fontSize: FUICodeDisplayBoxTheme.fontSize,
        decoration: TextDecoration.none,
      );
}
