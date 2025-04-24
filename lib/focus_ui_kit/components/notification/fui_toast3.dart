import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:tuple/tuple.dart';

import '../../exports.dart';

class FUIToast3 with FUIToastMixin, FUIColorMixin {
  final BuildContext context;

  FUIToast3(this.context);

  show({
    required String title,
    required String description,
    FUIColorScheme? fuiColorScheme,
    FUIToastPosition? fuiToastPosition = FUIToastPosition.topRight,
    FUIToastDecoBarPosition? fuiToastDecoBarPosition = FUIToastDecoBarPosition.left,
    IconData? sideIcon,
    Widget? sideWidget,
    FUIToastIconPosition? sideWidgetPosition = FUIToastIconPosition.left,
    Duration? duration,
    Duration? animationDuration,
    double? radius,
    VoidCallback? onTap,
    VoidCallback? onDismiss,
  }) {
    FUIToastTheme fuiToastTheme = context.theme.fuiToast;
    ToastFuture? toastFuture;

    /// *** Content Building ***
    List<Widget> rowList = [];

    Widget msgWidget = Container(
      padding: FUIToastTheme.toast3Padding,
      constraints: BoxConstraints(
        maxWidth: context.size!.width * FUIToastTheme.toast3ContentMaxWidthFactor,
      ),
      child: FUIColumn(
        children: [
          Text(title, overflow: TextOverflow.ellipsis, style: fuiToastTheme.tsToast3Title),
          FUISpacer.vSpace10,
          Text(description, maxLines: 1, softWrap: false, overflow: TextOverflow.ellipsis, style: fuiToastTheme.tsToast3Desc),
        ],
      ),
    );

    Widget side;

    if (sideIcon != null || sideWidget != null) {
      if (sideIcon != null) {
        side = Container(
          padding: FUIToastTheme.toast3Padding,
          child: Icon(sideIcon),
        );
      } else {
        side = Container(
          padding: FUIToastTheme.toast3Padding,
          child: sideWidget!,
        );
      }

      switch (sideWidgetPosition) {
        case FUIToastIconPosition.right:
          rowList.add(msgWidget);
          rowList.add(side);
          break;
        case FUIToastIconPosition.left:
        default:
          rowList.add(side);
          rowList.add(msgWidget);
          break;
      }
    } else {
      rowList.add(msgWidget);
    }

    /// Toast Content
    Widget toastContent = Container(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      child: IntrinsicWidth(
        child: FUIColumn(
          children: [
            _buildCloseButtonRow(toastFuture),
            Row(
              children: rowList,
            ),
          ],
        ),
      ),
    );

    toastFuture = showToastWidget(
      _buildToastContainer(fuiColorScheme, fuiToastDecoBarPosition, toastContent),
      context: context,
      handleTouch: true,
      position: fuiToastPosition,
      duration: duration ?? FUIToastTheme.toast3Duration,
      animationDuration: animationDuration ?? FUIToastTheme.toast3AnimationDuration,
      onDismiss: onDismiss,
    );
  }

  Widget _buildCloseButtonRow(ToastFuture? toastFuture) {
    fuiColors = context.theme.fuiColors;

    return Container(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: () {
              if (toastFuture != null) {
                toastFuture.dismiss(showAnim: true);
              }
            },
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Padding(
                padding: FUIToastTheme.toast3CloseIconPadding,
                child: Icon(
                  CupertinoIcons.clear,
                  size: FUIToastTheme.toast3CloseIconSize,
                  color: fuiColors.shade3,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToastContainer(FUIColorScheme? fuiColorScheme, FUIToastDecoBarPosition? fuiToastDecoBarPosition, Widget child) {
    fuiToastTheme = context.theme.fuiToast;

    BoxDecoration toastContainerBoxDeco = BoxDecoration(
      shape: BoxShape.rectangle,
      color: fuiToastTheme.toast3BackgroundColor,
      border: Border.all(width: 0, color: Colors.transparent),
      borderRadius: BorderRadius.circular(3),
    );

    fuiToastDecoBarPosition ??= FUIToastDecoBarPosition.none;

    if (fuiToastDecoBarPosition != FUIToastDecoBarPosition.none) {
      Tuple2<double, double> decoBarWidthHeight = discernDecoBarWidthHeight(fuiToastDecoBarPosition);
      Color decoBarColor = discernColorByScheme(context, fuiColorScheme: fuiColorScheme);

      Container decoBar = Container(
        padding: EdgeInsets.zero,
        margin: EdgeInsets.zero,
        width: decoBarWidthHeight.item1,
        height: decoBarWidthHeight.item2,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: decoBarColor,
        ),
      );

      return Opacity(
        opacity: FUIToastTheme.toast3BackgroundOpacity,
        child: Container(
          margin: FUIToastTheme.toast3Margin,
          padding: EdgeInsets.zero,
          decoration: toastContainerBoxDeco,
          child: IntrinsicHeight(
            child: IntrinsicWidth(
              child: discernRowOrColumn(fuiToastDecoBarPosition, decoBar, child),
            ),
          ),
        ),
      );
    } else {
      return Opacity(
        opacity: FUIToastTheme.toast3BackgroundOpacity,
        child: Container(
          margin: FUIToastTheme.toast3Margin,
          padding: EdgeInsets.zero,
          decoration: toastContainerBoxDeco,
          child: IntrinsicHeight(
            child: IntrinsicWidth(
              child: child,
            ),
          ),
        ),
      );
    }
  }
}
