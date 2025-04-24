import 'package:color_shade/color_shade.dart';
import 'package:flutter/material.dart';

import '../exports.dart';

abstract class FUIThemeCommonColors {

  /// *** General ***
  Color get primary;
  Color get secondary;

  /// *** Background Color Shades ***
  Color get bg0;
  Color get bg1;
  Color get bg2;
  Color get bg3;

  /// *** Black/White shades ***
  Color get shade0;
  Color get shade1;
  Color get shade2;
  Color get shade3;
  Color get shade4;
  Color get shade5;

  /// *** Text ***
  Color get textHeading;
  Color get textBody;
  Color get textHinted;

  /// *** Status ***
  Color get statusSuccess;
  Color get statusComplete;
  Color get statusError;
  Color get statusWarning;

  /// *** Named Colors - Group 1 ***
  Color get namedRuby;
  Color get namedTartOrange;
  Color get namedPapayaWhip;
  Color get namedOpal;
  Color get namedLightGrey;
  List<Color> get colorGrp1;

  /// *** Named Colors - Group 2 ***
  Color get namedPurple;
  Color get namedBerry;
  Color get namedCobalt;
  Color get namedTeal;
  List<Color> get colorGrp2;

  /// *** Named Colors - Group 3 ***
  Color get namedBlack;
  Color get namedDenim;
  Color get namedPrussian;
  Color get namedBumbleBee;
  Color get namedBanana;
  List<Color> get colorGrp3;
}

class FUIThemeCommonColorsLight extends FUIThemeCommonColors {
  /// *** General ***
  @override
  Color get primary => const Color(0xffD81E5B);

  @override
  Color get secondary => const Color(0xff1C1C1C);

  /// *** Background Color Shades ***
  @override
  Color get bg0 => const Color(0xffffffff);

  @override
  Color get bg1 => const Color(0xfff4f5f7);

  @override
  Color get bg2 => const Color(0xfff7f8fa);

  @override
  Color get bg3 => const Color(0xfff3f3f3);

  /// *** Black/White shades ***
  @override
  Color get shade0 => const Color(0xffffffff);

  @override
  Color get shade1 => const Color(0xfff3f3f3);

  @override
  Color get shade2 => const Color(0xffdedede);

  @override
  Color get shade3 => const Color(0xff6c6c6c);

  @override
  Color get shade4 => const Color(0xff3f3f3f);

  @override
  Color get shade5 => const Color(0xff121212);

  /// *** Text ***
  @override
  Color get textHeading => secondary.shade700;

  @override
  Color get textBody => shade4.shade700;

  @override
  Color get textHinted => shade3; // Color(0xff939393);

  /// *** Status ***
  @override
  Color get statusSuccess => const Color(0xff17a36e);

  @override
  Color get statusComplete => const Color(0xff23a2c6);

  @override
  Color get statusError => const Color(0xffcf3236);

  @override
  Color get statusWarning => const Color(0xfff0bd39);

  /// *** Named Colors - Group 1 ***
  @override
  Color get namedRuby => const Color(0xffd81e5b);

  @override
  Color get namedTartOrange => const Color(0xfff0544f);

  @override
  Color get namedPapayaWhip => const Color(0xfffdf0d5);

  @override
  Color get namedOpal => const Color(0xffc6d8d3);

  @override
  Color get namedLightGrey => const Color(0xffdedede);

  @override
  List<Color> get colorGrp1 => [
        namedRuby,
        namedTartOrange,
        namedPapayaWhip,
        namedOpal,
        namedLightGrey,
      ];

  /// *** Named Colors - Group 2 ***
  @override
  Color get namedPurple => const Color(0xff7209B7);

  @override
  Color get namedBerry => const Color(0xff3A0CA3);

  @override
  Color get namedCobalt => const Color(0xff4361EE);

  @override
  Color get namedTeal => const Color(0xff4CC9F0);

  @override
  List<Color> get colorGrp2 => [
        namedPurple,
        namedBerry,
        namedCobalt,
        namedTeal,
      ];

  /// *** Named Colors - Group 3 ***
  @override
  Color get namedBlack => const Color(0xff000814);

  @override
  Color get namedDenim => const Color(0xff001D3D);

  @override
  Color get namedPrussian => const Color(0xff003566);

  @override
  Color get namedBumbleBee => const Color(0xffFFC300);

  @override
  Color get namedBanana => const Color(0xffFFD60A);

  @override
  List<Color> get colorGrp3 => [
        namedBlack,
        namedDenim,
        namedPrussian,
        namedBumbleBee,
        namedBanana,
      ];
}

extension FUITheme on ThemeData {
  /// For now, no dark theme. Perhaps in future, it will be something like:
  ///
  /// FUIThemeCommonColors get fuiColors {
  ///     return (brightness == Brightness.dark) ? FUIThemeCommonColorsDark() : FUIThemeCommonColorsLight();
  ///   }
  ///
  /// Anyway, can't promise anything...just the light theme for now.

  /// Colors
  FUIThemeCommonColors get fuiColors => FUIThemeCommonColorsLight();

  /// Menu
  FUIMenuTheme get fuiMenu => FUIMenuThemeLight();

  /// Text related
  FUITypographyTheme get fuiTypography => FUITypographyThemeLight();

  FUITextPillTheme get fuiTextPill => FUITextPillThemeLight();

  FUIQuoteTheme get fuiQuote => FUIQuoteThemeLight();

  FUICodeDisplayBoxTheme get fuiCodeDisplayBox => FUICodeDisplayBoxThemeLight();

  /// Layout related
  FUISectionTheme get fuiSection => FUISectionThemeLight();

  FUIPaneTheme get fuiPane => FUIPaneThemeLight();

  FUIPanelTheme get fuiPanel => FUIPanelThemeLight();

  /// Buttons related
  FUIButtonTheme get fuiButton => FUIButtonThemeLight();

  /// Input related
  FUIInputTheme get fuiInput => FUIInputThemeLight();

  /// Notification / Toast related
  FUIToastTheme get fuiToast => FUIToastThemeLight();

  /// Modal Related
  FUIModalTheme get fuiModal => FUIModalThemeLight();

  /// Tab Related
  FUITabTheme get fuiTab => FUITabThemeLight();

  /// Accordion Related
  FUIAccordionTheme get fuiAccordion => FUIAccordionThemeLight();

  /// DataTable2 Related
  FUIDataTable2Theme get fuiDataTable2 => FUIDataTable2ThemeLight();

  /// File Upload Related
  FUIFileUploadTheme get fuiFileUpload => FUIFileUploadThemeLight();

  /// Avatar Related
  FUIAvatarTheme get fuiAvatar => FUIAvatarThemeLight();

  /// Calendar Related
  FUICalendarTheme get fuiCalendar => FUICalendarThemeLight();

  /// PopupMenu Related
  FUIPopupMenuTheme get fuiPopupMenu => FUIPopupMenuThemeLight();

  /// Tooltip Related
  FUITooltipTheme get fuiTooltip => FUITooltipThemeLight();

  /// Wizard Related
  FUIWizardTheme get fuiWizard => FUIWizardThemeLight();
}

extension BuildContextExtensions on BuildContext {
  ThemeData get theme => Theme.of(this);
}

class FUIScreenSize {
  static const double mobile = 480;
  static const double tablet = 800;
  static const double desktopFullHd = 1000;
  static const double desktop4k = 2460;
}
