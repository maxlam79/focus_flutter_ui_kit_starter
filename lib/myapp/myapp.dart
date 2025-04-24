import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'myapp_router.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late MyAppRouter router;

  /// Global Keys
  GlobalKey<NavigatorState> navRootKey = GlobalKey<NavigatorState>(debugLabel: 'root');
  GlobalKey<NavigatorState> navShellKey = GlobalKey<NavigatorState>(debugLabel: 'shell');

  @override
  void initState() {
    super.initState();

    router = MyAppRouter(
      navRootKey: navRootKey,
      navShellKey: navShellKey,
    );
  }

  @override
  void dispose() {
    if (navRootKey.currentState != null) {
      navRootKey.currentState!.dispose();
    }

    if (navShellKey.currentState != null) {
      navShellKey.currentState!.dispose();
    }

    super.dispose();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: MaterialApp.router(
        routerConfig: router.generateRouterConfig(),
        debugShowCheckedModeBanner: false,
        builder: (context, child) {
          return ResponsiveBreakpoints.builder(
            child: child!,
            breakpoints: [
              const Breakpoint(start: 0, end: 450, name: MOBILE),
              const Breakpoint(start: 451, end: 800, name: TABLET),
              const Breakpoint(start: 801, end: 1920, name: DESKTOP),
              const Breakpoint(start: 1921, end: double.infinity, name: '4K')
            ],
          );
        },
      ),
    );
  }
}
