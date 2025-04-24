import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../exports.dart';

class FUIButtonLinkIcon extends StatefulWidget {
  final Widget icon;
  final Widget? selectedIcon;
  final FUIColorScheme fuiColorScheme;
  final FUIButtonSize fuiButtonSize;
  final FUIButtonController? fuiButtonController;
  final VoidCallback onPressed;
  final VoidCallback? onLongPress;
  final ValueChanged<bool>? onHover;
  final ValueChanged<bool>? onFocusChange;
  final FocusNode? focusNode;
  final bool autofocus;
  final bool isSelected;
  final MouseCursor? mouseCursor;
  final String? tooltip;
  final Duration disabledOpacityAnimationDuration;

  FUIButtonLinkIcon({
    Key? key,
    required this.icon,
    this.selectedIcon,
    this.fuiColorScheme = FUIColorScheme.secondary,
    this.fuiButtonSize = FUIButtonSize.medium,
    this.fuiButtonController,
    required this.onPressed,
    this.onLongPress,
    this.onHover,
    this.onFocusChange,
    this.focusNode,
    this.autofocus = false,
    this.isSelected = false,
    this.mouseCursor,
    this.tooltip,
    this.disabledOpacityAnimationDuration = FUIButtonTheme.opacityAnimationDuration,
  }) : super(key: key ?? UniqueKey());

  @override
  State<FUIButtonLinkIcon> createState() => _FUIButtonLinkIconState();
}

class _FUIButtonLinkIconState extends State<FUIButtonLinkIcon> with FUIButtonMixin, FUIColorMixin {
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
    double iconSize;

    switch (widget.fuiButtonSize) {
      case FUIButtonSize.small:
        // iconSize = FUIButtonTheme.iconSizeSmall * FUIButtonTheme.heightFactorSmall;
        iconSize = FUIButtonTheme.iconSizeSmall + FUIButtonTheme.heightBufferSmall;
        break;
      case FUIButtonSize.large:
        // iconSize = FUIButtonTheme.iconSizeLarge * FUIButtonTheme.heightFactorLarge;
        iconSize = FUIButtonTheme.iconSizeLarge + FUIButtonTheme.heightBufferLarge;
        break;
      case FUIButtonSize.medium:
      default:
        // iconSize = FUIButtonTheme.iconSizeMedium * FUIButtonTheme.heightFactorMedium;
        iconSize = FUIButtonTheme.iconSizeMedium + FUIButtonTheme.heightBufferMedium;
        break;
    }

    Color iconColor = discernColorByScheme(context, fuiColorScheme: widget.fuiColorScheme);

    bf(BuildContext context, FUIButtonEvent? event) {
      discernFUIButtonEvents(widget, event);

      return AbsorbPointer(
        absorbing: !enabled,
        child: AnimatedOpacity(
          opacity: enabled ? 1 : FUIButtonTheme.opacityDisabled,
          duration: widget.disabledOpacityAnimationDuration,
          child: IconTheme.merge(
            data: IconThemeData(
              size: iconSize,
              color: iconColor,
            ),
            child: GestureDetector(
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
              onLongPress: widget.onLongPress,
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
                child: IconButton(
                  iconSize: iconSize,
                  visualDensity: VisualDensity.compact,
                  onPressed: widget.onPressed,
                  icon: widget.icon,
                  selectedIcon: widget.selectedIcon,
                  padding: EdgeInsets.zero,
                  alignment: Alignment.center,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  mouseCursor: widget.mouseCursor,
                  focusNode: widget.focusNode,
                  autofocus: widget.autofocus,
                  tooltip: widget.tooltip,
                  isSelected: widget.isSelected,
                  style: ButtonStyle(
                    padding: WidgetStateProperty.all(EdgeInsets.zero),
                    overlayColor: WidgetStateProperty.all(Colors.transparent),
                  ),
                ),
              ),
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
