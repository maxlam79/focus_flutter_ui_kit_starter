import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'myapp_scaffold_layout.dart';
import 'pages/myapp_page1.dart';
import 'pages/myapp_page2.dart';
import 'pages/myapp_page3.dart';

/// Define your page paths here.
class MyAppPaths {
  static const String pathPage1 = '/pages/page1';
  static const String pathPage2 = '/pages/page2';
  static const String pathPage3 = '/pages/page3';
}

/// Page router.
class MyAppRouter {
  /// Global Keys
  late GlobalKey<NavigatorState> navRootKey;
  late GlobalKey<NavigatorState> navShellKey;

  /// Router
  late final GoRouter goRouter;

  MyAppRouter({
    required this.navRootKey,
    required this.navShellKey,
  }) {
    initRouterConfig();
  }

  initRouterConfig() {
    goRouter = GoRouter(
      navigatorKey: navRootKey,
      initialLocation: MyAppPaths.pathPage1,
      debugLogDiagnostics: false,
      routes: <RouteBase>[
        /// Screen with scaffold layout
        ShellRoute(
          navigatorKey: navShellKey,
          builder: (context, state, child) {
            return MyAppScaffoldLayout(child: child);
          },
          routes: <RouteBase>[
            /// Add the page paths here...
            /// *** Page 1 ***
            GoRoute(
              path: MyAppPaths.pathPage1,
              builder: (context, state) => const MyAppPage1(),
            ),

            /// *** Page 2 ***
            GoRoute(
              path: MyAppPaths.pathPage2,
              builder: (context, state) => const MyAppPage2(),
            ),

            /// *** Page 3 ***
            GoRoute(
              path: MyAppPaths.pathPage3,
              builder: (context, state) => const MyAppPage3(),
            ),
          ],
        ),
      ],
    );
  }

  GoRouter generateRouterConfig() {
    return goRouter;
  }
}
