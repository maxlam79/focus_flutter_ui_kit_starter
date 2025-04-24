import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../exports.dart';

class FUIPaceBar extends StatefulWidget {
  final FUIColorScheme fuiColorScheme;
  final FUIPaceBarController? paceBarController;
  final bool enable; // Progress bar on top for loading/waiting and other async stuff if needed.
  final bool barRepeating;
  final Color? barColor; // overrides color scheme
  final Color barBackgroundColor;
  final double barCurrentValue;
  final double barMaxValue;
  final Curve barAniCurve;
  final Duration? barAniDuration;

  FUIPaceBar({
    Key? key,
    this.fuiColorScheme = FUIColorScheme.primary,
    this.paceBarController,
    this.enable = true,
    this.barRepeating = true,
    this.barColor,
    this.barBackgroundColor = Colors.transparent,
    this.barCurrentValue = FUIPaceBarTheme.paceBarAniCtrlLowerBound,
    this.barMaxValue = FUIPaceBarTheme.paceBarAniCtrlUpperBound,
    this.barAniCurve = Curves.fastOutSlowIn,
    this.barAniDuration,
  }) : super(key: key ?? UniqueKey());

  @override
  State<FUIPaceBar> createState() => _FUIPaceBarState();
}

class _FUIPaceBarState extends State<FUIPaceBar> with SingleTickerProviderStateMixin, FUIColorMixin {
  /// Theme
  late FUIThemeCommonColors fuiColors;

  /// Bloc
  late FUIPaceBarController pbCtrl;
  bool blocProviderCreateNew = false;

  /// Animation
  late AnimationController barAniCtrl;
  late Tween<double> barValueTween;
  late Animation<double> barAni;

  /// Other variables and flags
  late double barValue;
  bool show = false;

  @override
  void initState() {
    super.initState();

    _initBloc();
    _initAnimations();
  }

  _initBloc() {
    if (widget.paceBarController == null) {
      pbCtrl = FUIPaceBarController(
          event: FUIPaceBarControlEvent(
        barShow: true,
        barValue: widget.barCurrentValue,
      ));

      blocProviderCreateNew = true;
    } else {
      pbCtrl = widget.paceBarController!;
    }
  }

  _initAnimations() {
    barValue = widget.barCurrentValue;

    barAniCtrl = AnimationController(
      duration: widget.barAniDuration ?? FUIPaceBarTheme.paceBarAniDuration,
      vsync: this,
      value: barValue,
    );

    barAni = CurvedAnimation(
      parent: barAniCtrl,
      curve: widget.barAniCurve,
    );

    barValueTween = Tween<double>(
      begin: barValue,
      end: widget.barMaxValue,
    );
  }

  @override
  void dispose() {
    barAniCtrl.dispose();

    if (blocProviderCreateNew) {
      pbCtrl.close();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    fuiColors = context.theme.fuiColors;
    Color barColor = widget.barColor ?? discernColorByScheme(context, fuiColorScheme: widget.fuiColorScheme);

    Widget w = BlocBuilder(
      bloc: pbCtrl,
      builder: (BuildContext context, FUIPaceBarControlEvent? event) {
        if (widget.enable) {
          // Repeating
          if (widget.barRepeating) {
            _handleRepeatProgressBarAniEvent(event);
          }
          // Step value
          else {
            _handleStepProgressBarAniEvent(event);
          }
        }

        return Visibility(
          visible: widget.enable && show,
          child: AnimatedBuilder(
            animation: barAni,
            builder: (context, child) {
              return Row(
                children: [
                  Expanded(
                    flex: barValueTween.evaluate(barAni).toInt(),
                    child: Container(
                      margin: EdgeInsets.zero,
                      padding: EdgeInsets.zero,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: barColor,
                        border: Border.all(
                          width: FUIPaceBarTheme.paceBarBorderWidth,
                          color: barColor,
                        ),
                        borderRadius: FUIPaceBarTheme.paceBarBorderRadius,
                      ),
                      height: FUIPaceBarTheme.paceBarSize,
                    ),
                  ),
                  Expanded(
                    flex: (widget.barMaxValue - barValueTween.evaluate(barAni)).toInt(),
                    child: Container(
                      margin: EdgeInsets.zero,
                      padding: EdgeInsets.zero,
                      height: FUIPaceBarTheme.paceBarSize,
                      color: widget.barBackgroundColor,
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );

    if (blocProviderCreateNew) {
      return BlocProvider(
        create: (_) => pbCtrl,
        child: w,
      );
    } else {
      return BlocProvider.value(
        value: pbCtrl,
        child: w,
      );
    }
  }

  _handleRepeatProgressBarAniEvent(FUIPaceBarControlEvent? event) {
    if (event != null) {
      if (event.barShow != null && show != event.barShow!) {
        show = event.barShow!;

        try {
          if (show && widget.enable) {
            barAniCtrl.repeat();
          } else {
            barAniCtrl.stop();
            barAniCtrl.reset();
          }
        } catch (e) {
          // Absorb
        }
      }
    }
  }

  _handleStepProgressBarAniEvent(FUIPaceBarControlEvent? event) {
    if (event != null) {
      if (event.barShow != null) {
        show = event.barShow!;
      }

      if (widget.enable && event.barValue != null) {
        double newBarValue = event.barValue!;

        if (show) {
          try {
            barValueTween = Tween<double>(
              begin: barValue,
              end: newBarValue,
            );

            if (newBarValue > barValue) {
              barAniCtrl.reset();
              barAniCtrl.forward();
            } else if (newBarValue == barValue) {
              barAniCtrl.stop();
            } else {
              barAniCtrl.reset();
              barAniCtrl.reverse();
            }
          } catch (e) {
            // Absorb
          }
        }

        barValue = newBarValue;
      }
    }
  }
}
