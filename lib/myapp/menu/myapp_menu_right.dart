import 'package:flutter/material.dart';

import '../../focus_ui_kit/exports.dart';

class MyAppMenuRight extends StatelessWidget {
  const MyAppMenuRight({super.key});

  @override
  Widget build(BuildContext context) {
    FUIThemeCommonColors fuiColors = context.theme.fuiColors;
    double screenHeight = MediaQuery.sizeOf(context).height;

    return SizedBox(
      width: FUIMenuTheme.drawerWidth,
      height: screenHeight,
      child: FUISingleChildScrollView(
        child: FUISectionContainer(
          backgroundColor: fuiColors.shade1,
          constraints: BoxConstraints(
            minHeight: screenHeight,
          ),
          child: FUIColumn(
            children: [
              /// Add stuff here...
              Regular(Text('This is right menu')),
            ],
          ),
        ),
      ),
    );
  }
}
