import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../exports.dart';

/// ****************************************************
/// ** Very much in development (please don't use this yet) **
/// ****************************************************
class FUIInputSlider extends StatefulWidget {
  final FUIInputFieldSliderController? fuiInputFieldSliderController;
  final double value;
  final FUIInputSize fuiInputSize;
  final FUIColorScheme fuiColorScheme;
  final double? secondaryTrackValue;
  final ValueChanged<double> onChanged;
  final ValueChanged<double>? onChangeStart;
  final ValueChanged<double>? onChangeEnd;
  final double min;
  final double max;
  final int? divisions;
  final String? label;
  final Color? activeColor;
  final Color? inactiveColor;
  final Color? secondaryActiveColor;
  final Color? thumbColor;
  final WidgetStateProperty<Color?>? overlayColor;
  final MouseCursor? mouseCursor;
  final SemanticFormatterCallback? semanticFormatterCallback;
  final FocusNode? focusNode;
  final bool autofocus;
  final bool enabled;
  final Duration? enableOpacityAniDuration;
  final Curve? enableOpacityAniCurve;

  FUIInputSlider({
    Key? key,
    this.fuiInputFieldSliderController,
    required this.value,
    this.fuiInputSize = FUIInputSize.medium,
    this.fuiColorScheme = FUIColorScheme.primary,
    this.secondaryTrackValue,
    required this.onChanged,
    this.onChangeStart,
    this.onChangeEnd,
    this.min = 0.0,
    this.max = 1.0,
    this.divisions,
    this.label,
    this.activeColor,
    this.inactiveColor,
    this.secondaryActiveColor,
    this.thumbColor,
    this.overlayColor,
    this.mouseCursor,
    this.semanticFormatterCallback,
    this.focusNode,
    this.autofocus = false,
    this.enabled = true,
    this.enableOpacityAniDuration,
    this.enableOpacityAniCurve,
  }) : super(key: key ?? UniqueKey());

  @override
  State<FUIInputSlider> createState() => _FUIInputSliderState();
}

class _FUIInputSliderState extends State<FUIInputSlider> with FUIInputRadioCheckboxMixin, FUIColorMixin {
  /// Bloc
  late FUIInputFieldSliderController ifsCtrl;
  bool blocProviderCreateNew = false;

  /// Flags and attributes
  late double value;
  late double min;
  late double max;
  late Color activeColor;

  @override
  void initState() {
    super.initState();

    _initBloc();

    value = widget.value;
    min = widget.value;
    max = widget.value;
  }

  _initBloc() {
    if (widget.fuiInputFieldSliderController == null) {
      blocProviderCreateNew = true;
    }

    ifsCtrl = widget.fuiInputFieldSliderController ?? FUIInputFieldSliderController();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    activeColor = widget.activeColor ??
        discernColorByScheme(
          context,
          fuiColorScheme: widget.fuiColorScheme,
        );

    discernSize(widget);

    bf(BuildContext context, FUIInputFieldSliderEvent? event) {
      _handleBlocEvent(event);

      late double trackHeight;

      switch (widget.fuiInputSize) {
        case FUIInputSize.small:
          trackHeight = FUIInputTheme.sizeSliderSmallTrackHeight;
          break;
        case FUIInputSize.large:
          trackHeight = FUIInputTheme.sizeSliderLargeTrackHeight;
          break;
        case FUIInputSize.medium:
        default:
          trackHeight = FUIInputTheme.sizeSliderMediumTrackHeight;
          break;
      }

      return AbsorbPointer(
        absorbing: isReadOnly,
        child: AnimatedOpacity(
          duration: widget.enableOpacityAniDuration ?? FUIInputTheme.enableOpacityAniDuration,
          curve: widget.enableOpacityAniCurve ?? FUIInputTheme.enableOpacityAniCurve,
          opacity: isEnabled ? FUIInputTheme.enableOpacityNormal : FUIInputTheme.enableOpacityDisabled,
          child: SliderTheme(
            data: SliderTheme.of(context).copyWith(
              trackHeight: trackHeight,

            ),
            child: Slider(
              value: value,
              secondaryTrackValue: widget.secondaryTrackValue,
              onChanged: (v) {
                ifsCtrl.trigger(FUIInputFieldSliderEvent(
                  value: v,
                ));

                widget.onChanged(v);
              },
              onChangeStart: widget.onChangeStart,
              onChangeEnd: widget.onChangeEnd,
              min: 0.0,
              max: 1.0,
              divisions: widget.divisions,
              label: widget.label,
              activeColor: activeColor,
              inactiveColor: widget.inactiveColor,
              secondaryActiveColor: widget.secondaryActiveColor,
              thumbColor: widget.thumbColor,
              overlayColor: widget.overlayColor,
              mouseCursor: widget.mouseCursor,
              semanticFormatterCallback: widget.semanticFormatterCallback,
              focusNode: widget.focusNode,
              autofocus: widget.autofocus,
            ),
          ),
        ),
      );
    }

    if (blocProviderCreateNew) {
      return BlocProvider(
        create: (_) => ifsCtrl,
        child: BlocBuilder(
          bloc: ifsCtrl,
          builder: bf,
        ),
      );
    } else {
      return BlocProvider.value(
        value: ifsCtrl,
        child: BlocBuilder(
          bloc: ifsCtrl,
          builder: bf,
        ),
      );
    }
  }

  _handleBlocEvent(FUIInputFieldSliderEvent? event) {
    if (event != null) {
      if (event.enabled != null) {
        isEnabled = event.enabled!;
      }

      if (event.readOnly != null) {
        isReadOnly = event.readOnly!;
      }

      if (event.value != null) {
        value = event.value!;
      }
    }
  }
}
