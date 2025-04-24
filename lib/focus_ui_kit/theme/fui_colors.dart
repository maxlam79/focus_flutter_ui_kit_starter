import 'package:flutter/material.dart';

import 'fui_theme.dart';

enum FUIColorScheme {
  primary,
  secondary,
  ruby,
  tartOrange,
  papayaWhip,
  opal,
  lightGrey,
  purple,
  berry,
  cobalt,
  teal,
  black,
  denim,
  prussian,
  bumbleBee,
  banana,
  success,
  complete,
  warning,
  error,
}

mixin FUIColorMixin {
  Color discernColorByScheme(
    BuildContext context, {
    FUIColorScheme? fuiColorScheme,
    Color? fallbackColor,
  }) {
    FUIThemeCommonColors fuiColors = context.theme.fuiColors;
    Color color;

    switch (fuiColorScheme) {
      case FUIColorScheme.primary:
        color = fuiColors.primary;
        break;
      case FUIColorScheme.secondary:
        color = fuiColors.secondary;
        break;
      case FUIColorScheme.ruby:
        color = fuiColors.namedRuby;
        break;
      case FUIColorScheme.tartOrange:
        color = fuiColors.namedTartOrange;
        break;
      case FUIColorScheme.papayaWhip:
        color = fuiColors.namedPapayaWhip;
        break;
      case FUIColorScheme.opal:
        color = fuiColors.namedOpal;
        break;
      case FUIColorScheme.lightGrey:
        color = fuiColors.namedLightGrey;
        break;
      case FUIColorScheme.purple:
        color = fuiColors.namedPurple;
        break;
      case FUIColorScheme.berry:
        color = fuiColors.namedBerry;
        break;
      case FUIColorScheme.cobalt:
        color = fuiColors.namedCobalt;
        break;
      case FUIColorScheme.teal:
        color = fuiColors.namedTeal;
        break;
      case FUIColorScheme.black:
        color = fuiColors.namedBlack;
        break;
      case FUIColorScheme.denim:
        color = fuiColors.namedDenim;
        break;
      case FUIColorScheme.prussian:
        color = fuiColors.namedPrussian;
        break;
      case FUIColorScheme.bumbleBee:
        color = fuiColors.namedBumbleBee;
        break;
      case FUIColorScheme.banana:
        color = fuiColors.namedBanana;
        break;
      case FUIColorScheme.success:
        color = fuiColors.statusSuccess;
        break;
      case FUIColorScheme.complete:
        color = fuiColors.statusComplete;
        break;
      case FUIColorScheme.warning:
        color = fuiColors.statusWarning;
        break;
      case FUIColorScheme.error:
        color = fuiColors.statusError;
        break;
      default:
        color = fallbackColor ?? fuiColors.primary;
        break;
    }

    return color;
  }

  Color discernForegroundColorByScheme(
    BuildContext context, {
    FUIColorScheme? fuiColorScheme,
    Color? fallbackColor,
  }) {
    FUIThemeCommonColors fuiColors = context.theme.fuiColors;
    Color color;

    switch (fuiColorScheme) {
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
        color = fuiColors.shade0;
        break;
      case FUIColorScheme.papayaWhip:
      case FUIColorScheme.bumbleBee:
      case FUIColorScheme.lightGrey:
      case FUIColorScheme.banana:
      case FUIColorScheme.warning:
        color = fuiColors.textHeading;
        break;
      default:
        color = fallbackColor ?? fuiColors.textHeading;
        break;
    }

    return color;
  }

  FUIColorScheme stringToColorScheme(String strValue) {
    return FUIColorScheme.values.firstWhere((element) {
      return (element.name == strValue);
    });
  }
}
