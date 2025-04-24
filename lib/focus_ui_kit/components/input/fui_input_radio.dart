import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../exports.dart';

class FUIInputRadio<T> extends StatefulWidget {
  final FUIColorScheme fuiColorScheme;
  final FUIInputFieldRadioGroupController<T>? fuiInputFieldRadioGroupController;
  final FUIInputFieldRadioController? fuiInputFieldRadioController;
  final T value;
  // final T? groupValue;
  final FUIInputSize fuiInputSize;
  final ValueChanged<T?> onChanged;
  final MouseCursor? mouseCursor;
  final Color? activeColor; // Overwrites color scheme
  final WidgetStateProperty<Color?>? fillColor;
  final Color? focusColor;
  final Color? hoverColor;
  final WidgetStateProperty<Color?>? overlayColor;
  final MaterialTapTargetSize? materialTapTargetSize;
  final VisualDensity? visualDensity; // This will overwrite fuiInputSize
  final FocusNode? focusNode;
  final bool autofocus;
  final bool readOnly;
  final bool enabled;
  final Duration? enableOpacityAniDuration;
  final Curve? enableOpacityAniCurve;

  FUIInputRadio({
    Key? key,
    this.fuiColorScheme = FUIColorScheme.primary,
    this.fuiInputFieldRadioGroupController,
    this.fuiInputFieldRadioController,
    required this.value,
    // this.groupValue,
    this.fuiInputSize = FUIInputSize.medium,
    required this.onChanged,
    this.mouseCursor,
    this.activeColor,
    this.fillColor,
    this.focusColor,
    this.hoverColor,
    this.overlayColor,
    this.materialTapTargetSize,
    this.visualDensity,
    this.focusNode,
    this.autofocus = false,
    this.readOnly = false,
    this.enabled = true,
    this.enableOpacityAniDuration,
    this.enableOpacityAniCurve,
  }) : super(key: key ?? UniqueKey());

  @override
  State<FUIInputRadio<T>> createState() => _FUIInputRadioState<T>();
}

class _FUIInputRadioState<T> extends State<FUIInputRadio<T>> with FUIInputRadioCheckboxMixin, FUIColorMixin {
  /// Bloc
  late FUIInputFieldRadioController ifrCtrl;
  late FUIInputFieldRadioGroupController<T> rGroupCtrl;
  bool blocProviderRadioCtrlCreateNew = false;
  bool blocProviderRadioGroupCtrlCreateNew = false;

  /// Flags and attributes
  late Color activeColor;

  // late T? currentGroupValue;

  @override
  void initState() {
    super.initState();

    _initBloc();

    // currentGroupValue = widget.groupValue;

    isEnabled = widget.enabled;
    isReadOnly = widget.readOnly;
  }

  _initBloc() {
    if (widget.fuiInputFieldRadioGroupController == null) {
      blocProviderRadioGroupCtrlCreateNew = true;
    }

    if (widget.fuiInputFieldRadioController == null) {
      blocProviderRadioCtrlCreateNew = true;
    }

    // rGroupCtrl = widget.fuiInputFieldRadioGroupController ?? FUIInputFieldRadioGroupController<T>(widget.groupValue);
    rGroupCtrl = widget.fuiInputFieldRadioGroupController ?? FUIInputFieldRadioGroupController<T>(null);
    ifrCtrl = widget.fuiInputFieldRadioController ?? FUIInputFieldRadioController();
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

    return _generateBlocProviderRadioCtrl(BlocBuilder<FUIInputFieldRadioController, FUIInputFieldRadioEvent?>(
      bloc: ifrCtrl,
      builder: (BuildContext context, FUIInputFieldRadioEvent? event) {
        _handleRadioCtrlBlocEvent(event);

        return _generateBlocProviderRadioGroupCtrl(BlocBuilder<FUIInputFieldRadioGroupController<T>, T?>(
          bloc: rGroupCtrl,
          builder: (BuildContext context, T? newGroupValue) {
            return AbsorbPointer(
              absorbing: isReadOnly,
              child: AnimatedOpacity(
                duration: widget.enableOpacityAniDuration ?? FUIInputTheme.enableOpacityAniDuration,
                curve: widget.enableOpacityAniCurve ?? FUIInputTheme.enableOpacityAniCurve,
                opacity: isEnabled ? FUIInputTheme.enableOpacityNormal : FUIInputTheme.enableOpacityDisabled,
                child: Transform.scale(
                  scale: scale,
                  child: Radio<T>(
                    value: widget.value,
                    groupValue: rGroupCtrl.groupValue,
                    mouseCursor: widget.mouseCursor,
                    toggleable: !isReadOnly,
                    activeColor: activeColor,
                    fillColor: widget.fillColor,
                    focusColor: widget.focusColor,
                    hoverColor: widget.hoverColor,
                    overlayColor: widget.overlayColor,
                    materialTapTargetSize: widget.materialTapTargetSize,
                    visualDensity: widget.visualDensity,
                    focusNode: widget.focusNode,
                    autofocus: widget.autofocus,
                    splashRadius: 0,
                    onChanged: (T? value) {
                      rGroupCtrl.changeTo(value);

                      widget.onChanged(value);
                                        },
                  ),
                ),
              ),
            );
          },
        ));
      },
    ));
  }

  _handleRadioCtrlBlocEvent(FUIInputFieldRadioEvent? event) {
    if (event != null) {
      if (event.enabled != null) {
        isEnabled = event.enabled!;
      }

      if (event.readOnly != null) {
        isReadOnly = event.readOnly!;
      }
    }
  }

  _generateBlocProviderRadioCtrl(BlocBuilder bb) {
    if (blocProviderRadioCtrlCreateNew) {
      return BlocProvider(
        create: (_) => ifrCtrl,
        child: bb,
      );
    } else {
      return BlocProvider.value(
        value: ifrCtrl,
        child: bb,
      );
    }
  }

  _generateBlocProviderRadioGroupCtrl(BlocBuilder bb) {
    if (blocProviderRadioGroupCtrlCreateNew) {
      return BlocProvider(
        create: (_) => rGroupCtrl,
        child: bb,
      );
    } else {
      return BlocProvider.value(
        value: rGroupCtrl,
        child: bb,
      );
    }
  }
}
