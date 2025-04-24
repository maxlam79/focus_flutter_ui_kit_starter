import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

import '../../exports.dart';

mixin FUIButtonMixin {
  /// Attributes and flags
  bool enabled = true;

  // bool hovered = false;

  discernFUIButtonEvents(dynamic widget, FUIButtonEvent? event) {
    if (event != null) {
      if (event.enable != null) {
        if (enabled != event.enable) {
          enabled = event.enable!;
        }
      }
    }
  }

  Widget buildIconTextWidget({
    required Widget text,
    required TextStyle tStyle,
    Widget? icon,
    required FUIButtonSize fuiButtonSize,
    required FUIButtonTextIconPosition fuiButtonTextIconPosition,
  }) {
    final Widget iconTextWidget;
    List<Widget> wList = [];
    late SizedBox hSpace, vSpace;

    switch (fuiButtonSize) {
      case FUIButtonSize.small:
        hSpace = FUISpacer.hSpace3;
        vSpace = FUISpacer.vSpace3;
        break;
      case FUIButtonSize.large:
        hSpace = FUISpacer.hSpace10;
        vSpace = FUISpacer.vSpace10;
        break;
      case FUIButtonSize.medium:
      default:
        hSpace = FUISpacer.hSpace6;
        vSpace = FUISpacer.vSpace6;
        break;
    }

    switch (fuiButtonTextIconPosition) {
      case FUIButtonTextIconPosition.iconRightTextLeft:
        wList.add(DefaultTextStyle(
          style: tStyle,
          child: text,
        ));

        if (icon != null) {
          Widget w = IconTheme.merge(
            data: const IconThemeData().copyWith(
              color: tStyle.color,
              size: discernIconSize(fuiButtonSize),
            ),
            child: icon,
          );

          wList.add(hSpace);
          wList.add(w);
        }

        iconTextWidget = Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: wList,
        );
        break;
      case FUIButtonTextIconPosition.iconLeftTextRight:
      default:
        if (icon != null) {
          Widget w = IconTheme.merge(
            data: const IconThemeData().copyWith(
              color: tStyle.color,
              size: discernIconSize(fuiButtonSize),
            ),
            child: icon,
          );

          wList.add(w);
          wList.add(hSpace);
        }

        wList.add(DefaultTextStyle(
          style: tStyle,
          child: text,
        ));

        iconTextWidget = Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: wList,
        );
        break;
    }

    return iconTextWidget;
  }

  OutlinedBorder discernShape(FUIButtonShape fuiButtonShape) {
    switch (fuiButtonShape) {
      case FUIButtonShape.rounded:
        return RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(FUIButtonTheme.shapeRoundedBorderRadius), // <-- Radius
        );
      case FUIButtonShape.square:
      default:
        return RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(FUIButtonTheme.shapeSquareBorderRadius), // <-- Radius
        );
    }
  }

  Tuple2<double, double> discernWidthHeight(dynamic widget, TextStyle tStyle) {
    double cWidth, cHeight;

    Text t = widget.text;

    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: t.data, style: t.style ?? tStyle),
      textDirection: TextDirection.ltr,
      textScaler: TextScaler.linear(WidgetsBinding.instance.platformDispatcher.textScaleFactor),
      // textScaleFactor: WidgetsBinding.instance.platformDispatcher.textScaleFactor,
    )..layout();

    switch (widget.fuiButtonTextIconPosition) {
      // case FUIButtonTextIconPosition.iconTopTextBottom:
      // case FUIButtonTextIconPosition.iconBottomTextTop:
      //   if (widget.icon != null) {
      //     cHeight = textPainter.height + FUIButtonTheme.heightSpacerForCalc + discernIconSize(widget.fuiButtonSize);
      //   } else {
      //     cHeight = textPainter.height + FUIButtonTheme.heightSpacerForCalc;
      //   }
      //
      //   cWidth = textPainter.width + FUIButtonTheme.widthSpacerForCalc;
      //   break;
      case FUIButtonTextIconPosition.iconLeftTextRight:
      case FUIButtonTextIconPosition.iconRightTextLeft:
      default:
        if (widget.icon != null) {
          cWidth = textPainter.width + FUIButtonTheme.widthSpacerForCalc + discernIconSize(widget.fuiButtonSize);
        } else {
          cWidth = textPainter.width + FUIButtonTheme.widthSpacerForCalc;
        }

        cHeight = textPainter.height + FUIButtonTheme.heightSpacerForCalc;
        break;
    }

    switch (widget.fuiButtonSize) {
      case FUIButtonSize.small:
        // cWidth = cWidth * FUIButtonTheme.widthFactorSmall;
        // cHeight = cHeight * FUIButtonTheme.heightFactorSmall;
        cWidth = cWidth + FUIButtonTheme.widthBufferSmall;
        cHeight = cHeight + FUIButtonTheme.heightBufferSmall;
        break;
      case FUIButtonSize.large:
        // cWidth = cWidth * FUIButtonTheme.widthFactorLarge;
        // cHeight = cHeight * FUIButtonTheme.heightFactorLarge;
        cWidth = cWidth + FUIButtonTheme.widthBufferLarge;
        cHeight = cHeight + FUIButtonTheme.heightBufferLarge;
        break;
      case FUIButtonSize.medium:
      default:
        // cWidth = cWidth * FUIButtonTheme.widthFactorMedium;
        // cHeight = cHeight * FUIButtonTheme.heightFactorMedium;
        cWidth = cWidth + FUIButtonTheme.widthBufferMedium;
        cHeight = cHeight + FUIButtonTheme.heightBufferMedium;
        break;
    }

    return Tuple2(cWidth, cHeight);
  }

  Tuple2<TextStyle, Color> discernTextStyleBgColor(BuildContext context, dynamic widget, int buttonType) {
    final FUIThemeCommonColors fuiColors = context.theme.fuiColors;
    final FUIButtonTheme fuiButtonTheme = context.theme.fuiButton;
    TextStyle tStyle;
    Color backgroundColor;
    double fontSize = FUIButtonTheme.fontSizeMedium;

    switch (widget.fuiButtonSize) {
      case FUIButtonSize.small:
        fontSize = FUIButtonTheme.fontSizeSmall;
        break;
      case FUIButtonSize.large:
        fontSize = FUIButtonTheme.fontSizeLarge;
        break;
      case FUIButtonSize.medium:
      default:
        fontSize = FUIButtonTheme.fontSizeMedium;
        break;
    }

    switch (widget.fuiColorScheme) {
      case FUIColorScheme.primary:
        tStyle = fuiButtonTheme.textIconButtonWhite.copyWith(fontSize: fontSize);
        backgroundColor = fuiColors.primary;
        break;
      case FUIColorScheme.secondary:
        tStyle = fuiButtonTheme.textIconButtonWhite.copyWith(fontSize: fontSize);
        backgroundColor = fuiColors.secondary;
        break;
      case FUIColorScheme.ruby:
        tStyle = fuiButtonTheme.textIconButtonWhite.copyWith(fontSize: fontSize);
        backgroundColor = fuiColors.namedRuby;
        break;
      case FUIColorScheme.tartOrange:
        tStyle = fuiButtonTheme.textIconButtonWhite.copyWith(fontSize: fontSize);
        backgroundColor = fuiColors.namedTartOrange;
        break;
      case FUIColorScheme.papayaWhip:
        tStyle = fuiButtonTheme.textIconButtonBlack.copyWith(fontSize: fontSize);
        backgroundColor = fuiColors.namedPapayaWhip;
        break;
      case FUIColorScheme.opal:
        tStyle = fuiButtonTheme.textIconButtonBlack.copyWith(fontSize: fontSize);
        backgroundColor = fuiColors.namedPapayaWhip;
        break;
      case FUIColorScheme.lightGrey:
        tStyle = fuiButtonTheme.textIconButtonBlack.copyWith(fontSize: fontSize);
        backgroundColor = fuiColors.namedLightGrey;
        break;
      case FUIColorScheme.purple:
        tStyle = fuiButtonTheme.textIconButtonWhite.copyWith(fontSize: fontSize);
        backgroundColor = fuiColors.namedPurple;
        break;
      case FUIColorScheme.berry:
        tStyle = fuiButtonTheme.textIconButtonWhite.copyWith(fontSize: fontSize);
        backgroundColor = fuiColors.namedBerry;
        break;
      case FUIColorScheme.cobalt:
        tStyle = fuiButtonTheme.textIconButtonWhite.copyWith(fontSize: fontSize);
        backgroundColor = fuiColors.namedCobalt;
        break;
      case FUIColorScheme.teal:
        tStyle = fuiButtonTheme.textIconButtonWhite.copyWith(fontSize: fontSize);
        backgroundColor = fuiColors.namedTeal;
        break;
      case FUIColorScheme.black:
        tStyle = fuiButtonTheme.textIconButtonWhite.copyWith(fontSize: fontSize);
        backgroundColor = fuiColors.namedBlack;
        break;
      case FUIColorScheme.denim:
        tStyle = fuiButtonTheme.textIconButtonWhite.copyWith(fontSize: fontSize);
        backgroundColor = fuiColors.namedDenim;
        break;
      case FUIColorScheme.prussian:
        tStyle = fuiButtonTheme.textIconButtonWhite.copyWith(fontSize: fontSize);
        backgroundColor = fuiColors.namedPrussian;
        break;
      case FUIColorScheme.bumbleBee:
        tStyle = fuiButtonTheme.textIconButtonBlack.copyWith(fontSize: fontSize);
        backgroundColor = fuiColors.namedBumbleBee;
        break;
      case FUIColorScheme.banana:
        tStyle = fuiButtonTheme.textIconButtonBlack.copyWith(fontSize: fontSize);
        backgroundColor = fuiColors.namedBanana;
        break;
      case FUIColorScheme.success:
        tStyle = fuiButtonTheme.textIconButtonWhite.copyWith(fontSize: fontSize);
        backgroundColor = fuiColors.statusSuccess;
        break;
      case FUIColorScheme.complete:
        tStyle = fuiButtonTheme.textIconButtonWhite.copyWith(fontSize: fontSize);
        backgroundColor = fuiColors.statusComplete;
        break;
      case FUIColorScheme.warning:
        tStyle = fuiButtonTheme.textIconButtonBlack.copyWith(fontSize: fontSize);
        backgroundColor = fuiColors.statusWarning;
        break;
      case FUIColorScheme.error:
        tStyle = fuiButtonTheme.textIconButtonWhite.copyWith(fontSize: fontSize);
        backgroundColor = fuiColors.statusError;
        break;
      default:
        tStyle = fuiButtonTheme.textIconButtonWhite.copyWith(fontSize: fontSize);
        backgroundColor = fuiColors.namedRuby;
        break;
    }

    if (buttonType == 2) {
      tStyle = fuiButtonTheme.textIconButtonWhite.copyWith(color: backgroundColor, fontSize: fontSize);
    }

    try {
      if (widget.backgroundColor != null) {
        backgroundColor = widget.backgroundColor;
      }
    } catch (e) {
      // Absorb..
    }

    return Tuple2(tStyle, backgroundColor);
  }

  double discernIconSize(FUIButtonSize fuiButtonSize) {
    switch (fuiButtonSize) {
      case FUIButtonSize.small:
        return FUIButtonTheme.iconSizeSmall;
      case FUIButtonSize.large:
        return FUIButtonTheme.iconSizeLarge;
      case FUIButtonSize.medium:
      default:
        return FUIButtonTheme.iconSizeMedium;
    }
  }

  double discernCircleIconSize(dynamic widget) {
    switch (widget.fuiButtonSize) {
      case FUIButtonSize.small:
        return FUIButtonTheme.circleIconSizeSmall;
      case FUIButtonSize.large:
        return FUIButtonTheme.circleIconSizeLarge;
      case FUIButtonSize.medium:
      default:
        return FUIButtonTheme.circleIconSizeMedium;
    }
  }

  double discernCircleIconPaddingSize(dynamic widget) {
    switch (widget.fuiButtonSize) {
      case FUIButtonSize.small:
        return FUIButtonTheme.circleIconPaddingSizeSmall;
      case FUIButtonSize.large:
        return FUIButtonTheme.circleIconPaddingSizeLarge;
      case FUIButtonSize.medium:
      default:
        return FUIButtonTheme.circleIconPaddingSizeMedium;
    }
  }

  Tuple2<Color, Color> discernCircleIconColor(BuildContext context, dynamic widget, int buttonType) {
    final FUIThemeCommonColors fuiColors = context.theme.fuiColors;
    Color iconColor;
    Color backgroundColor;

    switch (widget.fuiColorScheme) {
      case FUIColorScheme.primary:
        iconColor = fuiColors.shade0;
        backgroundColor = fuiColors.primary;
        break;
      case FUIColorScheme.secondary:
        iconColor = fuiColors.shade0;
        backgroundColor = fuiColors.secondary;
        break;
      case FUIColorScheme.ruby:
        iconColor = fuiColors.shade0;
        backgroundColor = fuiColors.namedRuby;
        break;
      case FUIColorScheme.tartOrange:
        iconColor = fuiColors.shade0;
        backgroundColor = fuiColors.namedTartOrange;
        break;
      case FUIColorScheme.papayaWhip:
        iconColor = fuiColors.shade5;
        backgroundColor = fuiColors.namedPapayaWhip;
        break;
      case FUIColorScheme.opal:
        iconColor = fuiColors.shade5;
        backgroundColor = fuiColors.namedPapayaWhip;
        break;
      case FUIColorScheme.lightGrey:
        iconColor = fuiColors.shade5;
        backgroundColor = fuiColors.namedLightGrey;
        break;
      case FUIColorScheme.purple:
        iconColor = fuiColors.shade0;
        backgroundColor = fuiColors.namedPurple;
        break;
      case FUIColorScheme.berry:
        iconColor = fuiColors.shade0;
        backgroundColor = fuiColors.namedBerry;
        break;
      case FUIColorScheme.cobalt:
        iconColor = fuiColors.shade0;
        backgroundColor = fuiColors.namedCobalt;
        break;
      case FUIColorScheme.teal:
        iconColor = fuiColors.shade0;
        backgroundColor = fuiColors.namedTeal;
        break;
      case FUIColorScheme.black:
        iconColor = fuiColors.shade0;
        backgroundColor = fuiColors.namedBlack;
        break;
      case FUIColorScheme.denim:
        iconColor = fuiColors.shade0;
        backgroundColor = fuiColors.namedDenim;
        break;
      case FUIColorScheme.prussian:
        iconColor = fuiColors.shade0;
        backgroundColor = fuiColors.namedPrussian;
        break;
      case FUIColorScheme.bumbleBee:
        iconColor = fuiColors.shade5;
        backgroundColor = fuiColors.namedBumbleBee;
        break;
      case FUIColorScheme.banana:
        iconColor = fuiColors.shade5;
        backgroundColor = fuiColors.namedBanana;
        break;
      case FUIColorScheme.success:
        iconColor = fuiColors.shade0;
        backgroundColor = fuiColors.statusSuccess;
        break;
      case FUIColorScheme.complete:
        iconColor = fuiColors.shade0;
        backgroundColor = fuiColors.statusComplete;
        break;
      case FUIColorScheme.warning:
        iconColor = fuiColors.shade5;
        backgroundColor = fuiColors.statusWarning;
        break;
      case FUIColorScheme.error:
        iconColor = fuiColors.shade0;
        backgroundColor = fuiColors.statusError;
        break;
      default:
        iconColor = fuiColors.shade0;
        backgroundColor = fuiColors.namedRuby;
        break;
    }

    if (buttonType == 2) {
      iconColor = backgroundColor;
      backgroundColor = fuiColors.shade0;
    }

    return Tuple2(iconColor, backgroundColor);
  }
}
