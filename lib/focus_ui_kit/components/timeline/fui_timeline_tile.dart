import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../../exports.dart';

class FUITimelineTile extends StatefulWidget {
  final FUIColorScheme fuiColorScheme;
  final FUITimelineSize fuiTimelineSize;
  final TimelineAlign alignment;
  final TimelineAxis axis;
  final double? lineXY;
  final bool hasIndicator;
  final IndicatorStyle? indicatorStyle;
  final double indicatorXY; // indicatorStyle overrides this...
  final LineStyle? afterLineStyle;
  final LineStyle? beforeLineStyle;
  final bool isFirst;
  final bool isLast;
  final Widget? startChild;
  final Widget? endChild;

  FUITimelineTile({
    Key? key,
    this.fuiColorScheme = FUIColorScheme.primary,
    this.fuiTimelineSize = FUITimelineSize.medium,
    this.alignment = TimelineAlign.start,
    this.axis = TimelineAxis.vertical,
    this.lineXY,
    this.hasIndicator = true,
    this.indicatorStyle,
    this.indicatorXY = 0.5,
    this.afterLineStyle,
    this.beforeLineStyle,
    this.isFirst = false,
    this.isLast = false,
    this.startChild,
    this.endChild,
  }) : super(key: key ?? UniqueKey());

  @override
  State<FUITimelineTile> createState() => _FUITimelineTileState();
}

class _FUITimelineTileState extends State<FUITimelineTile> with FUIColorMixin {
  /// Theme
  late FUIThemeCommonColors fuiColors;

  @override
  Widget build(BuildContext context) {
    fuiColors = context.theme.fuiColors;

    return TimelineTile(
      alignment: widget.alignment,
      axis: widget.axis,
      lineXY: widget.lineXY,
      hasIndicator: widget.hasIndicator,
      indicatorStyle: widget.indicatorStyle ?? _defaultIndicatorStyle(context),
      afterLineStyle: widget.afterLineStyle ?? _defaultLineStyle(context),
      beforeLineStyle: widget.beforeLineStyle ?? _defaultLineStyle(context),
      isFirst: widget.isFirst,
      isLast: widget.isLast,
      startChild: widget.startChild,
      endChild: widget.endChild,
    );
  }

  _defaultIndicatorStyle(BuildContext context) {
    double width, height;
    EdgeInsets padding;

    switch (widget.fuiTimelineSize) {
      case FUITimelineSize.small:
        width = FUITimelineTileTheme.defaultIndicatorWidthSmall;
        height = FUITimelineTileTheme.defaultIndicatorHeightSmall;
        padding = FUITimelineTileTheme.defaultIndicatorPaddingSmall;
        break;
      case FUITimelineSize.large:
        width = FUITimelineTileTheme.defaultIndicatorWidthLarge;
        height = FUITimelineTileTheme.defaultIndicatorHeightLarge;
        padding = FUITimelineTileTheme.defaultIndicatorPaddingLarge;
        break;
      case FUITimelineSize.medium:
      default:
        width = FUITimelineTileTheme.defaultIndicatorWidthMedium;
        height = FUITimelineTileTheme.defaultIndicatorHeightMedium;
        padding = FUITimelineTileTheme.defaultIndicatorPaddingMedium;
        break;
    }

    return IndicatorStyle(
      color: discernColorByScheme(context, fuiColorScheme: widget.fuiColorScheme),
      height: height,
      width: width,
      padding: padding,
      indicatorXY: widget.indicatorXY,
    );
  }

  LineStyle _defaultLineStyle(BuildContext context) {
    double thickness;

    switch (widget.fuiTimelineSize) {
      case FUITimelineSize.small:
        thickness = FUITimelineTileTheme.defaultLineThicknessSmall;
        break;
      case FUITimelineSize.large:
        thickness = FUITimelineTileTheme.defaultLineThicknessLarge;
        break;
      case FUITimelineSize.medium:
      default:
        thickness = FUITimelineTileTheme.defaultLineThicknessMedium;
        break;
    }

    return LineStyle(
      color: fuiColors.shade5,
      thickness: thickness,
    );
  }
}
