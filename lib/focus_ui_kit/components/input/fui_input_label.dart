import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../exports.dart';

class FUIInputLabel extends StatefulWidget {
  final FUIInputLabelShrinkController? fuiInputLabelShrinkController;
  final Widget? label;

  FUIInputLabel({
    Key? key,
    this.fuiInputLabelShrinkController,
    this.label,
  }) : super(key: key ?? UniqueKey());

  @override
  State<FUIInputLabel> createState() => _FUIInputLabelState();
}

class _FUIInputLabelState extends State<FUIInputLabel> with SingleTickerProviderStateMixin {
  /// Theme
  late FUIThemeCommonColors fuiColors;
  late FUIInputTheme fuiInputTheme;

  /// Bloc
  late FUIInputLabelShrinkController shrinkCtrl;
  bool blocProviderCreateNew = false;

  /// Animation
  late AnimationController aniCtrl;
  late Tween<double> aniOpacityTween;
  late CurvedAnimation aniOpacity;
  late Tween<double> aniFontSizeTween;
  late CurvedAnimation aniFontSize;

  /// Attributes and Flags
  bool isShrinked = false;

  @override
  void initState() {
    super.initState();

    _initBloc();
    _initAnimation();
  }

  _initBloc() {
    if (widget.fuiInputLabelShrinkController == null) {
      blocProviderCreateNew = true;
    }

    shrinkCtrl = widget.fuiInputLabelShrinkController ?? FUIInputLabelShrinkController(false);
  }

  _initAnimation() {
    aniCtrl = AnimationController(
      duration: FUIInputTheme.labelResizeAniDuration,
      value: 0,
      vsync: this,
    );

    aniOpacityTween = Tween<double>(
      begin: FUIInputTheme.labelOpacityNormal,
      end: FUIInputTheme.labelOpacityShrink,
    );

    aniOpacity = CurvedAnimation(
      parent: aniCtrl,
      curve: FUIInputTheme.labelResizeAniCurve,
    );

    aniFontSizeTween = Tween<double>(
      begin: FUIInputTheme.fontSizeTitle,
      end: FUIInputTheme.fontSizeTitleOnFocus,
    );

    aniFontSize = CurvedAnimation(
      parent: aniCtrl,
      curve: FUIInputTheme.labelResizeOpacityAniCurve,
    );
  }

  @override
  void dispose() {
    aniCtrl.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    fuiColors = context.theme.fuiColors;
    fuiInputTheme = context.theme.fuiInput;

    bf(BuildContext context, bool shrink) {
      _animate(shrink);

      if (widget.label != null) {
        return AnimatedBuilder(
          animation: aniFontSize,
          builder: (context, child) {
            return AnimatedBuilder(
              animation: aniOpacity,
              builder: (context, child) {
                return Opacity(
                  opacity: aniOpacityTween.evaluate(aniOpacity).toDouble(),
                  child: child!,
                );
              },
              child: DefaultTextStyle(
                style: fuiInputTheme.tsLabel.copyWith(
                  fontSize: aniFontSizeTween.evaluate(aniFontSize).toDouble(),
                ),
                child: widget.label ?? const Text(''),
              ),
            );
          },
        );
      } else {
        return const Text('');
      }

      // return AnimatedSize(
      //   duration: FUIInputTheme.labelResizeAniDuration,
      //   curve: FUIInputTheme.labelResizeAniCurve,
      //   child: AnimatedOpacity(
      //     opacity: opacity,
      //     duration: FUIInputTheme.labelResizeOpacityAniDuration,
      //     curve: FUIInputTheme.labelResizeOpacityAniCurve,
      //     child: DefaultTextStyle(
      //       style: fuiInputTheme.tsLabel.copyWith(
      //         fontSize: fontSize,
      //       ),
      //       child: widget.label ?? const Text(''),
      //     ),
      //   ),
      // );
    }

    if (blocProviderCreateNew) {
      return BlocProvider(
        create: (_) => shrinkCtrl,
        child: BlocBuilder(
          bloc: shrinkCtrl,
          builder: bf,
        ),
      );
    } else {
      return BlocProvider.value(
        value: shrinkCtrl,
        child: BlocBuilder(
          bloc: shrinkCtrl,
          builder: bf,
        ),
      );
    }
  }

  _animate(bool shrink) {
    if (isShrinked != shrink) {
      if (shrink) {
        aniCtrl.forward();
      } else {
        aniCtrl.reverse();
      }
    }

    isShrinked = shrink;
  }
}
