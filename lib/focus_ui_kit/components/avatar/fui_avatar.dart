import 'package:color_shade/color_shade.dart';
import 'package:flutter/material.dart';

import '../../exports.dart';

class FUIAvatar extends StatelessWidget with FUIColorMixin {
  final FUIColorScheme fuiColorScheme;
  final FUIAvatarSize fuiAvatarSize;
  final double? radius; // overrides fuiAvatarSize
  final ImageProvider avatar;
  final Color? borderColor;
  final double? padding;
  final Color? paddingColor;

  const FUIAvatar({
    super.key,
    this.fuiColorScheme = FUIColorScheme.primary,
    this.fuiAvatarSize = FUIAvatarSize.medium,
    this.radius,
    required this.avatar,
    this.borderColor,
    this.padding,
    this.paddingColor,
  });

  @override
  Widget build(BuildContext context) {
    Color borderColor = this.borderColor ??
        discernColorByScheme(
          context,
          fuiColorScheme: fuiColorScheme,
        );

    Color paddingColor = this.paddingColor?.shade50 ??
        discernColorByScheme(
          context,
          fuiColorScheme: fuiColorScheme,
        ).shade50;

    double finalRadius;

    if (radius == null) {
      switch (fuiAvatarSize) {
        case FUIAvatarSize.small:
          finalRadius = FUIAvatarTheme.radiusSmall;
          break;
        case FUIAvatarSize.large:
          finalRadius = FUIAvatarTheme.radiusLarge;
          break;
        case FUIAvatarSize.medium:
        default:
          finalRadius = FUIAvatarTheme.radiusMedium;
          break;
      }
    } else {
      finalRadius = radius!;
    }

    return CircleAvatar(
      radius: finalRadius,
      backgroundColor: borderColor,
      child: Transform.scale(
        scale: 0.95,
        child: CircleAvatar(
          backgroundColor: paddingColor,
          child: Transform.scale(
            scale: 0.9,
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.transparent,
              backgroundImage: avatar,
            ),
          ),
        ),
      ),
    );
  }
}
