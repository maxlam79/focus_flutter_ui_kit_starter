import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../exports.dart';

class FUIPanel extends StatefulWidget {
  final FUIColorScheme fuiColorScheme;
  final FUIPanelController? fuiPanelController;
  final double? width;
  final double? height;
  final Widget content;
  final EdgeInsets? contentPadding;
  final BoxConstraints? constraints;
  final Color? panelBackgroundColor;
  final double? panelBorderThickness;
  final Color? panelBorderColor;
  final BorderRadius? panelBoxBorderRadius;

  /// Header options
  final bool headerShow;
  final Widget? header;
  final EdgeInsets? headerPadding;
  final List<Widget>? headerIconButtons;
  final bool headerSeparator;
  final double? headerSeparatorThickness;
  final Color? headerSeparatorColor;

  /// Footer options
  final bool footerShow;
  final List<Widget>? footerButtons; // Either footerButtons or footerWidget
  final Widget? footer; // This will override the entire footer section.
  final EdgeInsets? footerPadding;
  final bool footerSeparator;
  final double? footerSeparatorThickness;
  final Color? footerSeparatorColor;

  /// Enable/Disable opacity effects
  final double? opacityDuringDisabled;
  final Duration? opacityAniDuration;

  final bool paceBarEnable; // Progress bar on top for loading/waiting and other async stuff if needed.
  final bool paceBarRepeating;
  final FUIPanePaceBarPosition paceBarPosition;
  final Color? paceBarColor;
  final double paceBarCurrentValue;
  final double paceBarMaxValue;
  final Curve? paceBarAniCurve;
  final Duration? paceBarAniDuration;

  /// Center loading/waiting spinner options
  final bool spinnerEnable;
  final Alignment spinnerPosition;
  final Widget? spinnerWidget; // Can be anything from icon to svg widget.
  final bool spinnerRotationEnable;
  final Duration? spinnerRotationAniDuration;
  final Curve? spinnerRotationAniCurve;

  /// Content scroll bar
  final bool contentScrollBarEnable;
  final Color? contentScrollBarColor;
  final Axis contentScrollBarScrollDirection;

  /// Mouse over elevated shadow options
  final bool mouseOverElevateShadowEnable;
  final List<BoxShadow>? mouseOverBoxShadowList;

  FUIPanel({
    Key? key,
    this.fuiColorScheme = FUIColorScheme.primary,
    this.fuiPanelController,
    this.width,
    this.height,
    required this.content,
    this.contentPadding,
    this.constraints,
    this.panelBackgroundColor,
    this.panelBorderThickness,
    this.panelBorderColor,
    this.panelBoxBorderRadius,
    this.headerShow = true,
    this.header,
    this.headerPadding,
    this.headerIconButtons,
    this.headerSeparator = false,
    this.headerSeparatorThickness,
    this.headerSeparatorColor,
    this.footerShow = false,
    this.footerButtons,
    this.footer,
    this.footerPadding,
    this.footerSeparator = false,
    this.footerSeparatorThickness,
    this.footerSeparatorColor,
    this.mouseOverElevateShadowEnable = false,
    this.mouseOverBoxShadowList,
    this.opacityDuringDisabled,
    this.opacityAniDuration,
    this.paceBarEnable = true,
    this.paceBarRepeating = true,
    this.paceBarPosition = FUIPanePaceBarPosition.top,
    this.paceBarColor,
    this.paceBarCurrentValue = FUIPaceBarTheme.paceBarAniLowerBound,
    this.paceBarMaxValue = FUIPaceBarTheme.paceBarAniUpperBound,
    this.paceBarAniCurve,
    this.paceBarAniDuration,
    this.spinnerEnable = true,
    this.spinnerPosition = Alignment.center,
    this.spinnerWidget,
    this.spinnerRotationEnable = true,
    this.spinnerRotationAniDuration,
    this.spinnerRotationAniCurve,
    this.contentScrollBarEnable = true,
    this.contentScrollBarColor,
    this.contentScrollBarScrollDirection = Axis.vertical,
  }) : super(key: key ?? UniqueKey());

  @override
  State<FUIPanel> createState() => _FUIPanelState();
}

class _FUIPanelState extends State<FUIPanel> {
  /// Themes
  late FUIPanelTheme fuiPanelTheme;

  /// Bloc
  late FUIThemeCommonColors fuiColors;
  late FUIPanelController panelCtrl;
  late FUIPaneController paneCtrl;
  late _FUIPanelMouseController mouseCtrl;
  bool blocProviderCreateNew = false;

  /// Attributes and Flags
  List<BoxShadow>? boxShadowList;
  double currentPanelBorderThickness = 0;
  bool boxShadowFlag = false;
  bool mouseOverFlag = false;

  @override
  void initState() {
    super.initState();

    _initBloc();
  }

  _initBloc() {
    if (widget.fuiPanelController == null) {
      blocProviderCreateNew = true;
    }

    panelCtrl = widget.fuiPanelController ?? FUIPanelController(event: FUIPanelControlEvent());

    paneCtrl = FUIPaneController();
    mouseCtrl = _FUIPanelMouseController();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    fuiColors = context.theme.fuiColors;
    fuiPanelTheme = context.theme.fuiPanel;

    _initBoxShadow();
    _discernPanelBorderThickness();

    var w = _buildPane();

    return MultiBlocProvider(
      providers: [
        _generateBlocProviderPanelCtrl(),
        BlocProvider(create: (_) => mouseCtrl),
      ],
      child: BlocBuilder(
          bloc: mouseCtrl,
          builder: (BuildContext context, bool? mouseEnter) {
            if (mouseEnter != null) {
              _toggleMouseOver(mouseEnter);
            }

            return MouseRegion(
              onEnter: widget.mouseOverElevateShadowEnable ? (event) => mouseCtrl.trigger(true) : null,
              onExit: widget.mouseOverElevateShadowEnable ? (event) => mouseCtrl.trigger(false) : null,
              child: BlocBuilder(
                bloc: panelCtrl,
                builder: (BuildContext context, FUIPanelControlEvent? event) {
                  if (event != null) {
                    if (event.enable != null || event.blur != null || event.spinnerShow != null || event.paceBarShow != null || event.paceBarValue != null) {
                      paneCtrl.trigger(FUIPaneControlEvent(
                        enable: event.enable,
                        blur: event.blur,
                        spinnerShow: event.spinnerShow,
                        paceBarShow: event.paceBarShow,
                        paceBarValue: event.paceBarValue,
                      ));
                    }
                  }

                  return Container(
                    width: widget.width,
                    height: widget.height,
                    constraints: widget.constraints ??
                        BoxConstraints(
                          minWidth: widget.width ?? FUIPanelTheme.defaultWidth,
                          minHeight: widget.height ?? FUIPanelTheme.defaultHeight,
                          maxWidth: widget.width ?? FUIPanelTheme.defaultWidth,
                          maxHeight: widget.height ?? FUIPanelTheme.defaultHeight,
                        ),
                    padding: EdgeInsets.zero,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: widget.panelBackgroundColor ?? fuiColors.shade0,
                      boxShadow: boxShadowFlag ? boxShadowList : [],
                      border: Border.all(
                        width: currentPanelBorderThickness,
                        color: widget.panelBorderColor ?? fuiColors.shade2,
                      ),
                      borderRadius: widget.panelBoxBorderRadius ?? FUIPanelTheme.boxBorderRadius,
                    ),
                    child: w,
                  );
                },
              ),
            );
          }),
    );
  }

  _generateBlocProviderPanelCtrl() {
    if (blocProviderCreateNew) {
      return BlocProvider(create: (_) => panelCtrl);
    } else {
      return BlocProvider.value(value: panelCtrl);
    }
  }

  _initBoxShadow() {
    if (widget.mouseOverElevateShadowEnable) {
      if (widget.mouseOverBoxShadowList != null && widget.mouseOverBoxShadowList!.isNotEmpty) {
        boxShadowList = widget.mouseOverBoxShadowList!;
      } else {
        if (boxShadowList == null || boxShadowList!.isEmpty) {
          boxShadowList = [
            BoxShadow(
                color: fuiPanelTheme.mouseOverShadowColor1,
                spreadRadius: FUIPanelTheme.mouseOverShadowSpreadRadius1,
                blurRadius: FUIPanelTheme.mouseOverShadowElevate,
                offset: const Offset(FUIPanelTheme.mouseOverShadowOffset, FUIPanelTheme.mouseOverShadowOffset)),
            BoxShadow(
                color: fuiPanelTheme.mouseOverShadowColor2,
                spreadRadius: FUIPanelTheme.mouseOverShadowSpreadRadius1,
                blurRadius: FUIPanelTheme.mouseOverShadowElevate / 2,
                offset: const Offset(FUIPanelTheme.mouseOverShadowOffset, FUIPanelTheme.mouseOverShadowOffset)),
            BoxShadow(
                color: fuiPanelTheme.mouseOverShadowColor3,
                spreadRadius: FUIPanelTheme.mouseOverShadowSpreadRadius2,
                blurRadius: FUIPanelTheme.mouseOverShadowElevate,
                offset: const Offset(-FUIPanelTheme.mouseOverShadowOffset, -FUIPanelTheme.mouseOverShadowOffset)),
            BoxShadow(
                color: fuiPanelTheme.mouseOverShadowColor4,
                spreadRadius: FUIPanelTheme.mouseOverShadowSpreadRadius2,
                blurRadius: FUIPanelTheme.mouseOverShadowElevate / 2,
                offset: const Offset(-FUIPanelTheme.mouseOverShadowOffset, -FUIPanelTheme.mouseOverShadowOffset)),
          ];
        }
      }
    }
  }

  FUIPane _buildPane() {
    List<Widget> contentList = [];

    /// Header
    if (widget.headerShow) {
      contentList.add(_buildHeader());

      if (widget.headerSeparator) {
        contentList.add(
          Divider(
            color: widget.headerSeparatorColor ?? fuiColors.shade2,
            thickness: widget.headerSeparatorThickness ?? FUIPanelTheme.headerSeparatorThickness,
          ),
        );
      }
    }

    /// Main Content
    if (widget.contentScrollBarEnable) {
      contentList.add(
        Expanded(
          child: FUISingleChildScrollView(
            fuiColorScheme: widget.fuiColorScheme,
            scrollbarColor: widget.contentScrollBarColor,
            scrollDirection: widget.contentScrollBarScrollDirection,
            child: Container(
              alignment: Alignment.topLeft,
              padding: widget.contentPadding ?? FUIPanelTheme.panelContentPadding,
              child: widget.content,
            ),
          ),
        ),
      );
    } else {
      contentList.add(
        Expanded(
          child: Container(
            alignment: Alignment.topLeft,
            padding: widget.contentPadding ?? FUIPanelTheme.panelContentPadding,
            child: widget.content,
          ),
        ),
      );
    }

    /// Footer
    if (widget.footerShow) {
      if (widget.footerSeparator) {
        contentList.add(
          Divider(
            color: widget.footerSeparatorColor ?? fuiColors.shade2,
            thickness: widget.footerSeparatorThickness ?? FUIPanelTheme.footerSeparatorThickness,
          ),
        );
      }

      contentList.add(_buildFooter());
    }

    return FUIPane(
      paneController: paneCtrl,
      fuiColorScheme: widget.fuiColorScheme,
      padding: EdgeInsets.zero,
      opacityDuringDisabled: widget.opacityDuringDisabled,
      opacityAniDuration: widget.opacityAniDuration,
      paceBarEnable: widget.paceBarEnable,
      paceBarRepeating: widget.paceBarRepeating,
      paceBarPosition: widget.paceBarPosition,
      paceBarColor: widget.paceBarColor,
      paceBarCurrentValue: widget.paceBarCurrentValue,
      paceBarMaxValue: widget.paceBarMaxValue,
      paceBarAniCurve: widget.paceBarAniCurve,
      paceBarAniDuration: widget.paceBarAniDuration,
      spinnerEnable: widget.spinnerEnable,
      spinnerPosition: widget.spinnerPosition,
      spinnerWidget: widget.spinnerWidget,
      spinnerRotationEnable: widget.spinnerRotationEnable,
      spinnerRotationAniDuration: widget.spinnerRotationAniDuration,
      spinnerRotationAniCurve: widget.spinnerRotationAniCurve,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: contentList,
      ),
    );
  }

  Widget _buildHeader() {
    if (widget.headerShow) {
      Widget headingLeft;
      List<Widget> btnList = [];

      /// Header Title
      headingLeft = DefaultTextStyle(
        style: fuiPanelTheme.headingTitle,
        child: widget.header ?? const Text(''),
      );

      /// Header button icons
      if (widget.headerIconButtons != null && widget.headerIconButtons!.isNotEmpty) {
        for (int i = 0; i < widget.headerIconButtons!.length; i++) {
          btnList.add(
            Container(
              padding: FUIPanelTheme.panelHeaderIconPadding,
              child: widget.headerIconButtons![i],
            ),
          );
        }
      }

      if (btnList.isNotEmpty) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            /// Title
            Container(
              alignment: Alignment.centerLeft,
              padding: widget.headerPadding ?? FUIPanelTheme.headerPadding,
              child: headingLeft,
            ),

            /// Button Icons
            Container(
              alignment: Alignment.centerRight,
              padding: FUIPanelTheme.headerIconRowPadding,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: btnList,
              ),
            ),
          ],
        );
      } else {
        return Container(
          alignment: Alignment.centerLeft,
          padding: widget.headerPadding ?? FUIPanelTheme.headerPadding,
          child: headingLeft,
        );
      }
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget _buildFooter() {
    if (widget.footerButtons != null && widget.footerButtons!.isNotEmpty) {
      List<Widget> rowWList = [];

      for (int i = 0; i < widget.footerButtons!.length; i++) {
        if (i > 0) {
          rowWList.add(FUISpacer.hSpace20);
        }

        var btn = IconTheme.merge(
            data: const IconThemeData().copyWith(
              size: FUIPanelTheme.headerIconButtonSize,
              color: fuiPanelTheme.headerIconButtonColor,
            ),
            child: widget.footerButtons![i]);

        rowWList.add(btn);
      }

      return Container(
        padding: widget.footerPadding ?? FUIPanelTheme.footerPadding,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: rowWList,
        ),
      );
    } else if (widget.footer != null) {
      return Container(
        padding: widget.footerPadding ?? FUIPanelTheme.footerPadding,
        child: widget.footer,
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  double _discernPanelBorderThickness() {
    if (mouseOverFlag && widget.mouseOverElevateShadowEnable) {
      currentPanelBorderThickness = FUIPanelTheme.mouseOverBorderThickness;
    } else {
      currentPanelBorderThickness = (widget.panelBorderThickness != null) ? widget.panelBorderThickness! : FUIPanelTheme.borderThickness;
    }

    return currentPanelBorderThickness;
  }

  _toggleMouseOver(bool isMouseOver) {
    if (mouseOverFlag != isMouseOver) {
      mouseOverFlag = isMouseOver;

      if (mouseOverFlag && widget.mouseOverElevateShadowEnable) {
        boxShadowFlag = true;
        _discernPanelBorderThickness();
      } else if (!mouseOverFlag && widget.mouseOverElevateShadowEnable) {
        boxShadowFlag = false;
        _discernPanelBorderThickness();
      }
    }
  }
}

class _FUIPanelMouseController extends Cubit<bool?> {
  bool? mouseEnter;

  _FUIPanelMouseController({
    this.mouseEnter,
  }) : super(mouseEnter);

  trigger(bool mouseEnter) {
    this.mouseEnter = mouseEnter;
    emit(this.mouseEnter);
  }
}
