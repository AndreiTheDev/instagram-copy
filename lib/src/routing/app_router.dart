import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../features/authentication/domain/controllers/user_controller.dart';
import '../features/authentication/domain/states/user_state.dart';
import 'app_routes/auth_routes.dart';

part 'app_router.g.dart';

final routerKey = GlobalKey<NavigatorState>(debugLabel: 'routerKey');

@riverpod
GoRouter router(final RouterRef ref) {
  final userStateProviderValue = ref.watch(userStateProvider);
  final router = GoRouter(
    initialLocation: const SplashScreenRoute().location,
    navigatorKey: routerKey,
    routes: [
      ...$appRoutes,
    ],
    redirect: (final context, final state) {
      print(state.fullPath);
      if (userStateProviderValue.isLoading || userStateProviderValue.hasError) {
        return null;
      }

      final bool isAuthenticated = switch (userStateProviderValue.value!) {
        UserAuthenticated() => true,
        _ => false
      };

      final bool isSpalshScreen =
          state.matchedLocation == const SplashScreenRoute().location;

      if (isSpalshScreen) {
        return isAuthenticated
            ? const HomeRoute().location
            : const AuthenticationRoute().location;
      }

      final bool isSigningIn = state.matchedLocation
          .startsWith(const AuthenticationRoute().location);

      if (isSigningIn) {
        return isAuthenticated ? const HomeRoute().location : null;
      }

      return isAuthenticated ? null : const SplashScreenRoute().location;
    },
  );
  ref.onDispose(router.dispose);

  return router;
}
