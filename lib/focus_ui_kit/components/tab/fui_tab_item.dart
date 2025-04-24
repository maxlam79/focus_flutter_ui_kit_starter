import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../exports.dart';

class FUITabItem extends StatefulWidget {
  /// Tab Item Head
  final FUIColorScheme fuiColorScheme;
  final bool initialSelected;
  final Text tabHeadLabel;
  final Icon? tabHeadIcon;
  final FUITabHeadTextIconPosition? fuiTabHeadSideIconPosition;
  final double? tabHeadIconTextHSpace;
  final double? tabHeadIconTextVSpace;
  final VoidCallback? onTabSelected;
  final Color? decoBarActiveColor;
  final double decoBarHeight;
  final BorderRadius decoBarBorderRadius;
  final Duration decoBarAniDuration;
  final Curve decoBarAniCurve;

  /// Tab Item Content
  final Widget content;

  FUITabItem({
    Key? key,
    this.fuiColorScheme = FUIColorScheme.primary,
    this.initialSelected = false,
    required this.tabHeadLabel,
    this.tabHeadIcon,
    this.fuiTabHeadSideIconPosition,
    this.tabHeadIconTextHSpace,
    this.tabHeadIconTextVSpace,
    this.onTabSelected,
    this.decoBarActiveColor,
    this.decoBarHeight = FUITabTheme.decoBarHeight,
    this.decoBarBorderRadius = FUITabTheme.decoBarBorderRadius,
    this.decoBarAniDuration = FUITabTheme.decoBarAniDuration,
    this.decoBarAniCurve = FUITabTheme.decoBarAniCurve,
    required this.content,
  }) : super(key: key ?? UniqueKey());

  @override
  State<FUITabItem> createState() => _FUITabItemState();
}

class _FUITabItemState extends State<FUITabItem> with FUIColorMixin {
  /// Essentials
  late FUIThemeCommonColors fuiColors;
  late FUITabTheme fuiTabTheme;

  /// Bloc
  late FUITabPaneController tpCtrl;

  /// Attributes and Flags
  bool isSelected = false;

  @override
  void initState() {
    super.initState();

    isSelected = widget.initialSelected;
  }

  @override
  Widget build(BuildContext context) {
    fuiColors = context.theme.fuiColors;
    fuiTabTheme = context.theme.fuiTab;
    tpCtrl = context.read<FUITabPaneController>();

    Container tabLabelContainer = Container(
      alignment: Alignment.center,
      padding: FUITabTheme.tabHeadLabelPadding,
      child: BlocBuilder(
          bloc: tpCtrl,
          builder: (BuildContext context, FUITabPaneEvent? event) {
            if (event != null) {
              isSelected = (event.selectedTabItemKey == widget.key!);

              if (isSelected && widget.onTabSelected != null) {
                widget.onTabSelected!();
              }
            }

            return _buildIconTextWidget();
          }),
    );

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          tpCtrl.trigger(
            FUITabPaneEvent(
              selectedTabItemKey: widget.key!,
            ),
          );
        },
        child: Container(
          padding: FUITabTheme.tabHeadPadding,
          child: IntrinsicWidth(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                tabLabelContainer,
                _FUITabHeadDecoBar(
                  fuiTabPaneController: tpCtrl,
                  tabItemKey: widget.key!,
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

  Widget _buildIconTextWidget() {
    late Widget iconTextWidget;

    SizedBox hSpace = widget.tabHeadIconTextHSpace != null ? SizedBox(width: widget.tabHeadIconTextHSpace!) : FUITabTheme.tabHeadIconTextHSpace;
    SizedBox vSpace = widget.tabHeadIconTextVSpace != null ? SizedBox(height: widget.tabHeadIconTextVSpace!) : FUITabTheme.tabHeadIconTextVSpace;

    TextStyle ts = isSelected ? fuiTabTheme.tsTabHeadLabelActive : fuiTabTheme.tsTabHeadLabel;
    List<Widget> wList = [];

    Widget label = DefaultTextStyle(
      style: ts,
      child: widget.tabHeadLabel,
    );

    Widget? icon;

    if (widget.tabHeadIcon != null) {
      icon = IconTheme.merge(
        data: IconThemeData(size: FUITabTheme.tabHeadIconSize, color: ts.color),
        child: widget.tabHeadIcon!,
      );
    }

    switch (widget.fuiTabHeadSideIconPosition) {
      case FUITabHeadTextIconPosition.iconRightTextLeft:
        wList.add(label);

        if (icon != null) {
          wList.add(hSpace);
          wList.add(icon);
        }

        iconTextWidget = Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: wList,
        );
        break;
      case FUITabHeadTextIconPosition.iconTopTextBottom:
        if (icon != null) {
          wList.add(icon);
          wList.add(vSpace);
        }

        wList.add(label);

        iconTextWidget = Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: wList,
        );
        break;
      case FUITabHeadTextIconPosition.iconBottomTextTop:
        wList.add(label);

        if (icon != null) {
          wList.add(vSpace);
          wList.add(icon);
        }

        iconTextWidget = Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: wList,
        );
        break;
      case FUITabHeadTextIconPosition.iconLeftTextRight:
      default:
        if (icon != null) {
          wList.add(icon);
          wList.add(hSpace);
        }

        wList.add(label);

        iconTextWidget = Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: wList,
        );
        break;
    }

    return iconTextWidget;
  }
}

class _FUITabHeadDecoBar extends StatefulWidget {
  final FUITabPaneController fuiTabPaneController;
  final Key tabItemKey;
  final Color decoBarActiveColor;
  final double decoBarHeight;
  final BorderRadius decoBarBorderRadius;
  final Duration decoBarAniDuration;
  final Curve decoBarAniCurve;
  final bool isActivated;

  _FUITabHeadDecoBar({
    Key? key,
    required this.fuiTabPaneController,
    required this.tabItemKey,
    required this.decoBarActiveColor,
    this.decoBarHeight = FUITabTheme.decoBarHeight,
    this.decoBarBorderRadius = FUITabTheme.decoBarBorderRadius,
    this.decoBarAniDuration = FUITabTheme.decoBarAniDuration,
    this.decoBarAniCurve = FUITabTheme.decoBarAniCurve,
    required this.isActivated,
  }) : super(key: key ?? UniqueKey());

  @override
  State<_FUITabHeadDecoBar> createState() => _FUITabHeadDecoBarState();
}

class _FUITabHeadDecoBarState extends State<_FUITabHeadDecoBar> with SingleTickerProviderStateMixin {
  /// Theme
  late FUIThemeCommonColors fuiColors;
  late FUITabTheme tabTheme;

  /// Bloc
  late FUITabPaneController tpCtrl;

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
    tpCtrl = widget.fuiTabPaneController;

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
      begin: FUITabTheme.decoBarAniLowerBound,
      end: FUITabTheme.decoBarAniUpperBound,
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
      create: (_) => tpCtrl,
      child: BlocBuilder(
        bloc: tpCtrl,
        builder: (BuildContext context, FUITabPaneEvent? event) {
          bool activate = isActivated;

          if (event != null) {
            activate = (event.selectedTabItemKey.hashCode == widget.tabItemKey.hashCode);
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
                    children: [
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
                      Expanded(
                        flex: (FUITabTheme.decoBarAniUpperBound - decoBarValueTween.evaluate(decoBarAni)).toInt(),
                        child: Container(
                          margin: EdgeInsets.zero,
                          padding: EdgeInsets.zero,
                          height: widget.decoBarHeight,
                          color: Colors.transparent,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          );
        },
      ),
    );
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
