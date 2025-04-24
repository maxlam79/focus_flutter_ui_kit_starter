import 'package:flutter/material.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/a11y-dark.dart';

import '../../exports.dart';

class FUICodeDisplayBox extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;

  /// Refer to: https://github.com/git-touch/highlight.dart/tree/master/highlight/lib/languages
  /// E.g. For Dart syntax highlight (dart.dart) -> lang = 'dart';
  final String lang;

  /// Refer to: https://github.com/git-touch/highlight.dart/tree/master/flutter_highlight/lib/themes
  /// E.g. monokai-sublime.dart -> theme = monokaiSublimeTheme; (It's a map value).
  final Map<String, TextStyle> theme;

  final double? width, height;

  FUICodeDisplayBox({
    Key? key,
    required this.text,
    this.textStyle,
    required this.lang,
    this.theme = a11yDarkTheme,
    this.width,
    this.height,
  }) : super(key: key ?? UniqueKey());

  @override
  Widget build(BuildContext context) {
    FUICodeDisplayBoxTheme fuiCDBTheme = context.theme.fuiCodeDisplayBox;

    double minWidth = (width == null) ? double.infinity : width!;
    double maxWidth = (width == null) ? double.infinity : width!;
    double minHeight = (height == null) ? 0.0 : height!;
    double maxHeight = (height == null) ? double.infinity : height!;

    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: minWidth,
        maxWidth: maxWidth,
        minHeight: minHeight,
        maxHeight: maxHeight,
      ),
      child: HighlightView(
        text,
        language: lang,
        theme: theme,
        padding: FUICodeDisplayBoxTheme.paddingCodeDisplayBox,
        textStyle: textStyle ?? fuiCDBTheme.tsCodeDisplayBox,
      ),
    );
  }
}
