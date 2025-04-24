import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuple/tuple.dart';

import '../../exports.dart';

class FUIButtonBlockCircleIcon extends StatefulWidget {
  final Icon icon;
  final FUIColorScheme fuiColorScheme;
  final FUIButtonSize fuiButtonSize;
  final FUIButtonController? fuiButtonController;
  final EdgeInsets? padding;
  final Color? backgroundColor;
  final VoidCallback onPressed;
  final VoidCallback? onLongPress;
  final ValueChanged<bool>? onHover;
  final ValueChanged<bool>? onFocusChange;
  final FocusNode? focusNode;
  final bool autofocus;
  final Clip clipBehavior;
  final WidgetStatesController? statesController;
  final Duration disabledOpacityAnimationDuration;

  FUIButtonBlockCircleIcon({
    Key? key,
    required this.icon,
    this.fuiColorScheme = FUIColorScheme.primary,
    this.fuiButtonSize = FUIButtonSize.medium,
    this.fuiButtonController,
    this.padding,
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
  State<FUIButtonBlockCircleIcon> createState() => _FUIButtonBlockCircleIconState();
}

class _FUIButtonBlockCircleIconState extends State<FUIButtonBlockCircleIcon> with FUIButtonMixin {
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
    final Tuple2<Color, Color> textAndBgColorTuple = discernCircleIconColor(context, widget, 1);

    Color iconColor = textAndBgColorTuple.item1;
    Color bgColor = widget.backgroundColor ?? textAndBgColorTuple.item2;
    double iconSize = widget.icon.size ?? discernCircleIconSize(widget);

    ButtonStyle buttonStyle = ElevatedButton.styleFrom(
      elevation: 0,
      backgroundColor: bgColor,
      splashFactory: NoSplash.splashFactory,
      shape: const CircleBorder(),
      padding: EdgeInsets.zero,
    ).copyWith(
      overlayColor: WidgetStateProperty.all(Colors.transparent),
    );

    Widget icon = IconTheme.merge(
      data: const IconThemeData().copyWith(
        color: iconColor,
        size: iconSize,
      ),
      child: widget.icon,
    );

    bf(BuildContext context, FUIButtonEvent? event) {
      discernFUIButtonEvents(widget, event);

      return AbsorbPointer(
        absorbing: !enabled,
        child: AnimatedOpacity(
          opacity: enabled ? 1 : FUIButtonTheme.opacityDisabled,
          duration: widget.disabledOpacityAnimationDuration,
          child: ElevatedButton(
            onPressed: widget.onPressed,
            onLongPress: widget.onLongPress,
            onHover: widget.onHover,
            onFocusChange: widget.onFocusChange,
            style: buttonStyle,
            focusNode: widget.focusNode,
            autofocus: widget.autofocus,
            clipBehavior: widget.clipBehavior,
            statesController: widget.statesController,
            child: Padding(
              padding: widget.padding ?? EdgeInsets.all(discernCircleIconPaddingSize(widget)),
              child: icon,
            ),
          ),
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
