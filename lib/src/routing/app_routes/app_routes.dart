import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/authentication/presentation/screens/splash_screen.dart';
import '../../features/core/presentation/home_screen.dart';

part 'app_routes.g.dart';

@TypedGoRoute<HomeRoute>(
  path: '/',
)
class HomeRoute extends GoRouteData {
  const HomeRoute();

  @override
  Widget build(final BuildContext context, final GoRouterState state) =>
      const HomeScreen();
}

@TypedGoRoute<SplashScreenRoute>(path: '/splash')
class SplashScreenRoute extends GoRouteData {
  const SplashScreenRoute();

  @override
  Widget build(final BuildContext context, final GoRouterState state) =>
      const SplashScreen();
}
