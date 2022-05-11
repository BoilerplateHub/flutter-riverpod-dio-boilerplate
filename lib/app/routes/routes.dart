import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'route_paths.dart';
import '../splash_screen_page.dart';
import '../../app/widget/no_found_widget.dart';
import '../../features/home/widget/home_page.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: routeInitial,
      pageBuilder: (context, state) {
        return MaterialPage(
          key: state.pageKey,
          child: const SplashScreenPage(),
        );
      },
    ),
    GoRoute(
      path: routeHome,
      pageBuilder: (context, state) {
        return MaterialPage(
          key: state.pageKey,
          child: const HomePage(),
        );
      },
    ),
  ],
  errorPageBuilder: (context, state) {
    return MaterialPage(
      key: state.pageKey,
      child: NotFoundWidget(
        exception: state.error,
      ),
    );
  },
);
