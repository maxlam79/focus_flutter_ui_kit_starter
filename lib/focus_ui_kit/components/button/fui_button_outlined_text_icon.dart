import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuple/tuple.dart';

import '../../exports.dart';

class FUIButtonOutlinedTextIcon extends StatefulWidget {
  final Text text;
  final Icon? icon;
  final FUIButtonTextIconPosition fuiButtonTextIconPosition; // If no icon, text will be at the center.
  final FUIColorScheme fuiColorScheme;
  final FUIButtonSize fuiButtonSize;
  final FUIButtonShape fuiButtonShape;
  final FUIButtonBlockLevel fuiButtonBlockLevel;
  final FUIButtonController? fuiButtonController;
  final Color? borderColor; // will override borderColor in fuiColorScheme
  final VoidCallback onPressed;
  final VoidCallback? onLongPress;
  final ValueChanged<bool>? onHover;
  final ValueChanged<bool>? onFocusChange;
  final FocusNode? focusNode;
  final bool autofocus;
  final Clip clipBehavior;
  final WidgetStatesController? statesController;
  final Duration disabledOpacityAnimationDuration;

  FUIButtonOutlinedTextIcon({
    Key? key,
    required this.text,
    this.icon,
    this.fuiButtonTextIconPosition = FUIButtonTextIconPosition.iconLeftTextRight,
    this.fuiColorScheme = FUIColorScheme.primary,
    this.fuiButtonSize = FUIButtonSize.medium,
    this.fuiButtonShape = FUIButtonShape.square,
    this.fuiButtonBlockLevel = FUIButtonBlockLevel.fit,
    this.fuiButtonController,
    this.borderColor,
    required this.onPressed,
    this.onLongPress,
    this.onHover,
    this.onFocusChange,
    this.focusNode,
    this.autofocus = false,
    this.clipBehavior = Clip.none,
    this.statesController,
    this.disabledOpacityAnimationDuration = FUIButtonTheme.opacityAnimationDuration,
  }) : super(key: key ?? UniqueKey());

  @override
  State<FUIButtonOutlinedTextIcon> createState() => _FUIButtonOutlinedTextIconState();
}

class _FUIButtonOutlinedTextIconState extends State<FUIButtonOutlinedTextIcon> with FUIButtonMixin {
  /// Theme
  late FUIButtonTheme buttonTheme;

  /// Bloc
  late FUIButtonController btnCtrl;
  bool blocProviderNewCreate = false;

  @override
  void initState() {
    super.initState();

    _initBloc();
  }

  _initBloc() {
    if (widget.fuiButtonController == null) {
      blocProviderNewCreate = true;
    }

    btnCtrl = widget.fuiButtonController ?? FUIButtonController();
  }

  @override
  void dispose() {
    if (blocProviderNewCreate && !btnCtrl.isClosed) {
      btnCtrl.close();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    buttonTheme = context.theme.fuiButton;

    final Tuple2<TextStyle, Color> textAndBgColorTuple = discernTextStyleBgColor(context, widget, 2);
    final Tuple2<double, double> widthHeightTuple = discernWidthHeight(widget, widget.text.style ?? textAndBgColorTuple.item1);
    double cWidth = widthHeightTuple.item1, cHeight = widthHeightTuple.item2;
    OutlinedBorder shape = discernShape(widget.fuiButtonShape);

    ButtonStyle buttonStyle = (widget.fuiButtonBlockLevel == FUIButtonBlockLevel.fit)
        ? OutlinedButton.styleFrom(
            fixedSize: Size(cWidth, cHeight),
            elevation: 0,
            backgroundColor: Colors.transparent,
            splashFactory: NoSplash.splashFactory,
            side: BorderSide(
              width: 1,
              color: widget.borderColor ?? textAndBgColorTuple.item2,
            ),
            shape: shape,
          ).copyWith(
            overlayColor: WidgetStateProperty.all(buttonTheme.buttonOverlayColor),
          )
        : OutlinedButton.styleFrom(
            fixedSize: Size.fromHeight(cHeight),
            elevation: 0,
            backgroundColor: Colors.transparent,
            splashFactory: NoSplash.splashFactory,
            side: BorderSide(
              width: 1,
              color: widget.borderColor ?? textAndBgColorTuple.item2,
            ),
            shape: shape,
          ).copyWith(
            overlayColor: WidgetStateProperty.all(buttonTheme.buttonOverlayColor),
          );

    bf(BuildContext context, FUIButtonEvent? event) {
      discernFUIButtonEvents(widget, event);

      Widget buttonWidget;

      if (widget.icon != null) {
        buttonWidget = GestureDetector(
          onForcePressStart: (_) {
            if (widget.onFocusChange != null) {
              widget.onFocusChange!(true);
            }
          },
          onForcePressEnd: (_) {
            if (widget.onFocusChange != null) {
              widget.onFocusChange!(false);
            }
          },
          child: MouseRegion(
            onEnter: (_) {
              if (widget.onHover != null) {
                widget.onHover!(true);
              }
            },
            onExit: (_) {
              if (widget.onHover != null) {
                widget.onHover!(false);
              }
            },
            child: OutlinedButton.icon(
              onPressed: widget.onPressed,
              onLongPress: widget.onLongPress,
              style: buttonStyle,
              focusNode: widget.focusNode,
              autofocus: widget.autofocus,
              clipBehavior: widget.clipBehavior,
              statesController: widget.statesController,
              label: DefaultTextStyle(
                style: textAndBgColorTuple.item1,
                child: widget.text,
              ),
              icon: IconTheme.merge(
                data: const IconThemeData().copyWith(
                  color: textAndBgColorTuple.item1.color,
                  size: discernIconSize(widget.fuiButtonSize),
                ),
                child: widget.icon!,
              ),
            ),
          ),
        );
      } else {
        buttonWidget = OutlinedButton(
          onPressed: widget.onPressed,
          onLongPress: widget.onLongPress,
          onHover: widget.onHover,
          onFocusChange: widget.onFocusChange,
          style: buttonStyle,
          focusNode: widget.focusNode,
          autofocus: widget.autofocus,
          clipBehavior: widget.clipBehavior,
          statesController: widget.statesController,
          child: DefaultTextStyle(
            style: textAndBgColorTuple.item1,
            child: widget.text,
          ),
        );
      }

      if (widget.fuiButtonBlockLevel == FUIButtonBlockLevel.full) {
        buttonWidget = SizedBox(
          width: double.infinity,
          child: buttonWidget,
        );
      }

      if (widget.fuiButtonTextIconPosition == FUIButtonTextIconPosition.iconRightTextLeft) {
        buttonWidget = Directionality(
          textDirection: TextDirection.rtl,
          child: buttonWidget,
        );
      }

      return AbsorbPointer(
        absorbing: !enabled,
        child: AnimatedOpacity(
          opacity: enabled ? 1 : FUIButtonTheme.opacityDisabled,
          duration: widget.disabledOpacityAnimationDuration,
          child: buttonWidget,
        ),
      );
    }

    return BlocProvider.value(
      value: btnCtrl,
      child: BlocBuilder(
        bloc: btnCtrl,
        builder: bf,
      ),
    );
  }
}
