import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../exports.dart';

class FUIActionTile extends StatefulWidget {
  final FUIActionTileController? fuiActionTileController;
  final double? width;
  final double? height;
  final BoxConstraints? constraints;
  final BoxDecoration? decoration;
  final EdgeInsets? padding;
  final BoxFit imageBoxFit;
  final ImageProvider? nonHoverImageProvider;
  final ImageProvider? hoverImageProvider;
  final Duration hoverOpacityAniDuration;
  final Curve hoverOpacityAniCurve;
  final Widget child;
  final VoidCallback onPressed;

  FUIActionTile({
    Key? key,
    this.fuiActionTileController,
    this.width,
    this.height,
    this.constraints,
    this.decoration,
    this.padding,
    this.imageBoxFit = BoxFit.cover,
    this.nonHoverImageProvider,
    this.hoverImageProvider,
    this.hoverOpacityAniDuration = FUIActionTileTheme.opacityAniDuration,
    this.hoverOpacityAniCurve = Curves.linear,
    required this.child,
    required this.onPressed,
  }) : super(key: key ?? UniqueKey());

  @override
  State<FUIActionTile> createState() => _FUIActionTileState();
}

class _FUIActionTileState extends State<FUIActionTile> with SingleTickerProviderStateMixin {
  /// Theme
  late FUIThemeCommonColors fuiColors;

  /// Bloc
  late FUIActionTileController actionTileCtrl;
  bool blocProviderNewCreate = false;

  /// Animation
  late AnimationController hoverOpacityAniCtrl;
  late Tween<double> hoverOpacityValueTween;
  late Animation<double> hoverOpacityAni;

  @override
  void initState() {
    super.initState();

    _initBloc();
    _initAnimation();
  }

  _initBloc() {
    blocProviderNewCreate = widget.fuiActionTileController != null ? false : true;
    actionTileCtrl = widget.fuiActionTileController ?? FUIActionTileController(event: FUIActionTileEvent(hover: false));
  }

  _initAnimation() {
    hoverOpacityAniCtrl = AnimationController(
      duration: widget.hoverOpacityAniDuration,
      vsync: this,
      value: 0,
    );

    hoverOpacityAni = CurvedAnimation(
      parent: hoverOpacityAniCtrl,
      curve: widget.hoverOpacityAniCurve,
      reverseCurve: widget.hoverOpacityAniCurve,
    );

    hoverOpacityValueTween = Tween<double>(
      begin: 0.0,
      end: 1.0,
    );
  }

  @override
  void dispose() {
    hoverOpacityAniCtrl.dispose();

    if (blocProviderNewCreate) {
      actionTileCtrl.close();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    fuiColors = context.theme.fuiColors;

    BoxDecoration d = (widget.decoration != null)
        ? widget.decoration!
        : BoxDecoration(
            color: fuiColors.secondary,
          );

    Widget w = Container(
      width: widget.width,
      height: widget.height,
      constraints: widget.constraints,
      padding: widget.padding,
      decoration: d,
      child: MouseRegion(
        onEnter: (_) {
          actionTileCtrl.trigger(FUIActionTileEvent(hover: true));
        },
        onExit: (_) {
          actionTileCtrl.trigger(FUIActionTileEvent(hover: false));
        },
        child: GestureDetector(
          onTap: widget.onPressed,
          child: BlocBuilder(
            bloc: actionTileCtrl,
            builder: (BuildContext context, FUIActionTileEvent event) {
              if (event.hover) {
                hoverOpacityAniCtrl.forward();
              } else {
                hoverOpacityAniCtrl.reverse();
              }

              List<Widget> stackWList = [];

              if (widget.nonHoverImageProvider != null) {
                stackWList.add(_buildImageNonHover());
              }

              if (widget.hoverImageProvider != null) {
                stackWList.add(_buildImageHover());
              }

              stackWList.add(widget.child);

              return Stack(
                fit: StackFit.expand,
                children: stackWList,
              );
            },
          ),
        ),
      ),
    );

    if (blocProviderNewCreate) {
      return BlocProvider(
        create: (_) => actionTileCtrl,
        child: w,
      );
    } else {
      return BlocProvider.value(
        value: actionTileCtrl,
        child: w,
      );
    }
  }

  _buildImageNonHover() {
    return Image(
      image: widget.nonHoverImageProvider!,
      fit: widget.imageBoxFit,
    );
  }

  _buildImageHover() {
    return Image(
      image: widget.hoverImageProvider!,
      fit: widget.imageBoxFit,
      opacity: hoverOpacityValueTween.animate(hoverOpacityAni),
    );
  }
}
