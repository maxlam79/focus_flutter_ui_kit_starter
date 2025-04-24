import 'package:flutter/material.dart';

import '../exports.dart';

class FUIHDivider extends StatelessWidget {
  FUIHDivider({
    Key? key,
  }) : super(key: key ?? UniqueKey());

  @override
  Widget build(BuildContext context) {
    final FUIThemeCommonColors fuiColors = context.theme.fuiColors;

    return Divider(
      color: fuiColors.shade2,
      thickness: 1,
    );
  }
}

class FUIVDivider extends StatelessWidget {
  final Color? color;

  FUIVDivider({
    Key? key,
    this.color,
  }) : super(key: key ?? UniqueKey());

  @override
  Widget build(BuildContext context) {
    final FUIThemeCommonColors fuiColors = context.theme.fuiColors;

    return VerticalDivider(
      color: color ?? fuiColors.shade2,
      thickness: 1,
    );
  }
}
