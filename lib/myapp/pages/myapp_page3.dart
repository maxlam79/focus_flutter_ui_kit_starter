import 'package:flutter/material.dart';
import 'package:responsive_grid/responsive_grid.dart';

import '../../focus_ui_kit/exports.dart';

class MyAppPage3 extends StatelessWidget {
  const MyAppPage3({super.key});

  @override
  Widget build(BuildContext context) {
    return FUISingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FUISectionPlain(
            horizontalSpace: FUISectionHorizontalSpace.tight,
            child: ResponsiveGridRow(
              children: [
                ResponsiveGridCol(
                  xs: 12,
                  child: FUISectionContainer(
                    child: Center(
                      child: Regular(Text('This is Page 3')),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
