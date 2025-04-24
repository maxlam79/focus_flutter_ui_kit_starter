import 'package:flutter/material.dart';

import '../../exports.dart';

mixin FUIDataTable2Mixin {
  double discernDataRowHeight(FUIDataTable2Size? fuiDataTable2Size) {
    double height;

    switch (fuiDataTable2Size) {
      case FUIDataTable2Size.small:
        height = FUIDataTable2Theme.dataRowHeightSmall;
        break;
      case FUIDataTable2Size.large:
        height = FUIDataTable2Theme.dataRowHeightLarge;
        break;
      case FUIDataTable2Size.medium:
      default:
        height = FUIDataTable2Theme.dataRowHeightMedium;
        break;
    }

    return height;
  }

  double discernHeadingRowHeight(FUIDataTable2Size? fuiDataTable2Size) {
    double height;

    switch (fuiDataTable2Size) {
      case FUIDataTable2Size.small:
        height = FUIDataTable2Theme.headingRowHeightSmall;
        break;
      case FUIDataTable2Size.large:
        height = FUIDataTable2Theme.headingRowHeightLarge;
        break;
      case FUIDataTable2Size.medium:
      default:
        height = FUIDataTable2Theme.headingRowHeightMedium;
        break;
    }

    return height;
  }

  TextStyle discernHeadingTextStyle(BuildContext context, FUIColorScheme? fuiColorScheme, FUIDataTable2Size? fuiDataTable2Size) {
    final FUIThemeCommonColors fuiColors = context.theme.fuiColors;
    final FUIDataTable2Theme fuiDataTable2Theme = context.theme.fuiDataTable2;
    TextStyle tStyle;

    switch (fuiDataTable2Size) {
      case FUIDataTable2Size.small:
        tStyle = fuiDataTable2Theme.tsHeadingSmall;
        break;
      case FUIDataTable2Size.large:
        tStyle = fuiDataTable2Theme.tsHeadingLarge;
        break;
      case FUIDataTable2Size.medium:
      default:
        tStyle = fuiDataTable2Theme.tsHeadingMedium;
        break;
    }

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
        tStyle = tStyle.copyWith(color: fuiColors.shade0);
        break;
      case FUIColorScheme.papayaWhip:
      case FUIColorScheme.bumbleBee:
      case FUIColorScheme.lightGrey:
      case FUIColorScheme.banana:
      case FUIColorScheme.warning:
      default:
        tStyle = tStyle.copyWith(color: fuiColors.textHeading);
        break;
    }

    return tStyle;
  }

  TextStyle discernRowTextStyle(BuildContext context, FUIDataTable2Size? fuiDataTable2Size) {
    final FUIDataTable2Theme fuiDataTable2Theme = context.theme.fuiDataTable2;
    TextStyle tStyle;

    switch (fuiDataTable2Size) {
      case FUIDataTable2Size.small:
        tStyle = fuiDataTable2Theme.tsDataSmall;
        break;
      case FUIDataTable2Size.large:
        tStyle = fuiDataTable2Theme.tsDataLarge;
        break;
      case FUIDataTable2Size.medium:
      default:
        tStyle = fuiDataTable2Theme.tsDataMedium;
        break;
    }

    return tStyle;
  }

  CheckboxThemeData discernHeadingCheckboxTheme(BuildContext context, FUIColorScheme? fuiColorScheme, FUIDataTable2Size? fuiDataTable2Size) {
    Color checkColor = discernHeadingTextStyle(context, fuiColorScheme, fuiDataTable2Size).color!;

    return CheckboxThemeData(
      side: WidgetStateBorderSide.resolveWith((_) => BorderSide(width: 2, color: checkColor)),
      fillColor: WidgetStateProperty.all(Colors.transparent),
      checkColor: WidgetStateProperty.all(checkColor),
      overlayColor: WidgetStateProperty.all(Colors.transparent),
    );
  }

  CheckboxThemeData discernRowCheckboxTheme(BuildContext context, FUIColorScheme? fuiColorScheme) {
    final FUIThemeCommonColors fuiColors = context.theme.fuiColors;
    final FUIDataTable2Theme fuiDataTable2Theme = context.theme.fuiDataTable2;

    Color checkColor = fuiColors.textBody;

    return CheckboxThemeData(
      side: WidgetStateBorderSide.resolveWith((_) => BorderSide(width: 1, color: fuiDataTable2Theme.checkboxBorderColor)),
      fillColor: WidgetStateProperty.all(Colors.transparent),
      checkColor: WidgetStateProperty.all(checkColor),
      overlayColor: WidgetStateProperty.all(Colors.transparent),
    );
  }

  Widget buildEmptyWidget(BuildContext context, String? msg) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Regular(
              Text(msg ?? 'No data available.'),
            ),
          ],
        ),
      ],
    );
  }
}

class FUIDataTableColumnHelper with FUIDataTable2Mixin {
  final BuildContext context;
  final FUIColorScheme fuiColorScheme;
  final FUIDataTable2Size size;

  FUIDataTableColumnHelper(
    this.context, {
    this.fuiColorScheme = FUIColorScheme.primary,
    this.size = FUIDataTable2Size.medium,
  });

  Widget genLabel({
    String? text,
    FUIDataTable2Alignment alignment = FUIDataTable2Alignment.left,
    Widget? widget,
    bool bold = false,
    bool italic = false,
  }) {
    if (text == null && widget == null) {
      throw Exception('Either text or widget must be present. Text value will take precedence before Widget');
    }

    MainAxisAlignment a;

    switch (alignment) {
      case FUIDataTable2Alignment.right:
        a = MainAxisAlignment.end;
        break;
      case FUIDataTable2Alignment.center:
        a = MainAxisAlignment.center;
        break;
      case FUIDataTable2Alignment.left:
      default:
        a = MainAxisAlignment.start;
        break;
    }

    TextStyle tStyle = discernHeadingTextStyle(context, fuiColorScheme, size);

    if (bold) {
      tStyle = tStyle.copyWith(fontWeight: FontWeight.bold);
    }

    if (italic) {
      tStyle = tStyle.copyWith(fontStyle: FontStyle.italic);
    }

    if (text != null) {
      return Row(
        mainAxisAlignment: a,
        children: [
          Flexible(
            child: Text(
              text,
              style: tStyle,
              overflow: TextOverflow.ellipsis,
              softWrap: true,
            ),
          ),
        ],
      );
    } else {
      return DefaultTextStyle(
        style: tStyle,
        child: widget!,
      );
    }
  }
}

class FUIDataTableCellHelper {
  final BuildContext context;
  final FUIColorScheme fuiColorScheme;
  final FUIDataTable2Size size;

  FUIDataTableCellHelper(
    this.context, {
    this.fuiColorScheme = FUIColorScheme.primary,
    this.size = FUIDataTable2Size.medium,
  });

  Widget genData({
    String? text,
    bool selectable = false,
    FUIDataTable2Alignment alignment = FUIDataTable2Alignment.left,
    Widget? widget,
    bool bold = false,
    bool italic = false,
  }) {
    if (text == null && widget == null) {
      throw Exception('Either text or widget must be present. Text value will take precedence before Widget');
    }

    MainAxisAlignment a;

    switch (alignment) {
      case FUIDataTable2Alignment.right:
        a = MainAxisAlignment.end;
        break;
      case FUIDataTable2Alignment.center:
        a = MainAxisAlignment.center;
        break;
      case FUIDataTable2Alignment.left:
      default:
        a = MainAxisAlignment.start;
        break;
    }

    FUIDataTable2Theme fuiDataTable2Theme = context.theme.fuiDataTable2;
    TextStyle tStyle;

    switch (size) {
      case FUIDataTable2Size.small:
        tStyle = fuiDataTable2Theme.tsDataSmall;
        break;
      case FUIDataTable2Size.large:
        tStyle = fuiDataTable2Theme.tsDataLarge;
        break;
      case FUIDataTable2Size.medium:
      default:
        tStyle = fuiDataTable2Theme.tsDataMedium;
        break;
    }

    if (bold) {
      tStyle = tStyle.copyWith(fontWeight: FontWeight.bold);
    }

    if (italic) {
      tStyle = tStyle.copyWith(fontStyle: FontStyle.italic);
    }

    if (text != null) {
      Widget tWidget = selectable
          ? SelectableText(
              text,
              style: tStyle,
              maxLines: 1,
            )
          : Flexible(
              child: Text(
                text,
                style: tStyle,
                overflow: TextOverflow.ellipsis,
                softWrap: true,
              ),
            );

      return Row(
        mainAxisAlignment: a,
        children: [tWidget],
      );
    } else {
      return DefaultTextStyle(
        style: tStyle,
        child: widget!,
      );
    }
  }
}
