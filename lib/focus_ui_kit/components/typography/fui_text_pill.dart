import 'package:flutter/material.dart';

import '../../exports.dart';

class FUITextPill extends StatelessWidget with FUIColorMixin {
  final Text text;
  final FUIColorScheme fuiColorScheme;
  final FUITextPillShape pillShape;
  final FUITextPillSize pillSize;
  final Color? backgroundColor; // Overrides fuiColorScheme's background

  FUITextPill({
    Key? key,
    required this.text,
    this.fuiColorScheme = FUIColorScheme.primary,
    this.pillShape = FUITextPillShape.rounded,
    this.pillSize = FUITextPillSize.medium,
    this.backgroundColor,
  }) : super(key: key ?? UniqueKey());

  @override
  Widget build(BuildContext context) {
    Color bgColor = backgroundColor ?? discernColorByScheme(context, fuiColorScheme: fuiColorScheme);
    TextStyle tStyle = text.style ?? _discernTextStyle(context, fuiColorScheme, pillSize);

    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text.data ?? ' ', style: tStyle),
      textDirection: TextDirection.ltr,
      textScaler: TextScaler.linear(WidgetsBinding.instance.platformDispatcher.textScaleFactor),
      // textScaleFactor: WidgetsBinding.instance.platformDispatcher.textScaleFactor,
    )..layout();

    double cPlusWidth, cPlusHeight;
    EdgeInsets padding;

    switch (pillSize) {
      case FUITextPillSize.small:
        cPlusWidth = FUITextPillTheme.containerPlusWidthSmall;
        cPlusHeight = FUITextPillTheme.containerPlusHeightSmall;
        padding = FUITextPillTheme.paddingSmall;
        break;
      case FUITextPillSize.large:
        cPlusWidth = FUITextPillTheme.containerPlusWidthLarge;
        cPlusHeight = FUITextPillTheme.containerPlusHeightLarge;
        padding = FUITextPillTheme.paddingLarge;
        break;
      case FUITextPillSize.medium:
      default:
        cPlusWidth = FUITextPillTheme.containerPlusWidthMedium;
        cPlusHeight = FUITextPillTheme.containerPlusHeightMedium;
        padding = FUITextPillTheme.paddingMedium;
        break;
    }

    final double containerWidth = textPainter.width + cPlusWidth;
    final double containerHeight = textPainter.height + cPlusHeight;

    return Container(
      width: containerWidth,
      height: containerHeight,
      padding: padding,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: (pillShape == FUITextPillShape.rounded) ? FUITextPillTheme.borderRadiusRound : FUITextPillTheme.borderRadiusSquare,
      ),
      child: DefaultTextStyle(
        style: tStyle,
        child: Center(
          child: text,
        ),
      ),
    );
  }

  TextStyle _discernTextStyle(
    BuildContext context,
    FUIColorScheme fuiColorScheme,
    FUITextPillSize pillSize,
  ) {
    TextStyle tStyle;

    switch (fuiColorScheme) {
      case FUIColorScheme.papayaWhip:
      case FUIColorScheme.bumbleBee:
      case FUIColorScheme.lightGrey:
      case FUIColorScheme.banana:
      case FUIColorScheme.warning:
        switch (pillSize) {
          case FUITextPillSize.small:
            tStyle = context.theme.fuiTextPill.textPillBlackSmall;
            break;
          case FUITextPillSize.large:
            tStyle = context.theme.fuiTextPill.textPillBlackLarge;
            break;
          case FUITextPillSize.medium:
          default:
            tStyle = context.theme.fuiTextPill.textPillBlackMedium;
            break;
        }
        break;
      case FUIColorScheme.primary:
      case FUIColorScheme.secondary:
      case FUIColorScheme.ruby:
      case FUIColorScheme.tartOrange:
      case FUIColorScheme.opal:
      case FUIColorScheme.purple:
      case FUIColorScheme.berry:
      case FUIColorScheme.cobalt:
      case FUIColorScheme.teal:
      case FUIColorScheme.black:
      case FUIColorScheme.denim:
      case FUIColorScheme.prussian:
      case FUIColorScheme.success:
      case FUIColorScheme.complete:
      case FUIColorScheme.error:
      default:
        switch (pillSize) {
          case FUITextPillSize.small:
            tStyle = context.theme.fuiTextPill.textPillWhiteSmall;
            break;
          case FUITextPillSize.large:
            tStyle = context.theme.fuiTextPill.textPillWhiteLarge;
            break;
          case FUITextPillSize.medium:
          default:
            tStyle = context.theme.fuiTextPill.textPillWhiteMedium;
            break;
        }
        break;
    }

    return tStyle;
  }
}
