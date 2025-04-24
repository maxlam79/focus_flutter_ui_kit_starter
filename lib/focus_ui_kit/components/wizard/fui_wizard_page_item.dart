import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../exports.dart';

class FUIWizardPageItemLabel extends StatelessWidget {
  final Widget tabLine1;
  final Widget tabLine2;
  final FUIWizardPageItemLabelAlignment alignment;
  final FUIWizardPageItemLabelStyleOption styleOption;

  FUIWizardPageItemLabel({
    Key? key,
    required this.tabLine1,
    required this.tabLine2,
    this.alignment = FUIWizardPageItemLabelAlignment.left,
    this.styleOption = FUIWizardPageItemLabelStyleOption.style1,
  }) : super(key: key ?? UniqueKey());

  @override
  Widget build(BuildContext context) {
    FUIWizardTheme fuiWizardTheme = context.theme.fuiWizard;

    TextStyle defaultLine1Ts;
    TextStyle defaultLine2Ts;

    switch (styleOption) {
      case FUIWizardPageItemLabelStyleOption.style2:
        defaultLine1Ts = fuiWizardTheme.tsLabelLine1Style2;
        defaultLine2Ts = fuiWizardTheme.tsLabelLine2Style2;
        break;
      case FUIWizardPageItemLabelStyleOption.style1:
      default:
        defaultLine1Ts = fuiWizardTheme.tsLabelLine1Style1;
        defaultLine2Ts = fuiWizardTheme.tsLabelLine2Style1;

        break;
    }

    Widget w1 = IconTheme.merge(
      data: const IconThemeData().copyWith(
        color: defaultLine1Ts.color,
        size: defaultLine1Ts.fontSize,
      ),
      child: DefaultTextStyle(
        style: defaultLine1Ts,
        child: tabLine1,
      ),
    );

    Widget w2 = IconTheme.merge(
      data: const IconThemeData().copyWith(
        color: defaultLine2Ts.color,
        size: defaultLine2Ts.fontSize,
      ),
      child: DefaultTextStyle(
        style: defaultLine2Ts,
        child: tabLine2,
      ),
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: alignment == FUIWizardPageItemLabelAlignment.left ? CrossAxisAlignment.start : CrossAxisAlignment.end,
      children: [
        w1,
        w2,
      ],
    );
  }
}

class FUIWizardPageItem extends StatefulWidget {
  /// Wizard Tab
  final FUIColorScheme fuiColorScheme;
  final EdgeInsets? itemTabPadding;
  final bool selectable;
  final ValueGetter<bool>? selectableWhen;
  final VoidCallback? onSelected;
  final bool decoBarShow;
  final Color? decoBarActiveColor;
  final double decoBarHeight;
  final BorderRadius decoBarBorderRadius;
  final Duration decoBarAniDuration;
  final Curve decoBarAniCurve;

  /// Tab Item Content
  final Widget label; // can be FUIWizardTabLabel or some other widgets
  final FUIWizardPageItemLabelAlignment labelAlignment;
  final Widget content;

  FUIWizardPageItem({
    Key? key,
    this.fuiColorScheme = FUIColorScheme.primary,
    this.itemTabPadding,
    this.selectable = false,
    this.selectableWhen,
    this.onSelected,
    this.decoBarShow = true,
    this.decoBarActiveColor,
    this.decoBarHeight = FUIWizardTheme.decoBarHeight,
    this.decoBarBorderRadius = FUIWizardTheme.decoBarBorderRadius,
    this.decoBarAniDuration = FUIWizardTheme.decoBarAniDuration,
    this.decoBarAniCurve = FUIWizardTheme.decoBarAniCurve,
    required this.label,
    this.labelAlignment = FUIWizardPageItemLabelAlignment.left,
    required this.content,
  }) : super(key: key ?? UniqueKey());

  @override
  State<FUIWizardPageItem> createState() => _FUIWizardPageItemState();
}

class _FUIWizardPageItemState extends State<FUIWizardPageItem> with FUIColorMixin {
  /// Essentials
  late FUIThemeCommonColors fuiColors;
  late FUIWizardTheme wizTheme;

  /// Bloc
  late FUIWizardPageItemSelectController selectCtrl;

  /// Attributes and Flags
  bool isSelected = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    fuiColors = context.theme.fuiColors;
    wizTheme = context.theme.fuiWizard;

    selectCtrl = context.read<FUIWizardPageItemSelectController>();

    Container tabLabelContainer = Container(
      alignment: Alignment.center,
      padding: FUIWizardTheme.labelPadding,
      child: BlocBuilder(
        bloc: selectCtrl,
        builder: (BuildContext context, FUIWizardPageItemSelectEvent? event) {
          if (event != null) {
            isSelected = (event.selectedWizardItemKey == widget.key!);

            if (isSelected && widget.onSelected != null) {
              WidgetsBinding.instance.addPostFrameCallback((_) => widget.onSelected!());
            }
          }

          return widget.label;
        },
      ),
    );

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          if (widget.selectable) {
            if (widget.selectableWhen != null) {
              if (widget.selectableWhen!()) {
                context.read<FUIWizardPaneController>().gotoPageItemKey(widget.key!);

                selectCtrl.trigger(
                  FUIWizardPageItemSelectEvent(
                    selectedWizardItemKey: widget.key!,
                  ),
                );
              }
            } else {
              context.read<FUIWizardPaneController>().gotoPageItemKey(widget.key!);

              selectCtrl.trigger(
                FUIWizardPageItemSelectEvent(
                  selectedWizardItemKey: widget.key!,
                ),
              );
            }
          }
        },
        child: Container(
          padding: widget.itemTabPadding,
          child: IntrinsicWidth(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: widget.labelAlignment == FUIWizardPageItemLabelAlignment.left ? CrossAxisAlignment.start : CrossAxisAlignment.end,
              children: [
                tabLabelContainer,
                _FUIWizardPageItemDecoBar(
                  fuiWizardItemSelectController: selectCtrl,
                  alignment: widget.labelAlignment,
                  wizardItemKey: widget.key!,
                  decoBarActiveColor: widget.decoBarActiveColor ?? discernColorByScheme(context, fuiColorScheme: widget.fuiColorScheme),
                  decoBarHeight: widget.decoBarHeight,
                  decoBarBorderRadius: widget.decoBarBorderRadius,
                  decoBarAniDuration: widget.decoBarAniDuration,
                  decoBarAniCurve: widget.decoBarAniCurve,
                  isActivated: isSelected,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FUIWizardPageItemDecoBar extends StatefulWidget {
  final FUIWizardPageItemSelectController fuiWizardItemSelectController;
  final FUIWizardPageItemLabelAlignment alignment;
  final Key wizardItemKey;
  final Color decoBarActiveColor;
  final double decoBarHeight;
  final BorderRadius decoBarBorderRadius;
  final Duration decoBarAniDuration;
  final Curve decoBarAniCurve;
  final bool isActivated;

  _FUIWizardPageItemDecoBar({
    Key? key,
    required this.fuiWizardItemSelectController,
    required this.alignment,
    required this.wizardItemKey,
    required this.decoBarActiveColor,
    this.decoBarHeight = FUIWizardTheme.decoBarHeight,
    this.decoBarBorderRadius = FUIWizardTheme.decoBarBorderRadius,
    this.decoBarAniDuration = FUIWizardTheme.decoBarAniDuration,
    this.decoBarAniCurve = FUIWizardTheme.decoBarAniCurve,
    required this.isActivated,
  }) : super(key: key ?? UniqueKey());

  @override
  State<_FUIWizardPageItemDecoBar> createState() => _FUIWizardPageItemDecoBarState();
}

class _FUIWizardPageItemDecoBarState extends State<_FUIWizardPageItemDecoBar> with SingleTickerProviderStateMixin {
  /// Theme
  late FUIThemeCommonColors fuiColors;
  late FUITabTheme tabTheme;

  /// Bloc
  late FUIWizardPageItemSelectController wisCtrl;

  /// Animation
  late AnimationController decoBarAniCtrl;
  late Tween<double> decoBarValueTween;
  late Animation<double> decoBarAni;

  /// Other variables and flags
  late bool isActivated;
  double decoBarValue = FUITabTheme.decoBarAniCtrlLowerBound;

  @override
  void initState() {
    super.initState();

    isActivated = widget.isActivated;
    wisCtrl = widget.fuiWizardItemSelectController;

    _initAnimations();
  }

  _initAnimations() {
    decoBarAniCtrl = AnimationController(
      duration: widget.decoBarAniDuration,
      vsync: this,
      value: decoBarValue,
    );

    decoBarAni = CurvedAnimation(
      parent: decoBarAniCtrl,
      curve: widget.decoBarAniCurve,
    );

    decoBarValueTween = Tween<double>(
      begin: FUIWizardTheme.decoBarAniLowerBound,
      end: FUIWizardTheme.decoBarAniUpperBound,
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
    tabTheme = context.theme.fuiTab;

    if (isActivated) {
      _activateDecoBar();
    }

    return BlocProvider(
      create: (_) => wisCtrl,
      child: BlocBuilder(
        bloc: wisCtrl,
        builder: (BuildContext context, FUIWizardPageItemSelectEvent? event) {
          bool activate = isActivated;

          if (event != null) {
            activate = (event.selectedWizardItemKey.hashCode == widget.wizardItemKey.hashCode);
          }

          if (activate && !isActivated) {
            _activateDecoBar();
          } else if (!activate && isActivated) {
            _deactivateDecoBar();
          }

          return SizedBox(
            height: widget.decoBarHeight,
            width: double.infinity,
            child: Visibility(
              visible: isActivated,
              child: AnimatedBuilder(
                animation: decoBarAni,
                builder: (context, child) {
                  return Row(
                    children: _discernDecoBars(),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }

  List<Widget> _discernDecoBars() {
    List<Widget> wList = [];

    if (widget.alignment == FUIWizardPageItemLabelAlignment.right) {
      wList.add(
        Expanded(
          flex: decoBarValueTween.evaluate(decoBarAni).toInt(),
          child: Container(
            margin: EdgeInsets.zero,
            padding: EdgeInsets.zero,
            height: widget.decoBarHeight,
            color: Colors.transparent,
          ),
        ),
      );

      wList.add(
        Expanded(
          flex: (FUIWizardTheme.decoBarAniUpperBound - decoBarValueTween.evaluate(decoBarAni)).toInt(),
          child: Container(
            margin: EdgeInsets.zero,
            padding: EdgeInsets.zero,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: widget.decoBarActiveColor,
              border: Border.all(
                width: FUITabTheme.decoBarBorderWidth,
                color: widget.decoBarActiveColor,
              ),
              borderRadius: widget.decoBarBorderRadius,
            ),
            height: widget.decoBarHeight,
          ),
        ),
      );
    } else {
      wList.add(
        Expanded(
          flex: decoBarValueTween.evaluate(decoBarAni).toInt(),
          child: Container(
            margin: EdgeInsets.zero,
            padding: EdgeInsets.zero,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: widget.decoBarActiveColor,
              border: Border.all(
                width: FUITabTheme.decoBarBorderWidth,
                color: widget.decoBarActiveColor,
              ),
              borderRadius: widget.decoBarBorderRadius,
            ),
            height: widget.decoBarHeight,
          ),
        ),
      );

      wList.add(
        Expanded(
          flex: (FUIWizardTheme.decoBarAniUpperBound - decoBarValueTween.evaluate(decoBarAni)).toInt(),
          child: Container(
            margin: EdgeInsets.zero,
            padding: EdgeInsets.zero,
            height: widget.decoBarHeight,
            color: Colors.transparent,
          ),
        ),
      );
    }

    return wList;
  }

  _activateDecoBar() {
    try {
      decoBarAniCtrl.reset();
      decoBarAniCtrl.forward();
    } catch (e) {
      // Absorb
    }

    isActivated = true;
  }

  _deactivateDecoBar() {
    isActivated = false;

    try {
      decoBarAniCtrl.reset();
    } catch (e) {
      // Absorb
    }
  }
}
