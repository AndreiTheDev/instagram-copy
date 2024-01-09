import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../features/authentication/domain/controllers/user_controller.dart';
import '../features/authentication/domain/states/user_state.dart';
import 'app_routes/app_routes.dart';
import 'app_routes/persisted_signin_routes.dart' as persisted_flow;
import 'app_routes/signin_routes.dart' as signin_flow;

part 'app_router.g.dart';

final routerKey = GlobalKey<NavigatorState>(debugLabel: 'routerKey');

@riverpod
GoRouter router(final RouterRef ref) {
  final isUserSignedIn = ValueNotifier<UserState>(UserInitial());
  final hasPersisterUsers = ValueNotifier<bool>(true);

  ref
    ..onDispose(isUserSignedIn.dispose)
    ..onDispose(hasPersisterUsers.dispose)
    ..listen(userStateProvider, (final previous, final next) {
      isUserSignedIn.value = switch (next) {
        AsyncData(:final value) => value,
        _ => UserUnauthenticated(),
      };
      hasPersisterUsers.value = true;
    });
  // ..listen(userStateProvider, (final previous, final next) {
  // });

  final router = GoRouter(
    refreshListenable: isUserSignedIn,
    initialLocation: const HomeRoute().location,
    navigatorKey: routerKey,
    routes: [
      ...$appRoutes,
      ...persisted_flow.$appRoutes,
      ...signin_flow.$appRoutes,
    ],
    redirect: (final context, final state) {
      final userState = isUserSignedIn.value;
      final bool isSpalshScreen =
          state.matchedLocation == const SplashScreenRoute().location;
      final bool isPersistedSignIn = state.matchedLocation
          .startsWith(const persisted_flow.PersistedSignInFlowRoute().location);
      final bool isSigningIn = state.matchedLocation
          .startsWith(const signin_flow.SignInFlowRoute().location);
      print(
        '${state.matchedLocation} $isSpalshScreen $isPersistedSignIn $isSigningIn',
      );

      if (userState.runtimeType == UserInitial) {
        return isSpalshScreen ? null : const SplashScreenRoute().location;
      }
      if (userState.runtimeType == UserUnauthenticated &&
          hasPersisterUsers.value &&
          !isSigningIn &&
          !isSpalshScreen) {
        return isPersistedSignIn
            ? null
            : const persisted_flow.PersistedSignInFlowRoute().location;
      }
      if (userState.runtimeType == UserUnauthenticated &&
          !isPersistedSignIn &&
          !isSpalshScreen) {
        return isSigningIn
            ? null
            : const signin_flow.SignInFlowRoute().location;
      }
      if (isSigningIn || isSpalshScreen || isPersistedSignIn) {
        return const HomeRoute().location;
      }
      return null;
    },
  );
  ref.onDispose(router.dispose);

  return router;
}
