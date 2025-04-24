import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

import '../../exports.dart';

class FUIToast1 with FUIToastMixin, FUIColorMixin {
  final BuildContext context;

  FUIToast1(this.context);

  show({
    required String msg,
    FUIColorScheme? fuiColorScheme,
    FUIToastPosition? fuiToastPosition,
    TextStyle? textStyle,
    Color? backgroundColor,
    Duration? duration,
    Duration? animationDuration,
    double? radius,
    VoidCallback? onDismiss,
  }) {
    showToast(
      msg,
      context: context,
      position: fuiToastPosition ?? FUIToastPosition.top,
      duration: duration ?? FUIToastTheme.toast12Duration,
      animationDuration: animationDuration ?? FUIToastTheme.toast12AnimationDuration,
      backgroundColor:
          backgroundColor ?? discernColorByScheme(context, fuiColorScheme: fuiColorScheme).withValues(alpha: FUIToastTheme.toast12BackgroundOpacity),
      textStyle: textStyle ?? discernTextStyle(context, fuiToastColorScheme: fuiColorScheme),
      radius: radius ?? FUIToastTheme.toast12Radius,
      onDismiss: onDismiss,
    );
  }
}
