import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../exports.dart';

class FUIInputCheckbox extends StatefulWidget {
  final FUIInputFieldToggleController? fuiInputFieldToggleController;
  final bool? initialValue;
  final FUIInputSize fuiInputSize;
  final FUIColorScheme fuiColorScheme;
  final bool tristate;
  final ValueChanged<bool?>? onChanged;
  final MouseCursor? mouseCursor;
  final Color? activeColor;
  final WidgetStateProperty<Color?>? fillColor;
  final Color? checkColor;
  final Color? focusColor;
  final Color? hoverColor;
  final WidgetStateProperty<Color?>? overlayColor;
  final MaterialTapTargetSize? materialTapTargetSize;
  final VisualDensity? visualDensity;
  final FocusNode? focusNode;
  final bool autofocus;
  final OutlinedBorder? shape;
  final BorderSide? side;
  final bool isError;
  final bool readOnly;
  final bool enabled;
  final Duration? enableOpacityAniDuration;
  final Curve? enableOpacityAniCurve;

  FUIInputCheckbox({
    Key? key,
    this.fuiInputFieldToggleController,
    required this.initialValue,
    this.fuiInputSize = FUIInputSize.medium,
    this.fuiColorScheme = FUIColorScheme.primary,
    this.tristate = false,
    required this.onChanged,
    this.mouseCursor,
    this.activeColor,
    this.fillColor,
    this.checkColor,
    this.focusColor,
    this.hoverColor,
    this.overlayColor,
    this.materialTapTargetSize,
    this.visualDensity,
    this.focusNode,
    this.autofocus = false,
    this.shape,
    this.side,
    this.isError = false,
    this.readOnly = false,
    this.enabled = true,
    this.enableOpacityAniDuration,
    this.enableOpacityAniCurve,
  }) : super(key: key ?? UniqueKey());

  @override
  State<FUIInputCheckbox> createState() => _FUIInputCheckboxState();
}

class _FUIInputCheckboxState extends State<FUIInputCheckbox> with FUIInputRadioCheckboxMixin, FUIColorMixin {
  /// Bloc
  late FUIInputFieldToggleController ifcCtrl;
  bool blocProviderCreateNew = false;

  /// Flags and attributes
  late bool? value;
  late Color activeColor;

  /// Keys
  GlobalKey checkBoxKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    _initBloc();

    value = widget.initialValue;
    isEnabled = widget.enabled;
    isReadOnly = widget.readOnly;
  }

  _initBloc() {
    if (widget.fuiInputFieldToggleController == null) {
      blocProviderCreateNew = true;
    }

    ifcCtrl = widget.fuiInputFieldToggleController ?? FUIInputFieldToggleController();
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

    bf(BuildContext context, FUIInputFieldToggleEvent? event) {
      _handleBlocEvent(event);

      return AbsorbPointer(
        absorbing: !isEnabled || isReadOnly,
        child: AnimatedOpacity(
          duration: widget.enableOpacityAniDuration ?? FUIInputTheme.enableOpacityAniDuration,
          curve: widget.enableOpacityAniCurve ?? FUIInputTheme.enableOpacityAniCurve,
          opacity: isEnabled ? FUIInputTheme.enableOpacityNormal : FUIInputTheme.enableOpacityDisabled,
          child: Transform.scale(
            scale: scale,
            child: Checkbox(
              key: checkBoxKey,
              value: value,
              tristate: widget.tristate,
              onChanged: (toggle) {
                ifcCtrl.trigger(FUIInputFieldToggleEvent(value: toggle));

                if (widget.onChanged != null) {
                  widget.onChanged!(toggle);
                }
              },
              mouseCursor: widget.mouseCursor,
              activeColor: activeColor,
              fillColor: widget.fillColor,
              checkColor: widget.checkColor,
              focusColor: widget.focusColor,
              hoverColor: widget.hoverColor,
              overlayColor: widget.overlayColor,
              splashRadius: 0,
              materialTapTargetSize: widget.materialTapTargetSize,
              visualDensity: widget.visualDensity,
              focusNode: widget.focusNode,
              autofocus: widget.autofocus,
              shape: widget.shape,
              side: widget.side,
              isError: widget.isError,
            ),
          ),
        ),
      );
    }

    if (blocProviderCreateNew) {
      return BlocProvider(
        create: (_) => ifcCtrl,
        child: BlocBuilder(
          bloc: ifcCtrl,
          builder: bf,
        ),
      );
    } else {
      return BlocProvider.value(
        value: ifcCtrl,
        child: BlocBuilder(
          bloc: ifcCtrl,
          builder: bf,
        ),
      );
    }
  }

  _handleBlocEvent(FUIInputFieldToggleEvent? event) {
    if (event != null) {
      if (event.enabled != null) {
        isEnabled = event.enabled!;
      }

      if (event.readOnly != null) {
        isReadOnly = event.readOnly!;
      }

      if (widget.tristate) {
        value = event.value;
      } else if (event.value != null) {
        value = event.value!;
      }
    }
  }
}
