import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../exports.dart';

class FUIFileUploadItem extends StatefulWidget {
  final FUIColorScheme fuiColorScheme;
  final FUIFUItemController? fuiFUItemController;
  final Widget descLine1;
  final Widget? descLine2;
  final Widget? descLine3;
  final bool fileIconShow;
  final Widget? fileIcon;
  final double? width;
  final double? height;

  /// Left Deco Bar
  final bool leftDecoBarShow;
  final Color? leftDecoBarColor;
  final double? leftDecoBarWidth;
  final EdgeInsets? leftDecoBarPadding;

  /// Option Button
  final FUIPopupMenuIconButton? sidePopupMenuIconButton;
  final bool sidePopupMenuIconButtonShowOnHover;

  /// Enable/Disable opacity effects
  final double? opacityDuringDisabled;
  final Duration? opacityAniDuration;

  /// Pace Bar
  final bool paceBarEnable; // Progress bar on top for loading/waiting and other async stuff if needed.
  final bool paceBarRepeating;
  final FUIPanePaceBarPosition paceBarPosition;
  final Color? paceBarColor;
  final double paceBarCurrentValue;
  final double paceBarMaxValue;
  final Duration? paceBarAnimationDuration;

  /// Center loading/waiting spinner options
  final bool spinnerEnable;
  final Alignment spinnerPosition;
  final Widget? spinnerWidget; // Can be anything from icon to svg widget.
  final bool spinnerRotationEnable;
  final Duration? spinnerRotationDuration;
  final Curve? spinnerRotationAniCurve;

  FUIFileUploadItem({
    Key? key,
    this.fuiColorScheme = FUIColorScheme.primary,
    this.fuiFUItemController,
    required this.descLine1,
    this.descLine2,
    this.descLine3,
    this.fileIconShow = true,
    this.fileIcon,
    this.width,
    this.height,
    this.leftDecoBarShow = true,
    this.leftDecoBarColor,
    this.leftDecoBarWidth,
    this.leftDecoBarPadding,
    this.sidePopupMenuIconButton,
    this.sidePopupMenuIconButtonShowOnHover = true,
    this.opacityDuringDisabled,
    this.opacityAniDuration,
    this.paceBarEnable = true,
    this.paceBarRepeating = true,
    this.paceBarPosition = FUIPanePaceBarPosition.top,
    this.paceBarColor,
    this.paceBarCurrentValue = FUIPaceBarTheme.paceBarAniLowerBound,
    this.paceBarMaxValue = FUIPaceBarTheme.paceBarAniUpperBound,
    this.paceBarAnimationDuration,
    this.spinnerEnable = true,
    this.spinnerPosition = Alignment.center,
    this.spinnerWidget,
    this.spinnerRotationEnable = true,
    this.spinnerRotationDuration,
    this.spinnerRotationAniCurve,
  }) : super(key: key ?? UniqueKey());

  @override
  State<FUIFileUploadItem> createState() => _FUIFileUploadItemState();
}

class _FUIFileUploadItemState extends State<FUIFileUploadItem> with FUIColorMixin {
  /// Themes
  late FUIThemeCommonColors fuiColors;
  late FUIFileUploadTheme fuiFUTheme;

  /// Bloc
  late FUIFUItemController fuItemCtrl;
  late FUIPaneController paneCtrl;
  late _FUIFUItemMouseController mouseCtrl;
  bool blocProviderCreateNew = false;

  /// Flags and Attributes
  late Widget descLine1;
  Widget? descLine2;
  Widget? descLine3;
  bool showOptionBtn = false;

  @override
  void initState() {
    super.initState();

    _initFUItemCtrl();
    _initPaneCtrl();
  }

  _initFUItemCtrl() {
    if (widget.fuiFUItemController == null) {
      blocProviderCreateNew = true;
    }

    fuItemCtrl = widget.fuiFUItemController ?? FUIFUItemController();
  }

  _initPaneCtrl() {
    paneCtrl = FUIPaneController();
    mouseCtrl = _FUIFUItemMouseController();
  }

  @override
  void dispose() {
    paneCtrl.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    fuiColors = context.theme.fuiColors;
    fuiFUTheme = context.theme.fuiFileUpload;

    descLine1 = widget.descLine1;
    descLine2 = widget.descLine2;
    descLine3 = widget.descLine3;

    bf(BuildContext context, FUIFUItemEvent? event) {
      _discernEvent(event);

      List<Widget> wList = [];

      if (widget.leftDecoBarShow) {
        wList.add(_buildLeftDecoBar(context));
      }

      wList.add(_buildFileInfo());
      wList.add(_buildSideOptionBtn());

      return FUIPane(
        height: widget.height ?? FUIFileUploadTheme.itemHeight,
        width: widget.width,
        padding: EdgeInsets.zero,
        fuiColorScheme: widget.fuiColorScheme,
        paneController: paneCtrl,
        opacityDuringDisabled: widget.opacityDuringDisabled,
        opacityAniDuration: widget.opacityAniDuration,
        paceBarEnable: widget.paceBarEnable,
        paceBarRepeating: widget.paceBarRepeating,
        paceBarPosition: widget.paceBarPosition,
        paceBarColor: widget.paceBarColor,
        paceBarCurrentValue: widget.paceBarCurrentValue,
        paceBarMaxValue: widget.paceBarMaxValue,
        paceBarAniDuration: widget.paceBarAnimationDuration,
        spinnerEnable: widget.spinnerEnable,
        spinnerPosition: widget.spinnerPosition,
        spinnerWidget: widget.spinnerWidget,
        spinnerRotationEnable: widget.spinnerRotationEnable,
        spinnerRotationAniDuration: widget.spinnerRotationDuration,
        spinnerRotationAniCurve: widget.spinnerRotationAniCurve,
        child: MouseRegion(
          onEnter: (_) => mouseCtrl.trigger(true),
          onExit: (_) => mouseCtrl.trigger(false),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: wList,
          ),
        ),
      );
    }

    return MultiBlocProvider(
      providers: [
        _buildFUItemCtrlBlocProvider(),
        BlocProvider(create: (_) => mouseCtrl),
      ],
      child: BlocBuilder(
        bloc: fuItemCtrl,
        builder: bf,
      ),
    );
  }

  _buildLeftDecoBar(BuildContext context) {
    return Container(
      padding: widget.leftDecoBarPadding ?? FUIFileUploadTheme.itemLeftDecoBarPadding,
      margin: EdgeInsets.zero,
      child: Container(
        color: widget.leftDecoBarColor ?? discernColorByScheme(context, fuiColorScheme: widget.fuiColorScheme),
        width: widget.leftDecoBarWidth ?? FUIFileUploadTheme.itemLeftDecoBarWidth,
        height: double.infinity,
        child: const SizedBox.shrink(),
      ),
    );
  }

  _buildFileInfo() {
    List<Widget> nextLines = [];

    if (descLine2 != null) {
      nextLines.add(
        DefaultTextStyle(
          softWrap: false,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: fuiFUTheme.tsLine2,
          child: descLine2!,
        ),
      );
    }

    if (descLine3 != null) {
      nextLines.add(
        DefaultTextStyle(
          softWrap: false,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: fuiFUTheme.tsLine3,
          child: descLine3!,
        ),
      );
    }

    List<Widget> rowWList = [];

    if (widget.fileIconShow) {
      rowWList.add(
        IconTheme.merge(
          data: IconThemeData(
            color: fuiFUTheme.itemFileIconColor,
            size: FUIFileUploadTheme.itemFileIconSize,
          ),
          child: widget.fileIcon ??
              const Icon(
                FUIFileUploadTheme.itemFileIcon,
              ),
        ),
      );

      rowWList.add(FUISpacer.hSpace5);
    }

    rowWList.add(
      FUIColumn(
        children: nextLines,
      ),
    );

    return Expanded(
      child: FUIColumn(
        children: [
          DefaultTextStyle(
            softWrap: false,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: fuiFUTheme.tsLine1,
            child: descLine1,
          ),
          FUISpacer.vSpace5,
          FUIRow(
            children: rowWList,
          ),
        ],
      ),
    );
  }

  _buildSideOptionBtn() {
    if (widget.sidePopupMenuIconButton != null) {
      if (widget.sidePopupMenuIconButtonShowOnHover) {
        return BlocBuilder(
          bloc: mouseCtrl,
          builder: (BuildContext context, bool? mouseEnter) {
            if (mouseEnter != null) {
              showOptionBtn = mouseEnter;
            }

            return Container(
              height: double.infinity,
              alignment: Alignment.topRight,
              child: AnimatedOpacity(
                opacity: showOptionBtn ? 1 : 0,
                duration: const Duration(milliseconds: 300),
                child: widget.sidePopupMenuIconButton,
              ),
            );
          },
        );
      } else {
        return Container(
          height: double.infinity,
          alignment: Alignment.topRight,
          child: widget.sidePopupMenuIconButton,
        );
      }
    }

    return const SizedBox.shrink();
  }

  _buildFUItemCtrlBlocProvider() {
    if (blocProviderCreateNew) {
      return BlocProvider(
        create: (_) => fuItemCtrl,
      );
    } else {
      return BlocProvider.value(
        value: fuItemCtrl,
      );
    }
  }

  _discernEvent(FUIFUItemEvent? event) {
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

      if (event.descLine1 != null) {
        descLine1 = event.descLine1!;
      }

      if (event.descLine2 != null) {
        descLine2 = event.descLine2!;
      }

      if (event.descLine3 != null) {
        descLine3 = event.descLine3!;
      }
    }
  }
}

class _FUIFUItemMouseController extends Cubit<bool?> {
  bool? mouseEnter;

  _FUIFUItemMouseController({
    this.mouseEnter,
  }) : super(mouseEnter);

  trigger(bool mouseEnter) {
    this.mouseEnter = mouseEnter;
    emit(this.mouseEnter);
  }
}
