import 'package:align_positioned/align_positioned.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../exports.dart';

class FUIPane extends StatefulWidget {
  final Widget child;
  final FUIPaneController? paneController;

  final FUIColorScheme fuiColorScheme;
  final double? width;
  final double? height;
  final EdgeInsets? padding;
  final BoxDecoration? decoration;
  final BoxConstraints? constraints;

  /// Enable/Disable opacity effects
  final double? opacityDuringDisabled;
  final Duration? opacityAniDuration;

  /// Pace Bar
  final bool paceBarEnable; // Progress bar on top for loading/waiting and other async stuff if needed.
  final bool paceBarShow;
  final bool paceBarRepeating;
  final FUIPanePaceBarPosition paceBarPosition;
  final Color? paceBarColor;
  final double paceBarCurrentValue;
  final double paceBarMaxValue;
  final Curve? paceBarAniCurve;
  final Duration? paceBarAniDuration;

  /// Center loading/waiting spinner options
  final bool spinnerEnable;
  final Alignment spinnerPosition;
  final Widget? spinnerWidget; // Can be anything from icon to svg widget.
  final bool spinnerRotationEnable;
  final Duration? spinnerRotationAniDuration;
  final Curve? spinnerRotationAniCurve;

  FUIPane({
    Key? key,
    required this.child,
    this.paneController,
    this.fuiColorScheme = FUIColorScheme.primary,
    this.width,
    this.height,
    this.padding,
    this.decoration,
    this.constraints,
    this.opacityDuringDisabled,
    this.opacityAniDuration,
    this.paceBarEnable = true,
    this.paceBarShow = false,
    this.paceBarRepeating = true,
    this.paceBarPosition = FUIPanePaceBarPosition.top,
    this.paceBarColor,
    this.paceBarCurrentValue = FUIPaceBarTheme.paceBarAniLowerBound,
    this.paceBarMaxValue = FUIPaceBarTheme.paceBarAniUpperBound,
    this.paceBarAniCurve,
    this.paceBarAniDuration,
    this.spinnerEnable = true,
    this.spinnerPosition = Alignment.center,
    this.spinnerWidget,
    this.spinnerRotationEnable = true,
    this.spinnerRotationAniDuration,
    this.spinnerRotationAniCurve,
  }) : super(key: key ?? UniqueKey());

  @override
  State<FUIPane> createState() => _FUIPaneState();
}

class _FUIPaneState extends State<FUIPane> with FUIColorMixin {
  /// Bloc
  late FUIPaneController paneCtrl;
  late FUIPaceBarController pbCtrl;
  late FUISpinnerController spinnerCtrl;
  bool blocProviderCreateNew = false;

  /// Attributes & Flags
  bool paneEnable = true;
  bool paneBlur = false;
  double opacity = 1;
  bool barShow = false;
  late double barValue;
  bool spinnerShow = false;

  @override
  void initState() {
    super.initState();

    _initPaneCtrl();
    _initPbCtrl();
    _initSpinnerCtrl();
  }

  _initPaneCtrl() {
    if (widget.paneController == null) {
      blocProviderCreateNew = true;
    }

    paneCtrl = widget.paneController ?? FUIPaneController();

    if (paneCtrl.event != null) {
      paneEnable = paneCtrl.event!.enable ?? true;
      paneBlur = paneCtrl.event!.blur ?? false;
      opacity = paneBlur ? widget.opacityDuringDisabled ?? FUIPaneTheme.opacityDuringDisabled : 1;
    }
  }

  _initPbCtrl() {
    barShow = widget.paceBarShow;

    if (paneCtrl.event != null) {
      barShow = paneCtrl.event!.paceBarShow ?? widget.paceBarShow;
    }

    barValue = widget.paceBarCurrentValue;

    pbCtrl = FUIPaceBarController(
      event: FUIPaceBarControlEvent(
        barShow: barShow,
        barValue: barValue,
      ),
    );
  }

  _initSpinnerCtrl() {
    if (paneCtrl.event != null) {
      spinnerShow = paneCtrl.event!.spinnerShow ?? false;
    }

    spinnerCtrl = FUISpinnerController(spinnerShow: spinnerShow);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: widget.decoration,
      constraints: widget.constraints ??
          BoxConstraints(
            minWidth: widget.width ?? FUIPanelTheme.defaultWidth,
            minHeight: widget.height ?? FUIPanelTheme.defaultHeight,
            maxWidth: widget.width ?? FUIPanelTheme.defaultWidth,
            maxHeight: widget.height ?? FUIPanelTheme.defaultHeight,
          ),
      child: Stack(
        children: [
          _buildOpacityLayer(),
          _buildPaceBarLayer(),
          _buildSpinner(),
        ],
      ),
    );
  }

  _buildOpacityLayer() {
    bf(BuildContext context, FUIPaneControlEvent? event) {
      if (event != null) {
        if (event.enable != null && paneEnable != event.enable!) {
          paneEnable = event.enable!;
        }

        if (event.blur != null && paneBlur != event.blur!) {
          paneBlur = event.blur!;
        }

        opacity = paneBlur ? widget.opacityDuringDisabled ?? FUIPaneTheme.opacityDuringDisabled : 1;

        if (event.spinnerShow != null) {
          spinnerCtrl.show(event.spinnerShow!);
        }

        pbCtrl.trigger(FUIPaceBarControlEvent(
          barShow: event.paceBarShow,
          barValue: event.paceBarValue,
        ));
      }

      return AbsorbPointer(
        absorbing: !paneEnable,
        child: AnimatedOpacity(
          duration: widget.opacityAniDuration ?? FUIPaneTheme.opacityAniDuration,
          opacity: opacity,
          child: Padding(
            padding: widget.padding ?? FUIPaneTheme.contentPadding,
            child: widget.child,
          ),
        ),
      );
    }

    if (blocProviderCreateNew) {
      return BlocProvider(
        create: (_) => paneCtrl,
        child: BlocBuilder(
          bloc: paneCtrl,
          builder: bf,
        ),
      );
    } else {
      return BlocProvider.value(
        value: paneCtrl,
        child: BlocBuilder(
          bloc: paneCtrl,
          builder: bf,
        ),
      );
    }
  }

  _buildPaceBarLayer() {
    MainAxisAlignment alignment;

    switch (widget.paceBarPosition) {
      case FUIPanePaceBarPosition.bottom:
        alignment = MainAxisAlignment.end;
        break;
      case FUIPanePaceBarPosition.top:
      default:
        alignment = MainAxisAlignment.start;
        break;
    }

    return Positioned.fill(
      child: Column(
        mainAxisAlignment: alignment,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FUIPaceBar(
            fuiColorScheme: widget.fuiColorScheme,
            paceBarController: pbCtrl,
            enable: widget.paceBarEnable,
            barRepeating: widget.paceBarRepeating,
            barColor: widget.paceBarColor,
            barAniCurve: widget.paceBarAniCurve ?? Curves.fastOutSlowIn,
            barAniDuration: widget.paceBarAniDuration,
            barCurrentValue: widget.paceBarCurrentValue,
            barMaxValue: widget.paceBarMaxValue,
          ),
        ],
      ),
    );
  }

  _buildSpinner() {
    return Positioned.fill(
      child: AlignPositioned(
        alignment: widget.spinnerPosition,
        child: FUISpinner(
          fuiSpinnerController: spinnerCtrl,
          spinnerWidget: widget.spinnerWidget,
          rotationEnable: widget.spinnerRotationEnable,
          rotationAniDuration: widget.spinnerRotationAniDuration,
          rotationAniCurve: widget.spinnerRotationAniCurve,
        ),
      ),
    );
  }
}
