import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

import '../../exports.dart';

mixin FUIToastMixin {
  late FUIThemeCommonColors fuiColors;
  late FUIToastTheme fuiToastTheme;

  TextStyle discernTextStyle(
    BuildContext context, {
    FUIColorScheme? fuiToastColorScheme,
    TextStyle? fallbackTextStyle,
  }) {
    fuiColors = context.theme.fuiColors;
    fuiToastTheme = context.theme.fuiToast;

    TextStyle ts;

    switch (fuiToastColorScheme) {
      case FUIColorScheme.primary:
        ts = fuiToastTheme.tsToast12MsgWhite;
        break;
      case FUIColorScheme.secondary:
        ts = fuiToastTheme.tsToast12MsgWhite;
        break;
      case FUIColorScheme.ruby:
        ts = fuiToastTheme.tsToast12MsgWhite;
        break;
      case FUIColorScheme.tartOrange:
        ts = fuiToastTheme.tsToast12MsgWhite;
        break;
      case FUIColorScheme.papayaWhip:
        ts = fuiToastTheme.tsToast12MsgBlack;
        break;
      case FUIColorScheme.opal:
        ts = fuiToastTheme.tsToast12MsgBlack;
        break;
      case FUIColorScheme.lightGrey:
        ts = fuiToastTheme.tsToast12MsgBlack;
        break;
      case FUIColorScheme.purple:
        ts = fuiToastTheme.tsToast12MsgWhite;
        break;
      case FUIColorScheme.berry:
        ts = fuiToastTheme.tsToast12MsgWhite;
        break;
      case FUIColorScheme.cobalt:
        ts = fuiToastTheme.tsToast12MsgWhite;
        break;
      case FUIColorScheme.teal:
        ts = fuiToastTheme.tsToast12MsgWhite;
        break;
      case FUIColorScheme.black:
        ts = fuiToastTheme.tsToast12MsgWhite;
        break;
      case FUIColorScheme.denim:
        ts = fuiToastTheme.tsToast12MsgWhite;
        break;
      case FUIColorScheme.prussian:
        ts = fuiToastTheme.tsToast12MsgWhite;
        break;
      case FUIColorScheme.bumbleBee:
        ts = fuiToastTheme.tsToast12MsgBlack;
        break;
      case FUIColorScheme.banana:
        ts = fuiToastTheme.tsToast12MsgBlack;
        break;
      case FUIColorScheme.success:
        ts = fuiToastTheme.tsToast12MsgWhite;
        break;
      case FUIColorScheme.complete:
        ts = fuiToastTheme.tsToast12MsgWhite;
        break;
      case FUIColorScheme.warning:
        ts = fuiToastTheme.tsToast12MsgBlack;
        break;
      case FUIColorScheme.error:
        ts = fuiToastTheme.tsToast12MsgWhite;
        break;
      default:
        ts = fallbackTextStyle ?? fuiToastTheme.tsToast12MsgWhite;
        break;
    }

    return ts;
  }

  Tuple2<double, double> discernDecoBarWidthHeight(FUIToastDecoBarPosition fuiToastDecoBarPosition) {
    double decoBarWidth, decoBarHeight;

    switch (fuiToastDecoBarPosition) {
      case FUIToastDecoBarPosition.top:
      case FUIToastDecoBarPosition.bottom:
        decoBarWidth = double.infinity;
        decoBarHeight = FUIToastTheme.toast3DecoBarSize;
        break;
      case FUIToastDecoBarPosition.left:
      case FUIToastDecoBarPosition.right:
      default:
        decoBarWidth = FUIToastTheme.toast3DecoBarSize;
        decoBarHeight = double.infinity;
        break;
    }

    return Tuple2(decoBarWidth, decoBarHeight);
  }

  Widget discernRowOrColumn(FUIToastDecoBarPosition fuiToastDecoBarPosition, Widget decoBar, Widget content) {
    switch (fuiToastDecoBarPosition) {
      case FUIToastDecoBarPosition.top:
        return FUIColumn(
          children: [
            decoBar,
            content,
          ],
        );
      case FUIToastDecoBarPosition.bottom:
        return FUIColumn(
          children: [
            content,
            decoBar,
          ],
        );
      case FUIToastDecoBarPosition.right:
        return Row(
          children: [
            content,
            decoBar,
          ],
        );
      case FUIToastDecoBarPosition.left:
      default:
        return Row(
          children: [
            decoBar,
            content,
          ],
        );
    }
  }

  Border discernToastContainerBorder(FUIToastDecoBarPosition fuiToastDecoBarPosition) {
    switch (fuiToastDecoBarPosition) {
      case FUIToastDecoBarPosition.top:
        return Border(
          top: BorderSide.none,
          left: BorderSide(width: FUIToastTheme.toast3BorderThickness, color: fuiToastTheme.toast3BorderColor),
          right: BorderSide(width: FUIToastTheme.toast3BorderThickness, color: fuiToastTheme.toast3BorderColor),
          bottom: BorderSide(width: FUIToastTheme.toast3BorderThickness, color: fuiToastTheme.toast3BorderColor),
        );
      case FUIToastDecoBarPosition.right:
        return Border(
          top: BorderSide(width: FUIToastTheme.toast3BorderThickness, color: fuiToastTheme.toast3BorderColor),
          left: BorderSide(width: FUIToastTheme.toast3BorderThickness, color: fuiToastTheme.toast3BorderColor),
          right: BorderSide.none,
          bottom: BorderSide(width: FUIToastTheme.toast3BorderThickness, color: fuiToastTheme.toast3BorderColor),
        );
      case FUIToastDecoBarPosition.bottom:
        return Border(
          top: BorderSide(width: FUIToastTheme.toast3BorderThickness, color: fuiToastTheme.toast3BorderColor),
          left: BorderSide(width: FUIToastTheme.toast3BorderThickness, color: fuiToastTheme.toast3BorderColor),
          right: BorderSide(width: FUIToastTheme.toast3BorderThickness, color: fuiToastTheme.toast3BorderColor),
          bottom: BorderSide.none,
        );
      case FUIToastDecoBarPosition.none:
        return Border.all(
          width: FUIToastTheme.toast3BorderThickness,
          color: fuiToastTheme.toast3BorderColor,
        );
      case FUIToastDecoBarPosition.left:
      default:
        return Border(
          top: BorderSide(width: FUIToastTheme.toast3BorderThickness, color: fuiToastTheme.toast3BorderColor),
          left: BorderSide.none,
          right: BorderSide(width: FUIToastTheme.toast3BorderThickness, color: fuiToastTheme.toast3BorderColor),
          bottom: BorderSide(width: FUIToastTheme.toast3BorderThickness, color: fuiToastTheme.toast3BorderColor),
        );
    }
  }
}
