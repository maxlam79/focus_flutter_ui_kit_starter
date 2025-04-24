import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:focus_ui_kit_starter/myapp/myapp_router.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:responsive_grid/responsive_grid.dart';

import '../focus_ui_kit/exports.dart';
import 'menu/myapp_menu_left.dart';
import 'menu/myapp_menu_right.dart';

class MyAppScaffoldLayout extends StatefulWidget {
  final Widget child;

  const MyAppScaffoldLayout({
    super.key,
    required this.child,
  });

  @override
  State<MyAppScaffoldLayout> createState() => _MyAppScaffoldLayoutState();
}

class _MyAppScaffoldLayoutState extends State<MyAppScaffoldLayout> {
  /// Global Keys
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>(debugLabel: 'scaffold');
  GlobalKey<SliderDrawerState> sliderDrawerKey = GlobalKey<SliderDrawerState>();

  /// Themes
  late FUIThemeCommonColors fuiColors;

  /// Menu
  late FUIExpMenuController menuCtrl;
  late MyAppMenuLeft myAppMenuLeft;
  late MyAppMenuRight myAppMenuRight;

  /// Other essential parameters
  final double sliderOpenSize = 300;
  final double topBarHeight = 60;

  @override
  void initState() {
    super.initState();

    _initMenu();
  }

  _initMenu() {
    // Having the menu controller here is important. It retains certain opened menu "state" (because the slider/drawer disposes itself after close).
    menuCtrl = FUIExpMenuController();

    myAppMenuLeft = MyAppMenuLeft(
      title: const Text('menu'),
      fuiExpMenu: FUIExpMenu(
        fuiMenuController: menuCtrl,
        fuiMenuItems: _generateMenuItems(),
      ),
      footer: Align(
        alignment: Alignment.bottomRight,
        child: const Text('/// Here\'s the footer'),
      ),
    );

    myAppMenuRight = const MyAppMenuRight();
  }

  @override
  Widget build(BuildContext context) {
    fuiColors = context.theme.fuiColors;

    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        appBar: const PreferredSize(
          preferredSize: Size(0, 0),
          child: SizedBox.shrink(),
        ),
        endDrawer: myAppMenuRight,
        extendBody: true,
        backgroundColor: fuiColors.bg0,
        body: SliderDrawer(
          appBar: const SizedBox.shrink(),
          key: sliderDrawerKey,
          slider: myAppMenuLeft,
          sliderOpenSize: sliderOpenSize,
          isDraggable: false,
          animationDuration: 100,
          child: Column(
            children: [
              _buildTopBar(),
              Expanded(child: widget.child),
            ],
          ),
        ),
      ),
    );
  }

  List<FUIMenuItem> _generateMenuItems() {
    return [
      FUIMenuItem(
        key: UniqueKey(),
        label: const Text('Pages'),
        icon: const Icon(LineAwesome.stream_solid),
        onPressed: () {},
        fuiSubMenuItems: [
          FUISubMenuItem(
            key: UniqueKey(),
            label: const Text('Page 1'),
            onPressed: () => _goto(MyAppPaths.pathPage1),
          ),
          FUISubMenuItem(
            key: UniqueKey(),
            label: const Text('Page 2'),
            onPressed: () => _goto(MyAppPaths.pathPage2),
          ),
          FUISubMenuItem(
            key: UniqueKey(),
            label: const Text('Page 3'),
            onPressed: () => _goto(MyAppPaths.pathPage3),
          ),
        ],
      ),
    ];
  }

  _buildTopBar() {
    ResponsiveGridCol menuLeft = ResponsiveGridCol(
      xs: 6,
      child: Container(
        height: topBarHeight,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            FUIButtonLinkIcon(
              fuiButtonSize: FUIButtonSize.small,
              icon: const Icon(BoxIcons.bx_menu),
              onPressed: () => _sliderToggle(),
            ),
            FUISpacer.hSpace20,
            _buildLogo(),
          ],
        ),
      ),
    );

    ResponsiveGridCol menuRight = ResponsiveGridCol(
      xs: 6,
      child: Container(
        height: topBarHeight,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FUIButtonLinkIcon(
              fuiButtonSize: FUIButtonSize.small,
              icon: const Icon(BoxIcons.bx_search),
              onPressed: () {},
            ),
            FUISpacer.hSpace5,
            FUIButtonLinkIcon(
              fuiButtonSize: FUIButtonSize.small,
              icon: const Icon(BoxIcons.bx_menu_alt_right),
              onPressed: () => _drawerEndOpen(),
            ),
          ],
        ),
      ),
    );

    return ResponsiveGridRow(
      children: [
        menuLeft,
        menuRight,
      ],
    );
  }

  _buildLogo() {
    const double fontSize = 32;
    const String fontFamily = FUITypographyTheme.fontFamilyPrimary;

    Text t1 = Text(
      '.',
      style: TextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize,
        fontWeight: FontWeight.w900,
        color: fuiColors.namedRuby,
      ),
    );

    Text t2 = Text(
      'logo',
      style: TextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize,
        fontWeight: FontWeight.w900,
        color: fuiColors.textHeading,
      ),
    );

    return Row(
      children: [t1, t2],
    );
  }

  _sliderToggle() {
    if (sliderDrawerKey.currentState != null) {
      if (sliderDrawerKey.currentState!.isDrawerOpen) {
        sliderDrawerKey.currentState!.closeSlider();
      } else {
        sliderDrawerKey.currentState!.openSlider();
      }
    }
  }

  _sliderClose() {
    if (sliderDrawerKey.currentState != null && sliderDrawerKey.currentState!.isDrawerOpen) {
      sliderDrawerKey.currentState!.closeSlider();
    }
  }

  _drawerEndOpen() {
    if (scaffoldKey.currentState != null && !scaffoldKey.currentState!.isDrawerOpen) {
      scaffoldKey.currentState!.openEndDrawer();
    }
  }

  _drawerEndClose() {
    if (scaffoldKey.currentState != null && scaffoldKey.currentState!.isDrawerOpen) {
      scaffoldKey.currentState!.closeEndDrawer();
    }
  }

  _goto(String path) {
    context.go(path);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _sliderClose();
      _drawerEndClose();
    });
  }
}
