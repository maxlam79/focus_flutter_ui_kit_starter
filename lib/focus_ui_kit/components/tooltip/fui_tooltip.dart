import 'package:flutter/material.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';
import 'package:just_the_tooltip/src/positioned_tooltip.dart';

import '../../exports.dart';

class FUITooltip extends StatefulWidget {
  final FUIColorScheme fuiColorScheme;
  final FUITooltipSize fuiTooltipSize;
  final Widget? tooltip;
  final Widget child;
  final JustTheController? controller;
  final VoidCallback? onDismiss;
  final VoidCallback? onShow;
  final bool isModal;
  final Duration? waitDuration;
  final Duration? showDuration;
  final bool barrierDismissible;
  final TooltipTriggerMode? triggerMode;
  final bool? enableFeedback;
  final Duration? hoverShowDuration;
  final AxisDirection preferredDirection;
  final Duration fadeInDuration;
  final Duration fadeOutDuration;
  final Curve curve;
  final Curve reverseCurve;
  final EdgeInsetsGeometry margin;
  final double offset;
  final double elevation;
  final BorderRadiusGeometry borderRadius;
  final double tailLength;
  final double tailBaseWidth;
  final TailBuilder tailBuilder;
  final AnimatedTransitionBuilder animatedTransitionBuilder;
  final Color? backgroundColor;
  final TextDirection textDirection;
  final Shadow? shadow;
  final bool showWhenUnlinked;
  final ScrollController? scrollController;

  FUITooltip({
    Key? key,
    this.fuiColorScheme = FUIColorScheme.secondary,
    this.fuiTooltipSize = FUITooltipSize.medium,
    this.tooltip,
    required this.child,
    this.onDismiss,
    this.onShow,
    this.controller,
    this.isModal = false,
    this.waitDuration,
    this.showDuration,
    this.triggerMode,
    this.barrierDismissible = true,
    this.enableFeedback,
    this.hoverShowDuration,
    this.fadeInDuration = const Duration(milliseconds: 150),
    this.fadeOutDuration = const Duration(milliseconds: 75),
    this.preferredDirection = AxisDirection.up,
    this.curve = Curves.easeInOut,
    this.reverseCurve = Curves.easeInOut,
    this.margin = const EdgeInsets.all(8.0),
    this.offset = 0.0,
    this.elevation = 4.0,
    this.borderRadius = const BorderRadius.all(Radius.circular(6)),
    this.tailLength = FUITooltipTheme.tailLength,
    this.tailBaseWidth = FUITooltipTheme.tailBaseWidth,
    this.tailBuilder = JustTheInterface.defaultTailBuilder,
    this.animatedTransitionBuilder = JustTheInterface.defaultAnimatedTransitionBuilder,
    this.backgroundColor,
    this.textDirection = TextDirection.ltr,
    this.shadow,
    this.showWhenUnlinked = false,
    this.scrollController,
  }) : super(key: key ?? UniqueKey());

  @override
  State<FUITooltip> createState() => _FUITooltipState();
}

class _FUITooltipState extends State<FUITooltip> with FUIColorMixin {
  late FUITooltipTheme fuiTooltip;

  @override
  Widget build(BuildContext context) {
    fuiTooltip = context.theme.fuiTooltip;

    if (widget.tooltip != null) {
      return _buildTooltip();
    }

    return widget.child;
  }

  _buildTooltip() {
    TextStyle ts;
    Color backgroundColor = widget.backgroundColor ?? discernColorByScheme(context, fuiColorScheme: widget.fuiColorScheme);
    Color defaultTextColor = discernForegroundColorByScheme(context, fuiColorScheme: widget.fuiColorScheme);

    switch (widget.fuiTooltipSize) {
      case FUITooltipSize.small:
        ts = fuiTooltip.tsSmall;
        break;
      case FUITooltipSize.large:
        ts = fuiTooltip.tsLarge;
        break;
      case FUITooltipSize.medium:
      default:
        ts = fuiTooltip.tsMedium;
        break;
    }

    ts = ts.copyWith(
      color: defaultTextColor,
    );

    return JustTheTooltip(
      onDismiss: widget.onDismiss,
      onShow: widget.onShow,
      controller: widget.controller,
      isModal: widget.isModal,
      waitDuration: widget.waitDuration,
      showDuration: widget.showDuration,
      triggerMode: widget.triggerMode,
      barrierDismissible: widget.barrierDismissible,
      enableFeedback: widget.enableFeedback,
      hoverShowDuration: widget.hoverShowDuration,
      fadeInDuration: widget.fadeInDuration,
      fadeOutDuration: widget.fadeOutDuration,
      preferredDirection: widget.preferredDirection,
      curve: widget.curve,
      reverseCurve: widget.reverseCurve,
      margin: widget.margin,
      offset: widget.offset,
      elevation: widget.elevation,
      borderRadius: widget.borderRadius,
      tailLength: widget.tailLength,
      tailBaseWidth: widget.tailBaseWidth,
      tailBuilder: widget.tailBuilder,
      animatedTransitionBuilder: widget.animatedTransitionBuilder,
      backgroundColor: widget.backgroundColor ?? backgroundColor,
      textDirection: widget.textDirection,
      shadow: widget.shadow,
      showWhenUnlinked: widget.showWhenUnlinked,
      scrollController: widget.scrollController,
      content: Padding(
        padding: FUITooltipTheme.padding,
        child: DefaultTextStyle(
          style: ts,
          child: widget.tooltip!,
        ),
      ),
      child: widget.child,
    );
  }
}
