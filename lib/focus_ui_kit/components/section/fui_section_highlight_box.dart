import 'package:color_shade/color_shade.dart';
import 'package:flutter/material.dart';

import '../../exports.dart';

class FUISectionHighlightBox extends StatelessWidget with FUIColorMixin {
  final FUIColorScheme fuiColorScheme;
  final EdgeInsets? padding;
  final double? width;
  final double? height;
  final BoxDecoration? decoration;
  final BoxConstraints? constraints;
  final Widget child;

  FUISectionHighlightBox({
    Key? key,
    this.fuiColorScheme = FUIColorScheme.lightGrey,
    this.padding,
    this.width,
    this.height,
    this.decoration,
    this.constraints,
    required this.child,
  }) : super(key: key ?? UniqueKey());

  @override
  Widget build(BuildContext context) {
    FUITypographyTheme typoTheme = context.theme.fuiTypography;
    Color borderColor = discernColorByScheme(context, fuiColorScheme: fuiColorScheme);
    Color backgroundColor = borderColor.shade300;
    Color foregroundColor = discernForegroundColorByScheme(context, fuiColorScheme: fuiColorScheme);

    Widget w = IconTheme.merge(
      data: const IconThemeData(
        size: FUISectionTheme.highlightBoxDefaultIconSize,
      ),
      child: DefaultTextStyle(
        style: typoTheme.regular.copyWith(color: foregroundColor),
        child: child,
      ),
    );

    return Container(
      width: width,
      height: height,
      padding: padding ?? FUISectionTheme.highlightBoxPadding,
      decoration: decoration ??
          BoxDecoration(
            border: Border.all(
              color: borderColor,
              width: FUISectionTheme.highlightBoxBorderThickness,
            ),
            color: backgroundColor,
          ),
      constraints: constraints,
      child: w,
    );
  }
}
