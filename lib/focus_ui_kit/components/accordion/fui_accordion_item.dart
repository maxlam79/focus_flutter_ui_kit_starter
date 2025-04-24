import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../exports.dart';

class FUIAccordionItem extends StatefulWidget {
  final FUIColorScheme fuiColorScheme;
  final bool initialExpanded;
  final ValueSetter<bool>? onAccordionChanged;

  /// Accordion Head
  final Text headLabel;
  final Icon? headIcon;
  final FUIAccordionHeadTextIconPosition? fuiAccordionHeadSideIconPosition;
  final double? accordionHeadIconTextHSpace;
  final EdgeInsets? accordionHeadLabelPadding;
  final EdgeInsets? accordionHeadPadding;
  final Color? decoBarActiveColor;
  final Color? decoBarInactiveColor;
  final double? decoBarThickness;
  final BorderRadius? decoBarBorderRadius;
  final Duration? decoBarAniDuration;
  final Curve? decoBarAniCurve;
  final bool sideDecoExpAniIconEnable;
  final String? sideDecoExpAniIconLottiePath;
  final Duration? sideDecoExpAniIconDuration;
  final EdgeInsets? sideDecoExpAniIconPadding;
  final double? sideDecoExpAniIconSize;

  /// Accordion Content
  final Widget content;
  final double? contentHeight;
  final EdgeInsets? contentPadding;
  final EdgeInsets? contentMargin;

  FUIAccordionItem({
    Key? key,
    this.fuiColorScheme = FUIColorScheme.primary,
    this.initialExpanded = false,
    this.onAccordionChanged,
    required this.headLabel,
    this.headIcon,
    this.fuiAccordionHeadSideIconPosition = FUIAccordionHeadTextIconPosition.iconLeftTextRight,
    this.accordionHeadIconTextHSpace,
    this.accordionHeadLabelPadding,
    this.accordionHeadPadding,
    this.decoBarActiveColor,
    this.decoBarInactiveColor,
    this.decoBarThickness,
    this.decoBarBorderRadius,
    this.decoBarAniDuration,
    this.decoBarAniCurve,
    this.sideDecoExpAniIconEnable = false,
    this.sideDecoExpAniIconLottiePath,
    this.sideDecoExpAniIconDuration,
    this.sideDecoExpAniIconPadding,
    this.sideDecoExpAniIconSize,
    required this.content,
    this.contentHeight = FUIAccordionTheme.accordionContentViewHeight,
    this.contentPadding = FUIAccordionTheme.accordionContentViewPadding,
    this.contentMargin,
  }) : super(key: key ?? UniqueKey());

  @override
  State<FUIAccordionItem> createState() => _FUIAccordionItemState();
}

class _FUIAccordionItemState extends State<FUIAccordionItem> with SingleTickerProviderStateMixin, FUIColorMixin {
  /// Theme
  late FUIThemeCommonColors fuiColors;
  late FUIAccordionTheme fuiAccordionTheme;

  /// Bloc
  late FUIAccordionController accCtrl;

  /// Animation
  late AnimationController lottieAniCtrl;

  /// Attributes and Flags
  late bool isExpanded;

  @override
  void initState() {
    super.initState();

    isExpanded = widget.initialExpanded;

    _initAnimation();
    _initDecoForExpanded();
  }

  _initAnimation() {
    lottieAniCtrl = AnimationController(
      duration: widget.sideDecoExpAniIconDuration ?? FUIAccordionTheme.sideDecoExpAniIconDuration,
      value: 0,
      vsync: this,
    );
  }

  _initDecoForExpanded() {
    if (isExpanded) {
      WidgetsBinding.instance.addPostFrameCallback((_) => accCtrl.trigger(
            FUIAccordionEvent(
              itemKey: widget.key!,
              expand: isExpanded, // toggle
            ),
          ));
    }
  }

  @override
  void dispose() {
    lottieAniCtrl.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    fuiColors = context.theme.fuiColors;
    fuiAccordionTheme = context.theme.fuiAccordion;
    accCtrl = context.read<FUIAccordionController>();

    Container tabLabelContainer = Container(
      alignment: Alignment.center,
      padding: widget.accordionHeadLabelPadding ?? FUIAccordionTheme.accordionHeadLabelPadding,
      child: _buildIconTextWidget(),
    );

    Color decoBarActiveColor = widget.decoBarActiveColor ?? discernColorByScheme(context, fuiColorScheme: widget.fuiColorScheme);

    return Container(
      padding: widget.accordionHeadPadding ?? FUIAccordionTheme.accordionHeadPadding,
      child: IntrinsicWidth(
        child: GestureDetector(
          onTap: () {
            accCtrl.trigger(
              FUIAccordionEvent(
                itemKey: widget.key!,
                expand: !isExpanded, // toggle
              ),
            );
          },
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                tabLabelContainer,
                _FUIAccordionHeadDecoBar(
                  accordionItemKey: widget.key!,
                  fuiAccordionController: accCtrl,
                  isActivated: isExpanded,
                  decoBarActiveColor: decoBarActiveColor,
                  decoBarInactiveColor: widget.decoBarInactiveColor,
                  decoBarThickness: widget.decoBarThickness,
                  decoBarBorderRadius: widget.decoBarBorderRadius,
                  decoBarAniDuration: widget.decoBarAniDuration,
                  decoBarAniCurve: widget.decoBarAniCurve,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIconTextWidget() {
    return BlocBuilder<FUIAccordionController, FUIAccordionEvent?>(builder: (context, FUIAccordionEvent? event) {
      Widget iconTextWidget;
      SizedBox hSpace =
          widget.accordionHeadIconTextHSpace != null ? SizedBox(width: widget.accordionHeadIconTextHSpace!) : FUIAccordionTheme.accordionHeadIconTextHSpace;

      if (event != null) {
        if (event.itemKey.hashCode == widget.key.hashCode) {
          if (isExpanded != event.expand) {
            isExpanded = event.expand;
          }

          if (widget.onAccordionChanged != null) {
            widget.onAccordionChanged!(isExpanded);
          }
        }
      }

      if (isExpanded) {
        if (widget.sideDecoExpAniIconEnable) {
          lottieAniCtrl.forward();
        }
      } else {
        if (widget.sideDecoExpAniIconEnable) {
          lottieAniCtrl.reverse();
        }
      }

      TextStyle ts = isExpanded ? fuiAccordionTheme.tsAccordionHeadLabelExpanded : fuiAccordionTheme.tsAccordionHeadLabel;
      List<Widget> wList = [];

      Widget label = DefaultTextStyle(
        style: ts,
        child: widget.headLabel,
      );

      Widget? icon;

      if (widget.headIcon != null) {
        icon = IconTheme.merge(
          data: IconThemeData(
            color: ts.color,
            size: FUIAccordionTheme.accordionHeadIconSize,
          ),
          child: widget.headIcon!,
        );
      }

      switch (widget.fuiAccordionHeadSideIconPosition) {
        case FUIAccordionHeadTextIconPosition.iconRightTextLeft:
          wList.add(label);

          if (widget.headIcon != null) {
            wList.add(hSpace);
            wList.add(icon!);
          }

          iconTextWidget = Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: wList,
          );
          break;
        case FUIAccordionHeadTextIconPosition.iconLeftTextRight:
        default:
          if (widget.headIcon != null) {
            wList.add(icon!);
            wList.add(hSpace);
          }

          wList.add(label);

          iconTextWidget = Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: wList,
          );
          break;
      }

      if (widget.sideDecoExpAniIconEnable) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            iconTextWidget,
            Padding(
              padding: widget.sideDecoExpAniIconPadding ?? FUIAccordionTheme.sideDecoExpAniIconPadding,
              child: Lottie.asset(
                widget.sideDecoExpAniIconLottiePath ?? FUIAccordionTheme.sideDecoExpAniIconLottiePath,
                controller: lottieAniCtrl,
                width: widget.sideDecoExpAniIconSize ?? FUIAccordionTheme.sideDecoExpAniIconWidth,
                height: widget.sideDecoExpAniIconSize ?? FUIAccordionTheme.sideDecoExpAniIconHeight,
              ),
            ),
          ],
        );
      } else {
        return iconTextWidget;
      }
    });
  }
}

class _FUIAccordionHeadDecoBar extends StatefulWidget {
  final FUIAccordionController fuiAccordionController;
  final Key accordionItemKey;
  final Color decoBarActiveColor;
  final Color? decoBarInactiveColor;
  final double? decoBarThickness;
  final BorderRadius? decoBarBorderRadius;
  final Duration? decoBarAniDuration;
  final Curve? decoBarAniCurve;
  final bool isActivated;

  _FUIAccordionHeadDecoBar({
    Key? key,
    required this.fuiAccordionController,
    required this.accordionItemKey,
    required this.decoBarActiveColor,
    this.decoBarInactiveColor,
    this.decoBarThickness,
    this.decoBarBorderRadius,
    this.decoBarAniDuration,
    this.decoBarAniCurve,
    required this.isActivated,
  }) : super(key: key ?? UniqueKey());

  @override
  State<_FUIAccordionHeadDecoBar> createState() => _FUIAccordionHeadDecoBarState();
}

class _FUIAccordionHeadDecoBarState extends State<_FUIAccordionHeadDecoBar> with SingleTickerProviderStateMixin {
  /// Theme
  late FUIThemeCommonColors fuiColors;
  late FUIAccordionTheme fuiAccordionTheme;

  /// Bloc
  late FUIAccordionController accCtrl;

  /// Animation
  late AnimationController decoBarAniCtrl;
  late Tween<double> decoBarValueTween;
  late Animation<double> decoBarAni;

  /// Other variables and flags
  late bool isActivated;
  double decoBarValue = FUIAccordionTheme.decoBarAniCtrlLowerBound;

  @override
  void initState() {
    super.initState();

    isActivated = widget.isActivated;
    accCtrl = widget.fuiAccordionController;

    _initAnimations();
  }

  _initAnimations() {
    decoBarAniCtrl = AnimationController(
      duration: widget.decoBarAniDuration ?? FUIAccordionTheme.decoBarAniDuration,
      vsync: this,
      value: decoBarValue,
    );

    decoBarAni = CurvedAnimation(
      parent: decoBarAniCtrl,
      curve: widget.decoBarAniCurve ?? FUIAccordionTheme.decoBarAniCurve,
    );

    decoBarValueTween = Tween<double>(
      begin: FUIAccordionTheme.decoBarAniLowerBound,
      end: FUIAccordionTheme.decoBarAniUpperBound,
    );
  }

  @override
  void dispose() {
    decoBarAniCtrl.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    fuiColors = context.theme.fuiColors;
    fuiAccordionTheme = context.theme.fuiAccordion;

    return BlocProvider.value(
      value: accCtrl,
      child: BlocBuilder(
        bloc: accCtrl,
        builder: (BuildContext context, FUIAccordionEvent? event) {
          bool activate = false;

          if (event != null) {
            if (event.itemKey == widget.accordionItemKey) {
              activate = event.expand;
            }
          }

          if (activate && !isActivated) {
            _activateDecoBar();
          } else if (!activate && isActivated) {
            _deactivateDecoBar();
          }

          return SizedBox(
            height: FUIAccordionTheme.decoBarThickness,
            width: double.infinity,
            child: AnimatedBuilder(
              animation: decoBarAni,
              builder: (context, child) {
                return Row(
                  children: [
                    Visibility(
                      visible: isActivated,
                      child: Expanded(
                        flex: decoBarValueTween.evaluate(decoBarAni).toInt(),
                        child: Container(
                          margin: EdgeInsets.zero,
                          padding: EdgeInsets.zero,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: widget.decoBarActiveColor,
                            border: Border.all(
                              width: FUIAccordionTheme.decoBarBorderWidth,
                              color: widget.decoBarActiveColor,
                            ),
                            borderRadius: widget.decoBarBorderRadius ?? FUIAccordionTheme.decoBarBorderRadius,
                          ),
                          height: FUIAccordionTheme.decoBarThickness,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: (FUIAccordionTheme.decoBarAniUpperBound - decoBarValueTween.evaluate(decoBarAni)).toInt(),
                      child: Container(
                        margin: EdgeInsets.zero,
                        padding: EdgeInsets.zero,
                        height: FUIAccordionTheme.decoBarThickness,
                        color: widget.decoBarInactiveColor ?? fuiAccordionTheme.decoBarInactiveColor,
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }

  _activateDecoBar() {
    try {
      decoBarAniCtrl.forward();
    } catch (e) {
      // Absorb
    }

    isActivated = true;
  }

  _deactivateDecoBar() {
    try {
      decoBarAniCtrl.reset();
    } catch (e) {
      // Absorb
    }

    isActivated = false;
  }
}
