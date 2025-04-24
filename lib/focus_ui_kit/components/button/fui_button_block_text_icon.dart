import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuple/tuple.dart';

import '../../exports.dart';

class FUIButtonBlockTextIcon extends StatefulWidget {
  final Text text;
  final Icon? icon;
  final FUIButtonTextIconPosition fuiButtonTextIconPosition; // If no icon, text will be at the center.
  final FUIColorScheme fuiColorScheme; // If no style exists, color scheme will be used.
  final FUIButtonSize fuiButtonSize;
  final FUIButtonShape fuiButtonShape;
  final FUIButtonBlockLevel fuiButtonBlockLevel;
  final FUIButtonController? fuiButtonController;
  final Color? backgroundColor; // fuiButtonColorScheme will override backgroundColor
  final VoidCallback onPressed;
  final VoidCallback? onLongPress;
  final ValueChanged<bool>? onHover;
  final ValueChanged<bool>? onFocusChange;
  final FocusNode? focusNode;
  final bool autofocus;
  final Clip clipBehavior;
  final WidgetStatesController? statesController;
  final Duration disabledOpacityAnimationDuration;

  FUIButtonBlockTextIcon({
    Key? key,
    required this.text,
    this.icon,
    this.fuiButtonTextIconPosition = FUIButtonTextIconPosition.iconLeftTextRight,
    this.fuiColorScheme = FUIColorScheme.primary,
    this.fuiButtonSize = FUIButtonSize.medium,
    this.fuiButtonShape = FUIButtonShape.square,
    this.fuiButtonBlockLevel = FUIButtonBlockLevel.fit,
    this.fuiButtonController,
    this.backgroundColor,
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
  State<FUIButtonBlockTextIcon> createState() => _FUIButtonBlockTextIconState();
}

class _FUIButtonBlockTextIconState extends State<FUIButtonBlockTextIcon> with FUIButtonMixin {
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

    Tuple2<TextStyle, Color> textAndBgColorTuple = discernTextStyleBgColor(context, widget, 1);
    Tuple2<double, double> widthHeightTuple = discernWidthHeight(widget, widget.text.style ?? textAndBgColorTuple.item1);
    double cWidth = widthHeightTuple.item1, cHeight = widthHeightTuple.item2;
    OutlinedBorder shape = discernShape(widget.fuiButtonShape);
    Color backgroundColor = widget.backgroundColor ?? textAndBgColorTuple.item2;

    ButtonStyle buttonStyle = (widget.fuiButtonBlockLevel == FUIButtonBlockLevel.fit)
        ? ElevatedButton.styleFrom(
            fixedSize: Size(cWidth, cHeight),
            elevation: 0,
            backgroundColor: backgroundColor,
            splashFactory: NoSplash.splashFactory,
            side: BorderSide(
              width: 0.1,
              color: textAndBgColorTuple.item2,
            ),
            shape: shape,
          ).copyWith(
            overlayColor: WidgetStateProperty.all(buttonTheme.buttonOverlayColor),
          )
        : ElevatedButton.styleFrom(
            fixedSize: Size.fromHeight(cHeight),
            elevation: 0,
            backgroundColor: backgroundColor,
            splashFactory: NoSplash.splashFactory,
            side: BorderSide(
              width: 0.1,
              color: textAndBgColorTuple.item2,
            ),
            shape: shape,
          ).copyWith(
            overlayColor: WidgetStateProperty.all(buttonTheme.buttonOverlayColor),
          );

    bf(BuildContext context, FUIButtonEvent? event) {
      discernFUIButtonEvents(widget, event);

      Widget buttonWidget;

      if (widget.icon != null) {
        buttonWidget = ElevatedButton.icon(
          onPressed: widget.onPressed,
          onLongPress: widget.onLongPress,
          onHover: widget.onHover,
          onFocusChange: widget.onFocusChange,
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
        );
      } else {
        buttonWidget = ElevatedButton(
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
          height: cHeight,
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

    return BlocProvider<FUIButtonController>.value(
      value: btnCtrl,
      child: BlocBuilder(
        bloc: btnCtrl,
        builder: bf,
      ),
    );
  }
}
