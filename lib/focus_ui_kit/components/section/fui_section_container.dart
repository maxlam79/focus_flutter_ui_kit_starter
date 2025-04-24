import 'package:flutter/material.dart';

import '../../exports.dart';

class FUISectionContainer extends StatelessWidget {
  final Color? backgroundColor;
  final Alignment? alignment;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final Widget child;
  final BoxConstraints? constraints;

  FUISectionContainer({
    Key? key,
    required this.child,
    this.backgroundColor = Colors.transparent,
    this.alignment = Alignment.topLeft,
    this.margin,
    this.padding,
    this.constraints,
  }) : super(key: key ?? UniqueKey());

  @override
  Widget build(BuildContext context) {
    final EdgeInsets dMargin = margin ?? EdgeInsets.zero;
    final EdgeInsets dPadding = padding ?? FUISectionTheme.eiSecContainerPaddingAll;

    return Container(
      constraints: constraints,
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(
          width: 0.0,
          style: BorderStyle.none,
        ),
      ),
      alignment: alignment,
      margin: dMargin,
      padding: dPadding,
      child: child,
    );
  }
}
