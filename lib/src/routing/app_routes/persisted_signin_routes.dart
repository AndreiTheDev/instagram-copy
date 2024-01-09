import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/authentication/presentation/screens/persisted_signin_screen.dart';
import '../../features/authentication/presentation/screens/signin_screen.dart';
import '../../features/authentication/presentation/screens/signup/birthday_form_screen.dart';
import '../../features/authentication/presentation/screens/signup/complete_name_form_screen.dart';
import '../../features/authentication/presentation/screens/signup/email_form_screen.dart';
import '../../features/authentication/presentation/screens/signup/password_form_screen.dart';
import '../../features/authentication/presentation/screens/signup/persist_account_form_screen.dart';
import '../../features/authentication/presentation/screens/signup/phone_number_form_screen.dart';
import '../../features/authentication/presentation/screens/signup/username_form_screen.dart';

part 'persisted_signin_routes.g.dart';

@TypedGoRoute<PersistedSignInFlowRoute>(
  path: '/persistedsignin',
  routes: [
    TypedGoRoute<SignInRoute>(path: 'signin'),
    TypedGoRoute<CompleteNameRoute>(path: 'signup/complete-name-form'),
    TypedGoRoute<BirthdayRoute>(path: 'signup/birthday-form'),
    TypedGoRoute<EmailRoute>(path: 'signup/email-form'),
    TypedGoRoute<PasswordRoute>(path: 'signup/password-form'),
    TypedGoRoute<PersistAccountRoute>(path: 'signup/persist-account-form'),
    TypedGoRoute<PhoneNumberRoute>(path: 'signup/phone-number-form'),
    TypedGoRoute<UsernameRoute>(path: 'signup/username-form'),
  ],
)
class PersistedSignInFlowRoute extends GoRouteData {
  const PersistedSignInFlowRoute();

  @override
  Widget build(final BuildContext context, final GoRouterState state) =>
      const PersistedSignInScreen();
}

class SignInRoute extends GoRouteData {
  const SignInRoute();

  @override
  Widget build(final BuildContext context, final GoRouterState state) =>
      const SignInScreen(
        isPersisted: true,
      );
}

class CompleteNameRoute extends GoRouteData {
  const CompleteNameRoute();

  @override
  Widget build(final BuildContext context, final GoRouterState state) =>
      const CompleteNameFormScreen();
}

class BirthdayRoute extends GoRouteData {
  const BirthdayRoute();

  @override
  Widget build(final BuildContext context, final GoRouterState state) =>
      const BirthdayFormScreen();
}

class EmailRoute extends GoRouteData {
  const EmailRoute();

  @override
  Widget build(final BuildContext context, final GoRouterState state) =>
      const EmailFormScreen();
}

class PasswordRoute extends GoRouteData {
  const PasswordRoute();

  @override
  Widget build(final BuildContext context, final GoRouterState state) =>
      const PasswordFormScreen();
}

class PersistAccountRoute extends GoRouteData {
  const PersistAccountRoute();

  @override
  Widget build(final BuildContext context, final GoRouterState state) =>
      const PersistAccountFormScreen();
}

class PhoneNumberRoute extends GoRouteData {
  const PhoneNumberRoute();

  @override
  Widget build(final BuildContext context, final GoRouterState state) =>
      const PhoneNumberFormScreen();
}

class UsernameRoute extends GoRouteData {
  const UsernameRoute();

  @override
  Widget build(final BuildContext context, final GoRouterState state) =>
      const UsernameFormScreen();
}
