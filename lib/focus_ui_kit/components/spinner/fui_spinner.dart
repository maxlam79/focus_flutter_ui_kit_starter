import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../exports.dart';

class FUISpinner extends StatefulWidget {
  final FUIColorScheme fuiColorScheme;
  final FUISpinnerController? fuiSpinnerController;
  final bool enable;
  final Widget? spinnerWidget; // Can be anything from icon to lottie, to svg widget.
  final bool rotationEnable;
  final Duration? rotationAniDuration;
  final Curve? rotationAniCurve;

  FUISpinner({
    Key? key,
    this.fuiColorScheme = FUIColorScheme.primary,
    this.fuiSpinnerController,
    this.enable = true,
    this.spinnerWidget,
    this.rotationEnable = true,
    this.rotationAniDuration,
    this.rotationAniCurve,
  }) : super(key: key ?? UniqueKey());

  @override
  State<FUISpinner> createState() => _FUISpinnerState();
}

class _FUISpinnerState extends State<FUISpinner> with SingleTickerProviderStateMixin, FUIColorMixin {
  /// Theme
  late FUIThemeCommonColors fuiColors;

  /// Bloc
  late FUISpinnerController spinnerCtrl;
  bool blocProviderCreateNew = false;

  /// Animation
  late AnimationController spinnerAniCtrl;
  late Animation<double> spinnerAniCurve;
  late Tween<double> spinnerAniAngelTween;
  late Animation<double> spinnerAni;

  /// Attributes and Flags
  bool show = false;

  @override
  void initState() {
    super.initState();

    _initBloc();
    _initAnimations();
  }

  _initBloc() {
    if (widget.fuiSpinnerController == null) {
      blocProviderCreateNew = true;
    }

    spinnerCtrl = widget.fuiSpinnerController ?? FUISpinnerController(spinnerShow: true);
  }

  _initAnimations() {
    spinnerAniCtrl = AnimationController(
      duration: widget.rotationAniDuration ?? FUISpinnerTheme.rotationAniDuration,
      vsync: this,
      lowerBound: 0,
      upperBound: 1,
      // lowerBound: 0,
      // upperBound: 359,
    );

    spinnerAniCurve = CurvedAnimation(
      parent: spinnerAniCtrl,
      curve: widget.rotationAniCurve ?? FUISpinnerTheme.rotationAniCurve,
    );

    spinnerAniAngelTween = Tween<double>(
      begin: 0,
      end: 359,
    );

    spinnerAni = spinnerAniAngelTween.animate(spinnerAniCurve);
  }

  @override
  void dispose() {
    spinnerAniCtrl.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    fuiColors = context.theme.fuiColors;

    bf(BuildContext context, bool? spinnerShow) {
      if (spinnerShow != null) {
        _toggleShow(spinnerShow);
      }

      if (widget.rotationEnable) {
        return AnimatedBuilder(
          animation: spinnerAni,
          builder: (context, child) {
            return Visibility(
              visible: widget.enable && show,
              // child: aRotate.AnimatedRotation(
              //   angle: spinnerAniAngelTween.evaluate(spinnerAniCtrl),
              //   duration: widget.rotationDuration ?? FUISpinnerTheme.rotationDuration,
              //   curve: widget.rotationAniCurve ?? FUISpinnerTheme.animationCurve,
              //   child: _buildIcon(context),
              // ),
              child: Transform.rotate(
                angle: spinnerAni.value,
                child: _buildIcon(context),
              ),
            );
          },
        );
      } else {
        return Visibility(
          visible: widget.enable && show,
          child: _buildIcon(context),
        );
      }
    }

    if (blocProviderCreateNew) {
      return BlocProvider(
        create: (_) => spinnerCtrl,
        child: BlocBuilder(
          bloc: spinnerCtrl,
          builder: bf,
        ),
      );
    } else {
      return BlocProvider.value(
        value: spinnerCtrl,
        child: BlocBuilder(
          bloc: spinnerCtrl,
          builder: bf,
        ),
      );
    }
  }

  _buildIcon(BuildContext context) {
    return IconTheme.merge(
      data: context.theme.iconTheme.copyWith(
        color: discernColorByScheme(context, fuiColorScheme: widget.fuiColorScheme),
        size: FUISpinnerTheme.defaultSize,
      ),
      child: widget.spinnerWidget ??
          const Icon(
            FUISpinnerTheme.defaultIcon,
          ),
    );
  }

  _toggleShow(bool show) {
    if (show != show) {
      show = show;

      if (widget.enable && widget.rotationEnable) {
        if (show) {
          spinnerAniCtrl.repeat();
        } else if (!show) {
          spinnerAniCtrl.stop();
          spinnerAniCtrl.reset();
        }
      }
    }
  }
}
