import 'package:align_positioned/align_positioned.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modals/modals.dart';

import '../../exports.dart';

class FUIModal extends StatefulWidget {
  /// General modal option
  final FUIColorScheme fuiColorScheme;
  final FUIModalController? fuiModalController;
  final Widget content;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final double? borderThickness;
  final Color? borderColor;
  final BorderRadius? boxBorderRadius;
  final FUIAnimationType animationType;
  final Duration animationDuration;
  final VoidCallback? onModalDisplayedAfterAnimation;
  final VoidCallback? onModalDismissedAfterAnimation;
  final bool animationOnClose;

  /// Header options
  final bool headerShow;
  final Color? headerBackgroundColor;
  final Widget? header;
  final Widget? headerModalCloseIcon;
  final bool headerSeparator;
  final double? headerSeparatorThickness;
  final Color? headerSeparatorColor;

  /// Footer options
  final List<Widget>? footerButtons; // Either footerButtons or footer
  final bool footerShow;
  final Widget? footer; // Either footerButtons or footer
  final EdgeInsets? footerPadding;
  final bool footerSeparator;
  final double? footerSeparatorThickness;
  final Color? footerSeparatorColor;

  /// Enable/Disable opacity effects
  final double? opacityDuringDisabled;
  final Duration? opacityAniDuration;

  final bool paceBarEnable; // Progress bar on top for loading/waiting and other async stuff if needed.
  final bool paceBarRepeating;
  final FUIModalPaceBarPosition paceBarPosition;
  final Color? paceBarColor;
  final double paceBarCurrentValue;
  final double paceBarMaxValue;
  final Duration? paceBarAnimationDuration;

  /// Center loading/waiting spinner options
  final bool spinnerEnable;
  final Alignment spinnerPosition;
  final Widget? spinnerWidget; // Can be anything from icon to svg widget.
  final bool spinnerRotationEnable;
  final Duration? spinnerRotationAniDuration;
  final Curve? spinnerRotationAniCurve;

  /// Constructor
  FUIModal({
    Key? key,
    this.fuiColorScheme = FUIColorScheme.primary,
    this.fuiModalController,
    required this.content,
    this.width,
    this.height,
    this.backgroundColor,
    this.borderThickness,
    this.borderColor,
    this.boxBorderRadius,
    this.animationType = FUIAnimationType.fadeInDown,
    this.animationDuration = FUIModalTheme.displayAnimationDuration,
    this.onModalDisplayedAfterAnimation,
    this.onModalDismissedAfterAnimation, // Only works when animationOnClose = true.
    this.animationOnClose = true,
    this.headerBackgroundColor,
    this.headerShow = true,
    this.header,
    this.headerModalCloseIcon,
    this.headerSeparator = false,
    this.headerSeparatorThickness,
    this.headerSeparatorColor,
    this.footerShow = true,
    this.footerButtons,
    this.footer,
    this.footerPadding,
    this.footerSeparator = false,
    this.footerSeparatorThickness,
    this.footerSeparatorColor,
    this.opacityDuringDisabled,
    this.opacityAniDuration,
    this.paceBarEnable = true,
    this.paceBarRepeating = true,
    this.paceBarPosition = FUIModalPaceBarPosition.top,
    this.paceBarColor,
    this.paceBarCurrentValue = FUIPaceBarTheme.paceBarAniLowerBound,
    this.paceBarMaxValue = FUIPaceBarTheme.paceBarAniUpperBound,
    this.paceBarAnimationDuration,
    this.spinnerEnable = true,
    this.spinnerPosition = Alignment.center,
    this.spinnerWidget,
    this.spinnerRotationEnable = true,
    this.spinnerRotationAniDuration,
    this.spinnerRotationAniCurve,
  }) : super(key: key ?? UniqueKey());

  @override
  State<FUIModal> createState() => _FUIModalState();
}

class _FUIModalState extends State<FUIModal> {
  /// Theme
  late FUIThemeCommonColors fuiColors;
  late FUIModalTheme fuiModalTheme;

  /// Animation
  GlobalKey<AnimatorWidgetState> aniGKey = GlobalKey<AnimatorWidgetState>();

  /// Bloc
  late FUIModalController modalCtrl;
  bool blocProviderCreateNew = false;

  /// Other Controllers
  late FUIPaceBarController paceBarCtrl;
  late FUISpinnerController spinnerCtrl;

  @override
  void initState() {
    super.initState();

    _initBloc();
  }

  _initBloc() {
    if (widget.fuiModalController == null) {
      blocProviderCreateNew = true;
    }

    modalCtrl = widget.fuiModalController ?? FUIModalController();
    paceBarCtrl = FUIPaceBarController();
    spinnerCtrl = FUISpinnerController(spinnerShow: false);
  }

  @override
  void dispose() {
    if (aniGKey.currentState != null) {
      aniGKey.currentState!.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    fuiColors = context.theme.fuiColors;
    fuiModalTheme = context.theme.fuiModal;

    List<Widget> stackList = [];

    AnimationPreferences ap = AnimationPreferences(
      duration: widget.animationDuration,
      animationStatusListener: (status) {
        switch (status) {
          case AnimationStatus.dismissed:
            if (widget.onModalDismissedAfterAnimation != null) {
              widget.onModalDismissedAfterAnimation!();
            }
            break;
          case AnimationStatus.completed:
            if (widget.onModalDisplayedAfterAnimation != null) {
              widget.onModalDisplayedAfterAnimation!();
            }
            break;
          default:
            break;
        }
      },
    );

    stackList.add(
      _FUIModalOpacityLayer(
        fuiColorScheme: widget.fuiColorScheme,
        aniGKey: aniGKey,
        fuiModalController: modalCtrl,
        animationOnClose: widget.animationOnClose,
        content: widget.content,
        headerShow: widget.headerShow,
        header: widget.header,
        headerBackgroundColor: widget.headerBackgroundColor,
        headerModalCloseIcon: widget.headerModalCloseIcon,
        headerSeparator: widget.headerSeparator,
        headerSeparatorThickness: widget.headerSeparatorThickness,
        headerSeparatorColor: widget.headerSeparatorColor,
        footerShow: widget.footerShow,
        footerButtons: widget.footerButtons,
        footer: widget.footer,
        footerPadding: widget.footerPadding,
        footerSeparator: widget.footerSeparator,
        footerSeparatorThickness: widget.footerSeparatorThickness,
        footerSeparatorColor: widget.footerSeparatorColor,
      ),
    );

    if (widget.paceBarEnable) {
      stackList.add(
        FUIPaceBar(
          fuiColorScheme: widget.fuiColorScheme,
          paceBarController: paceBarCtrl,
          enable: widget.paceBarEnable,
          barRepeating: widget.paceBarRepeating,
          barColor: widget.paceBarColor,
          barCurrentValue: widget.paceBarCurrentValue,
          barMaxValue: widget.paceBarMaxValue,
          barAniDuration: widget.paceBarAnimationDuration,
        ),
      );
    }

    if (widget.spinnerEnable) {
      stackList.add(
        Positioned.fill(
          child: AlignPositioned(
            alignment: widget.spinnerPosition,
            child: FUISpinner(
              fuiSpinnerController: spinnerCtrl,
              spinnerWidget: widget.spinnerWidget,
              rotationEnable: widget.spinnerRotationEnable,
              rotationAniDuration: widget.spinnerRotationAniDuration,
              rotationAniCurve: widget.spinnerRotationAniCurve,
            ),
          ),
        ),
      );
    }

    double? width = _discernWidth();

    bf(BuildContext context, FUIModalControlEvent? event) {
      if (event != null) {
        _discernEvent(event);
      }

      return Container(
        color: Colors.transparent,
        child: FUIAnimationHelper.discernAnimator(
          key: aniGKey,
          fuiAnimationType: widget.animationType,
          preferences: ap,
          child: IntrinsicHeight(
            child: Container(
              padding: EdgeInsets.zero,
              width: width,
              height: widget.height,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: widget.backgroundColor ?? fuiColors.shade0,
                // boxShadow: boxShadowFlag ? boxShadowList : [],
                border: Border.all(
                  width: widget.borderThickness ?? FUIModalTheme.borderThickness,
                  color: widget.borderColor ?? fuiColors.shade1,
                ),
                borderRadius: widget.boxBorderRadius ?? FUIModalTheme.boxBorderRadius,
              ),
              child: Stack(
                children: stackList,
              ),
            ),
          ),
        ),
      );
    }

    if (blocProviderCreateNew) {
      return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => modalCtrl),
          BlocProvider.value(value: paceBarCtrl),
          BlocProvider.value(value: spinnerCtrl),
        ],
        child: BlocBuilder(
          bloc: modalCtrl,
          builder: bf,
        ),
      );
    } else {
      return MultiBlocProvider(
        providers: [
          BlocProvider.value(value: modalCtrl),
          BlocProvider.value(value: paceBarCtrl),
          BlocProvider.value(value: spinnerCtrl),
        ],
        child: BlocBuilder(
          bloc: modalCtrl,
          builder: bf,
        ),
      );
    }
  }

  double _discernWidth() {
    if (widget.width != null) {
      return widget.width!;
    } else {
      double width = MediaQuery.of(context).size.width;

      if (width <= FUIScreenSize.mobile) {
        return width * 0.8; // 80%
      } else if (width <= FUIScreenSize.tablet) {
        return width * 0.7; // 70%
      } else if (width <= FUIScreenSize.desktopFullHd) {
        return width * 0.6; // 60%
      } else if (width <= FUIScreenSize.desktop4k) {
        return width * 0.4; // 40%
      } else {
        return width * 0.3; // 30%...too big.
      }
    }
  }

  _discernEvent(FUIModalControlEvent event) {
    if (event.close != null && event.close!) {
      if (aniGKey.currentState != null) {
        if (widget.animationOnClose) {
          aniGKey.currentState!.animator!.controller!.reverse().then((value) => removeAllModals());
        } else {
          removeAllModals();
        }
      } else {
        removeAllModals();
      }

      // Need to forcefully reset the event after closing...
      modalCtrl.trigger(FUIModalControlEvent());
    } else {
      if (event.paceBarShow != null || event.paceBarValue != null) {
        paceBarCtrl.trigger(
          FUIPaceBarControlEvent(
            barShow: event.paceBarShow,
            barValue: event.paceBarValue,
          ),
        );
      }

      if (event.spinnerShow != null) {
        spinnerCtrl.show(event.spinnerShow!);
      }
    }
  }
}

class _FUIModalOpacityLayer extends StatefulWidget {
  /// General panel option
  final FUIColorScheme fuiColorScheme;
  final FUIModalController fuiModalController;
  final GlobalKey<AnimatorWidgetState>? aniGKey;
  final bool animationOnClose;
  final Widget content;

  /// Header options
  final bool headerShow;
  final Widget? header;
  final Color? headerBackgroundColor;
  final Widget? headerModalCloseIcon;
  final bool headerSeparator;
  final double? headerSeparatorThickness;
  final Color? headerSeparatorColor;

  /// Footer options
  final bool footerShow;
  final List<Widget>? footerButtons;
  final Widget? footer;
  final EdgeInsets? footerPadding;
  final bool footerSeparator;
  final double? footerSeparatorThickness;
  final Color? footerSeparatorColor;

  const _FUIModalOpacityLayer({
    this.fuiColorScheme = FUIColorScheme.primary,
    required this.fuiModalController,
    this.aniGKey,
    this.animationOnClose = true,
    required this.content,
    this.headerShow = true,
    this.header,
    this.headerBackgroundColor,
    this.headerModalCloseIcon,
    this.headerSeparator = false,
    this.headerSeparatorThickness,
    this.headerSeparatorColor,
    this.footerShow = true,
    this.footerButtons,
    this.footer,
    this.footerPadding,
    this.footerSeparator = true,
    this.footerSeparatorThickness,
    this.footerSeparatorColor,
  });

  @override
  State<_FUIModalOpacityLayer> createState() => _FUIModalOpacityLayerState();
}

class _FUIModalOpacityLayerState extends State<_FUIModalOpacityLayer> {
  /// Themes
  late FUIThemeCommonColors fuiColors;
  late FUIModalTheme fuiModalTheme;

  /// Other variables and flags
  bool modalEnable = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    fuiColors = context.theme.fuiColors;
    fuiModalTheme = context.theme.fuiModal;

    List<Widget> contentList = [];

    /// Header
    if (widget.headerShow) {
      contentList.add(_buildHeader());

      if (widget.headerSeparator) {
        contentList.add(
          Divider(
            color: widget.headerSeparatorColor ?? fuiColors.shade2,
            thickness: widget.headerSeparatorThickness ?? FUIModalTheme.headerSeparatorThickness,
          ),
        );
      }
    }

    /// Main Content
    contentList.add(
      SingleChildScrollView(
        child: Container(
          alignment: Alignment.topLeft,
          padding: FUIModalTheme.contentPadding,
          child: widget.content,
        ),
      ),
    );

    /// Footer
    if (widget.footerShow) {
      if (widget.footerSeparator) {
        contentList.add(
          Divider(
            color: widget.footerSeparatorColor ?? fuiColors.shade2,
            thickness: widget.footerSeparatorThickness ?? FUIModalTheme.footerSeparatorThickness,
          ),
        );
      }

      contentList.add(_buildFooter());
    }

    return BlocBuilder(
      bloc: widget.fuiModalController,
      builder: (BuildContext context, FUIModalControlEvent? event) {
        if (event != null) {
          if (event.enable != null) {
            modalEnable = event.enable!;
          }
        }

        return AbsorbPointer(
          absorbing: !modalEnable,
          child: AnimatedOpacity(
            duration: FUIModalTheme.opacityAniCtrlDuration,
            opacity: modalEnable ? FUIModalTheme.opacityNormal : FUIModalTheme.opacityFade,
            child: Column(
              children: contentList,
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader() {
    Widget headingLeft;
    List<Widget> btnList = [];

    /// Header Title
    headingLeft = DefaultTextStyle(
      style: fuiModalTheme.headingTitle,
      child: widget.header ?? const SizedBox.shrink(),
    );

    Widget closeIcon = IconTheme.merge(
      data: IconThemeData(
        color: fuiModalTheme.headerCloseIconColor,
      ),
      child: widget.headerModalCloseIcon ??
          const Icon(
            FUIModalTheme.headerCloseIcon,
          ),
    );

    /// Header close button
    btnList.add(
      Container(
        padding: FUIModalTheme.headerIconPadding,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () {
              _closeModal();
            },
            child: closeIcon,
          ),
        ),
      ),
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        /// Title
        Container(
          alignment: Alignment.centerLeft,
          padding: FUIModalTheme.headerPadding,
          child: headingLeft,
        ),

        /// Button Icons
        Container(
          alignment: Alignment.centerRight,
          padding: FUIModalTheme.headerPadding,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: btnList,
          ),
        ),
      ],
    );
  }

  Widget _buildFooter() {
    if (widget.footerButtons != null && widget.footerButtons!.isNotEmpty) {
      List<Widget> rowWList = [];

      for (int i = 0; i < widget.footerButtons!.length; i++) {
        if (i > 0) {
          rowWList.add(FUISpacer.hSpace20);
        }

        rowWList.add(widget.footerButtons![i]);
      }

      return Container(
        padding: widget.footerPadding ?? FUIModalTheme.footerPadding,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: rowWList,
        ),
      );
    } else if (widget.footer != null) {
      return Container(
        padding: widget.footerPadding ?? FUIModalTheme.footerPadding,
        child: widget.footer,
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  _closeModal() {
    if (widget.aniGKey != null && widget.aniGKey!.currentState != null) {
      if (widget.animationOnClose) {
        widget.aniGKey!.currentState!.animator!.controller!.reverse().then((value) => removeAllModals());
      } else {
        removeAllModals();
      }
    } else {
      removeAllModals();
    }
  }
}
