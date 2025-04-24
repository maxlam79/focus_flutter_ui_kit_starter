import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../exports.dart';

class FUIInputToggleSwitch extends StatefulWidget {
  final FUIInputFieldToggleController? fuiInputFieldToggleController;
  final bool initialValue;
  final ValueChanged<bool> onChanged;
  final FUIInputSize fuiInputSize;
  final FUIColorScheme fuiColorScheme;
  final bool showOnOff;
  final Widget? activeText;
  final Widget? inactiveText;
  final Color? activeColor;
  final Color? inactiveColor;
  final Color? toggleColor;
  final Color? activeToggleColor;
  final Color? inactiveToggleColor;
  final BoxBorder? switchBorder;
  final BoxBorder? activeSwitchBorder;
  final BoxBorder? inactiveSwitchBorder;
  final BoxBorder? toggleBorder;
  final BoxBorder? activeToggleBorder;
  final BoxBorder? inactiveToggleBorder;
  final Widget? activeIcon;
  final Widget? inactiveIcon;
  final Duration? toggleAniDuration;
  final Curve? toggleAniCurve;
  final bool readOnly;
  final bool enabled;
  final Duration? enableOpacityAniDuration;
  final Curve? enableOpacityAniCurve;

  FUIInputToggleSwitch({
    Key? key,
    this.fuiInputFieldToggleController,
    required this.initialValue,
    required this.onChanged,
    this.fuiInputSize = FUIInputSize.medium,
    this.fuiColorScheme = FUIColorScheme.primary,
    this.activeColor,
    this.inactiveColor,
    this.toggleColor,
    this.activeToggleColor,
    this.inactiveToggleColor,
    this.showOnOff = false,
    this.activeText,
    this.inactiveText,
    this.switchBorder,
    this.activeSwitchBorder,
    this.inactiveSwitchBorder,
    this.toggleBorder,
    this.activeToggleBorder,
    this.inactiveToggleBorder,
    this.activeIcon,
    this.inactiveIcon,
    this.toggleAniDuration,
    this.toggleAniCurve,
    this.readOnly = false,
    this.enabled = true,
    this.enableOpacityAniDuration,
    this.enableOpacityAniCurve,
  })  : assert(
            (switchBorder == null || activeSwitchBorder == null) && (switchBorder == null || inactiveSwitchBorder == null),
            'Cannot provide switchBorder when an activeSwitchBorder or inactiveSwitchBorder was given\n'
            'To give the switch a border, use "activeSwitchBorder: border" or "inactiveSwitchBorder: border".'),
        assert(
            (toggleBorder == null || activeToggleBorder == null) && (toggleBorder == null || inactiveToggleBorder == null),
            'Cannot provide toggleBorder when an activeToggleBorder or inactiveToggleBorder was given\n'
            'To give the toggle a border, use "activeToggleBorder: color" or "inactiveToggleBorder: color".'),
        super(key: key ?? UniqueKey());

  @override
  State<FUIInputToggleSwitch> createState() => _FUIInputToggleSwitchState();
}

class _FUIInputToggleSwitchState extends State<FUIInputToggleSwitch> with SingleTickerProviderStateMixin, FUIColorMixin {
  /// Bloc
  late FUIInputFieldToggleController iftCtrl;
  bool blocProviderCreateNew = false;

  /// Animation
  late final Animation _toggleAnimation;
  late final AnimationController _animationController;

  /// Flags and Attributes
  late Color activeColor;
  late Color inactiveColor;
  late Color toggleColor;
  late bool toggleValue;
  late Color _toggleColor;
  late Color _switchColor;
  Border? _switchBorder;
  Border? _toggleBorder;
  late bool isEnabled, isReadOnly;

  /// Styles
  late TextStyle tsInactiveTextStyle;
  late TextStyle tsActiveTextStyle;

  @override
  void initState() {
    super.initState();

    toggleValue = widget.initialValue;
    isEnabled = widget.enabled;
    isReadOnly = widget.readOnly;

    _initBloc();
    _initAnimation();
  }

  _initBloc() {
    if (widget.fuiInputFieldToggleController == null) {
      blocProviderCreateNew = true;
    }

    iftCtrl = widget.fuiInputFieldToggleController ?? FUIInputFieldToggleController();
  }

  _initAnimation() {
    _animationController = AnimationController(
      vsync: this,
      value: toggleValue ? 1.0 : 0.0,
      duration: widget.toggleAniDuration ?? FUIInputTheme.toggleAniDuration,
    );

    _toggleAnimation = AlignmentTween(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: widget.toggleAniCurve ?? FUIInputTheme.toggleAniCurve,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    FUIThemeCommonColors fuiColors = context.theme.fuiColors;
    activeColor = discernColorByScheme(context, fuiColorScheme: widget.fuiColorScheme, fallbackColor: fuiColors.primary);
    inactiveColor = fuiColors.shade3;
    toggleColor = discernForegroundColorByScheme(context, fuiColorScheme: widget.fuiColorScheme, fallbackColor: fuiColors.shade0);

    _toggleColor = toggleColor;
    _switchColor = fuiColors.shade0;

    _discernToggleColors();

    double textSpace = FUIInputTheme.sizeToggleWidth - FUIInputTheme.sizeToggle;

    _discernStyles(context);

    bf(BuildContext context, FUIInputFieldToggleEvent? event) {
      _handleBlocEvent(event);

      return AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return GestureDetector(
            onTap: () {
              if (isEnabled && !isReadOnly) {
                _handleToggleValueChange(!toggleValue);
              }
            },
            child: Transform.scale(
              scale: _discernSize(),
              child: AnimatedOpacity(
                duration: widget.toggleAniDuration ?? FUIInputTheme.toggleAniDuration,
                opacity: isEnabled ? FUIInputTheme.enableOpacityNormal : FUIInputTheme.enableOpacityDisabled,
                child: Container(
                  width: FUIInputTheme.sizeToggleWidth,
                  height: FUIInputTheme.sizeToggleHeight,
                  padding: const EdgeInsets.all(FUIInputTheme.sizeTogglePadding),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(FUIInputTheme.sizeToggleBorderRadius),
                    color: _switchColor,
                    border: _switchBorder,
                  ),
                  child: Stack(
                    children: <Widget>[
                      AnimatedOpacity(
                        opacity: toggleValue ? 1.0 : 0.0,
                        duration: widget.toggleAniDuration ?? FUIInputTheme.toggleAniDuration,
                        curve: widget.toggleAniCurve ?? FUIInputTheme.toggleAniCurve,
                        child: Container(
                          width: textSpace,
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          alignment: Alignment.centerLeft,
                          child: _activeText,
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: AnimatedOpacity(
                          opacity: !toggleValue ? 1.0 : 0.0,
                          duration: widget.toggleAniDuration ?? FUIInputTheme.toggleAniDuration,
                          curve: widget.toggleAniCurve ?? FUIInputTheme.toggleAniCurve,
                          child: Container(
                            width: textSpace,
                            padding: const EdgeInsets.symmetric(horizontal: 4.0),
                            alignment: Alignment.centerRight,
                            child: _inactiveText,
                          ),
                        ),
                      ),
                      Align(
                        alignment: _toggleAnimation.value,
                        child: Container(
                          width: FUIInputTheme.sizeToggle,
                          height: FUIInputTheme.sizeToggle,
                          padding: const EdgeInsets.all(4.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _toggleColor,
                            border: _toggleBorder,
                          ),
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: Stack(
                              children: [
                                Center(
                                  child: AnimatedOpacity(
                                    opacity: toggleValue ? 1.0 : 0.0,
                                    duration: widget.toggleAniDuration ?? FUIInputTheme.toggleAniDuration,
                                    curve: widget.toggleAniCurve ?? FUIInputTheme.toggleAniCurve,
                                    child: widget.activeIcon,
                                  ),
                                ),
                                Center(
                                  child: AnimatedOpacity(
                                    opacity: !toggleValue ? 1.0 : 0.0,
                                    duration: widget.toggleAniDuration ?? FUIInputTheme.toggleAniDuration,
                                    curve: widget.toggleAniCurve ?? FUIInputTheme.toggleAniCurve,
                                    child: widget.inactiveIcon,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
    }

    if (blocProviderCreateNew) {
      return BlocProvider(
        create: (_) => iftCtrl,
        child: BlocBuilder(
          bloc: iftCtrl,
          builder: bf,
        ),
      );
    } else {
      return BlocProvider.value(
        value: iftCtrl,
        child: BlocBuilder(
          bloc: iftCtrl,
          builder: bf,
        ),
      );
    }
  }

  Widget get _activeText {
    return DefaultTextStyle(
      style: tsActiveTextStyle,
      child: widget.showOnOff ? const Text('On') : (widget.activeText ?? const Text('')),
    );
  }

  Widget get _inactiveText {
    return DefaultTextStyle(
      style: tsInactiveTextStyle,
      child: widget.showOnOff ? const Text('Off', textAlign: TextAlign.right) : (widget.inactiveText ?? const Text('', textAlign: TextAlign.right)),
    );
  }

  _discernStyles(BuildContext context) {
    FUIInputTheme fuiInputTheme = context.theme.fuiInput;

    switch (widget.fuiInputSize) {
      case FUIInputSize.small:
        tsActiveTextStyle = fuiInputTheme.tsToggleSwitchActiveSmall;
        tsInactiveTextStyle = fuiInputTheme.tsToggleSwitchInactiveSmall;
        break;
      case FUIInputSize.large:
        tsActiveTextStyle = fuiInputTheme.tsToggleSwitchActiveLarge;
        tsInactiveTextStyle = fuiInputTheme.tsToggleSwitchInactiveLarge;
        break;
      case FUIInputSize.medium:
      default:
        tsActiveTextStyle = fuiInputTheme.tsToggleSwitchActiveMedium;
        tsInactiveTextStyle = fuiInputTheme.tsToggleSwitchInactiveMedium;
        break;
    }

    tsActiveTextStyle = tsActiveTextStyle.copyWith(color: discernForegroundColorByScheme(context, fuiColorScheme: widget.fuiColorScheme));
  }

  _discernToggleColors() {
    if (toggleValue) {
      _toggleColor = widget.activeToggleColor ?? toggleColor;
      _switchColor = widget.activeColor ?? activeColor;
      _switchBorder = widget.activeSwitchBorder as Border? ?? widget.switchBorder as Border?;
      _toggleBorder = widget.activeToggleBorder as Border? ?? widget.toggleBorder as Border?;
    } else {
      _toggleColor = widget.inactiveToggleColor ?? toggleColor;
      _switchColor = widget.inactiveColor ?? inactiveColor;
      _switchBorder = widget.inactiveSwitchBorder as Border? ?? widget.switchBorder as Border?;
      _toggleBorder = widget.inactiveToggleBorder as Border? ?? widget.toggleBorder as Border?;
    }
  }

  _handleBlocEvent(FUIInputFieldToggleEvent? event) {
    if (event != null) {
      if (event.enabled != null) {
        isEnabled = event.enabled!;
      }

      if (event.readOnly != null) {
        isReadOnly = event.readOnly!;
      }

      if (event.value != null) {
        _handleToggleValueChange(event.value!);
      }
    }
  }

  _handleToggleValueChange(bool newValue) {
    toggleValue = newValue;

    if (toggleValue) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }

    _discernToggleColors();

    widget.onChanged(toggleValue);
    }

  _discernSize() {
    switch (widget.fuiInputSize) {
      case FUIInputSize.small:
        return FUIInputTheme.sizeToggleSmallScale;
      case FUIInputSize.large:
        return FUIInputTheme.sizeToggleLargeScale;
      case FUIInputSize.medium:
      default:
        return FUIInputTheme.sizeToggleMediumScale;
    }
  }
}
