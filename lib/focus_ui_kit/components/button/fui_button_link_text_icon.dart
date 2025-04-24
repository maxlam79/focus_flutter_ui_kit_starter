import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuple/tuple.dart';

import '../../exports.dart';

class FUIButtonLinkTextIcon extends StatefulWidget {
  final Text text;
  final Icon? icon;
  final FUIButtonTextIconPosition fuiButtonTextIconPosition; // If no icon, text will be at the center.
  final FUIButtonSize fuiButtonSize;
  final FUIButtonBlockLevel fuiButtonBlockLevel;
  final FUIButtonController? fuiButtonController;
  final bool onHoverUnderline;
  final Text? onHoverText; // Overwrites underline styles
  final Icon? onHoverIcon;
  final VoidCallback onPressed;
  final VoidCallback? onLongPress;
  final ValueChanged<bool>? onHover;
  final ValueChanged<bool>? onFocusChange;
  final FocusNode? focusNode;
  final bool autofocus;
  final Clip clipBehavior;
  final WidgetStatesController? statesController;
  final Duration disabledOpacityAnimationDuration;

  FUIButtonLinkTextIcon({
    Key? key,
    required this.text,
    this.icon,
    this.fuiButtonTextIconPosition = FUIButtonTextIconPosition.iconLeftTextRight,
    this.fuiButtonSize = FUIButtonSize.medium,
    this.fuiButtonBlockLevel = FUIButtonBlockLevel.fit,
    this.fuiButtonController,
    this.onHoverUnderline = true,
    this.onHoverText,
    this.onHoverIcon,
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
  State<FUIButtonLinkTextIcon> createState() => _FUIButtonLinkTextIconState();
}

class _FUIButtonLinkTextIconState extends State<FUIButtonLinkTextIcon> with FUIButtonMixin {
  /// Themes
  late FUIButtonTheme buttonTheme;

  /// Bloc
  late FUIButtonController btnCtrl;
  late _FUIButtonHoverController hoverCtrl;
  bool blocProviderNewCreate = false;

  /// Attributes and flags
  Tuple2<double, double> widthHeightTuple = const Tuple2(0, 0);
  late TextStyle linkTextStyle;
  late TextStyle linkHoverTextStyle;
  late Widget contentNonHover;
  late Widget contentOnHover;
  late Widget content;

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
    hoverCtrl = _FUIButtonHoverController();
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
    FUIButtonTheme buttonTheme = context.theme.fuiButton;
    double fontSize = FUIButtonTheme.fontSizeMedium;

    switch (widget.fuiButtonSize) {
      case FUIButtonSize.small:
        fontSize = FUIButtonTheme.fontSizeSmall;
        break;
      case FUIButtonSize.large:
        fontSize = FUIButtonTheme.fontSizeLarge;
        break;
      case FUIButtonSize.medium:
      default:
        fontSize = FUIButtonTheme.fontSizeMedium;
        break;
    }

    linkTextStyle = buttonTheme.linkedButtonTextStyle.copyWith(fontSize: fontSize);
    linkHoverTextStyle = buttonTheme.linkedButtonHoverTextStyle.copyWith(
      fontSize: fontSize,
      decoration: widget.onHoverUnderline ? TextDecoration.underline : TextDecoration.none,
      decorationThickness: FUIButtonTheme.linkedTextButtonTextDecorationThickness,
      decorationStyle: FUIButtonTheme.linkedTextButtonTextDecorationStyle,
    );

    /// Need to have a different way of calculating width and height
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: widget.text.data, style: widget.text.style ?? linkTextStyle),
      textDirection: TextDirection.ltr,
      textScaler: TextScaler.linear(WidgetsBinding.instance.platformDispatcher.textScaleFactor),
      // textScaleFactor: WidgetsBinding.instance.platformDispatcher.textScaleFactor,
    )..layout();

    double cHeight = textPainter.height;
    double cWidth = textPainter.width + (widget.icon != null ? discernIconSize(widget.fuiButtonSize) + FUIButtonTheme.textLinkWidthSpacerForCalc : 0);

    switch (widget.fuiButtonSize) {
      case FUIButtonSize.small:
        cHeight += FUIButtonTheme.textLinkHeightBufferSmall;
        cWidth += FUIButtonTheme.textLinkWidthBufferSmall;
        break;
      case FUIButtonSize.large:
        cHeight += FUIButtonTheme.textLinkHeightBufferLarge;
        cWidth += FUIButtonTheme.textLinkWidthBufferLarge;
        break;
      case FUIButtonSize.medium:
      default:
        cHeight += FUIButtonTheme.textLinkHeightBufferMedium;
        cWidth += FUIButtonTheme.textLinkWidthBufferMedium;
        break;
    }

    ButtonStyle buttonStyle = (widget.fuiButtonBlockLevel == FUIButtonBlockLevel.fit)
        ? TextButton.styleFrom(
            fixedSize: Size(cWidth, cHeight),
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            elevation: 0,
            splashFactory: NoSplash.splashFactory,
          ).copyWith(
            overlayColor: WidgetStateProperty.all(Colors.transparent),
          )
        : TextButton.styleFrom(
            fixedSize: Size.fromHeight(cHeight),
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            elevation: 0,
            splashFactory: NoSplash.splashFactory,
            backgroundColor: Colors.transparent,
          ).copyWith(
            overlayColor: WidgetStateProperty.all(Colors.transparent),
          );

    BlocBuilder bb2 = BlocBuilder<_FUIButtonHoverController, bool>(
      bloc: hoverCtrl,
      builder: (BuildContext context, bool hovered) {
        Widget buttonWidget;

        if (widget.icon != null) {
          buttonWidget = TextButton.icon(
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
              style: hovered ? linkHoverTextStyle : linkTextStyle,
              child: hovered ? (widget.onHoverText ?? widget.text) : widget.text,
            ),
            icon: IconTheme.merge(
              data: const IconThemeData().copyWith(
                color: hovered ? linkHoverTextStyle.color : linkTextStyle.color,
                size: discernIconSize(widget.fuiButtonSize),
              ),
              child: widget.icon!,
            ),
          );
        } else {
          buttonWidget = TextButton(
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
              style: hovered ? linkHoverTextStyle : linkTextStyle,
              child: hovered ? (widget.onHoverText ?? widget.text) : widget.text,
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

        return MouseRegion(
          onEnter: (_) => hoverCtrl.triggerHover(true),
          onExit: (_) => hoverCtrl.triggerHover(false),
          child: buttonWidget,
        );
      },
    );

    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: btnCtrl),
        BlocProvider(
          create: (_) => hoverCtrl,
        ),
      ],
      child: BlocBuilder(
        bloc: btnCtrl,
        builder: (BuildContext context, FUIButtonEvent? event) {
          discernFUIButtonEvents(widget, event);

          return AbsorbPointer(
            absorbing: !enabled,
            child: AnimatedOpacity(
              opacity: enabled ? 1 : FUIButtonTheme.opacityDisabled,
              duration: widget.disabledOpacityAnimationDuration,
              child: bb2,
            ),
          );
        },
      ),
    );
  }
}

class _FUIButtonHoverController extends Cubit<bool> {
  bool hover = false;

  _FUIButtonHoverController() : super(false);

  triggerHover(bool hover) {
    this.hover = hover;
    emit(this.hover);
  }
}
