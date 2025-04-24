import 'package:flutter/material.dart';
import 'package:indent/indent.dart';

import '../../exports.dart';

mixin FUITypographyHelper {
  String liBullet(String text) {
    return '\u00B7  $text';
  }

  String liDash(String text) {
    return '\u2013  $text';
  }

  String liSquare(String text) {
    return '\u25AA  $text';
  }

  String indent(String text, {int indentSize = FUITypographyTheme.indentSpace}) {
    return text.indent(indentSize);
  }

  generate({
    required Widget text,
    required TextStyle textStyle,
    required EdgeInsets padding,
  }) {
    return Padding(
      padding: padding,
      child: IconTheme.merge(
        data: IconThemeData(
          color: textStyle.color,
          size: textStyle.fontSize,
        ),
        child: DefaultTextStyle(
          style: textStyle,
          child: text,
        ),
      ),
    );
  }
}
