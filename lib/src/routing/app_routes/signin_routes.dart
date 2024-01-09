import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/authentication/presentation/screens/signin_screen.dart';
import '../../features/authentication/presentation/screens/signup_screen.dart';

part 'signin_routes.g.dart';

@TypedGoRoute<SignInFlowRoute>(
  path: '/signin',
  routes: [
    TypedGoRoute<SignUpRoute>(
      path: 'signup',
    ),
  ],
)
class SignInFlowRoute extends GoRouteData {
  const SignInFlowRoute();

  @override
  Widget build(final BuildContext context, final GoRouterState state) =>
      const SignInScreen();
}

class SignUpRoute extends GoRouteData {
  const SignUpRoute();

  @override
  Widget build(final BuildContext context, final GoRouterState state) =>
      const SignUpScreen();
}
