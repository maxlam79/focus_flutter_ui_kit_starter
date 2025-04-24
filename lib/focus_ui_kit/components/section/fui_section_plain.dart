import 'package:flutter/material.dart';
import 'package:responsive_grid/responsive_grid.dart';

import '../../exports.dart';

class FUISectionPlain extends StatefulWidget {
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final Color? backgroundColor;
  final Widget child;
  final FUISectionHorizontalSpace horizontalSpace;
  final BoxConstraints? constraints;

  FUISectionPlain({
    Key? key,
    required this.child,
    this.backgroundColor,
    this.margin,
    this.padding,
    this.horizontalSpace = FUISectionHorizontalSpace.full,
    this.constraints,
  }) : super(key: key ?? UniqueKey());

  @override
  State<FUISectionPlain> createState() => _FUISectionPlainState();
}

class _FUISectionPlainState extends State<FUISectionPlain> {
  /// Theme
  late FUIThemeCommonColors fuiColors;

  @override
  Widget build(BuildContext context) {
    fuiColors = context.theme.fuiColors;
    EdgeInsets dMargin = widget.margin ?? EdgeInsets.zero;
    Color dBackgroundColor = widget.backgroundColor ?? fuiColors.bg0;
    EdgeInsets dPadding = widget.padding ??
        responsiveValue(
          context,
          md: FUISectionTheme.eiSecPaddingAll,
          sm: FUISectionTheme.eiSecPaddingAll.copyWith(left: 0, right: 0),
          xs: FUISectionTheme.eiSecPaddingAll.copyWith(left: 0, right: 0),
        );

    return Container(
      constraints: widget.constraints,
      decoration: BoxDecoration(
        color: dBackgroundColor,
        border: Border.all(
          width: 0.0,
          style: BorderStyle.none,
        ),
      ),
      margin: dMargin,
      padding: dPadding,
      child: _discernHorizontalSpace(),
    );
  }

  Widget _discernHorizontalSpace() {
    /// Full
    if (widget.horizontalSpace == FUISectionHorizontalSpace.full) {
      return widget.child;
    }

    /// Focus
    else if (widget.horizontalSpace == FUISectionHorizontalSpace.focus) {
      return ResponsiveGridRow(
        children: [
          ResponsiveGridCol(
            md: 0,
            lg: 1,
            child: const SizedBox.shrink(),
          ),
          ResponsiveGridCol(
            md: 12,
            lg: 10,
            child: ResponsiveGridRow(
              children: [
                ResponsiveGridCol(
                  child: widget.child,
                ),
              ],
            ),
          ),
          ResponsiveGridCol(
            md: 0,
            lg: 1,
            child: const SizedBox.shrink(),
          ),
        ],
      );
    }

    /// Tight
    else {
      return ResponsiveGridRow(
        children: [
          ResponsiveGridCol(
            md: 0,
            lg: 2,
            child: const SizedBox.shrink(),
          ),
          ResponsiveGridCol(
            md: 12,
            lg: 8,
            child: ResponsiveGridRow(
              children: [
                ResponsiveGridCol(
                  child: widget.child,
                ),
              ],
            ),
          ),
          ResponsiveGridCol(
            md: 0,
            lg: 2,
            child: const SizedBox.shrink(),
          ),
        ],
      );
    }
  }
}
