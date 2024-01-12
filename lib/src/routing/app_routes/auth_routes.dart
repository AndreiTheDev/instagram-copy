import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/authentication/domain/models/user.dart';
import '../../features/authentication/presentation/screens/authentication_screen.dart';
import '../../features/authentication/presentation/screens/persisted_signin/persisted_multi_setting_screen.dart';
import '../../features/authentication/presentation/screens/persisted_signin/persisted_signin_screen.dart';
import '../../features/authentication/presentation/screens/persisted_signin/persisted_single_settings.dart';
import '../../features/authentication/presentation/screens/recover_password_screen.dart';
import '../../features/authentication/presentation/screens/signin_screen.dart';
import '../../features/authentication/presentation/screens/signup/birthday_form_screen.dart';
import '../../features/authentication/presentation/screens/signup/complete_name_form_screen.dart';
import '../../features/authentication/presentation/screens/signup/email_form_screen.dart';
import '../../features/authentication/presentation/screens/signup/password_form_screen.dart';
import '../../features/authentication/presentation/screens/signup/persist_account_form_screen.dart';
import '../../features/authentication/presentation/screens/signup/phone_number_form_screen.dart';
import '../../features/authentication/presentation/screens/signup/username_form_screen.dart';
import '../../features/authentication/presentation/screens/splash_screen.dart';
import '../../features/core/presentation/home_screen.dart';
import '../../features/core/presentation/someother_screen.dart';

part 'auth_routes.g.dart';

@TypedGoRoute<HomeRoute>(
  path: '/',
  routes: [
    TypedGoRoute<SomeOtherRoute>(path: 'someother'),
  ],
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

@TypedGoRoute<AuthenticationRoute>(
  path: '/authentication',
  routes: [
    TypedGoRoute<PersistedSignInFlowRoute>(
      path: 'persistedsignin',
      routes: [
        TypedGoRoute<PersistedMultiSettingsRoute>(
          path: 'persisted-settings',
          routes: [
            TypedGoRoute<PersistedSingleSettingsRoute>(
                path: 'delete-persisted'),
          ],
        ),
        TypedGoRoute<PersistedSignInRoute>(path: 'signin'),
        TypedGoRoute<PersistedRecoverPasswordRoute>(path: 'recover-password'),
        TypedGoRoute<PersistedCompleteNameRoute>(
          path: 'signup/complete-name-form',
        ),
        TypedGoRoute<PersistedBirthdayRoute>(path: 'signup/birthday-form'),
        TypedGoRoute<PersistedEmailRoute>(path: 'signup/email-form'),
        TypedGoRoute<PersistedPasswordRoute>(path: 'signup/password-form'),
        TypedGoRoute<PersistedPersistAccountRoute>(
          path: 'signup/persist-account-form',
        ),
        TypedGoRoute<PersistedPhoneNumberRoute>(
          path: 'signup/phone-number-form',
        ),
        TypedGoRoute<PersistedUsernameRoute>(path: 'signup/username-form'),
      ],
    ),
    TypedGoRoute<SignInFlowRoute>(
      path: 'signin',
      routes: [
        TypedGoRoute<RecoverPasswordRoute>(path: 'recover-password'),
        TypedGoRoute<CompleteNameRoute>(path: 'signup/complete-name-form'),
        TypedGoRoute<BirthdayRoute>(path: 'signup/birthday-form'),
        TypedGoRoute<EmailRoute>(path: 'signup/email-form'),
        TypedGoRoute<PasswordRoute>(path: 'signup/password-form'),
        TypedGoRoute<PersistAccountRoute>(path: 'signup/persist-account-form'),
        TypedGoRoute<PhoneNumberRoute>(path: 'signup/phone-number-form'),
        TypedGoRoute<UsernameRoute>(path: 'signup/username-form'),
      ],
    ),
  ],
)
class AuthenticationRoute extends GoRouteData {
  const AuthenticationRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const AuthenticationScreen();
}

class SomeOtherRoute extends GoRouteData {
  const SomeOtherRoute();

  @override
  Widget build(final BuildContext context, final GoRouterState state) =>
      const SomeOtherScreen();
}

class PersistedSignInFlowRoute extends GoRouteData {
  const PersistedSignInFlowRoute();

  @override
  Widget build(final BuildContext context, final GoRouterState state) =>
      const PersistedSignInScreen();
}

class PersistedMultiSettingsRoute extends GoRouteData {
  const PersistedMultiSettingsRoute();

  @override
  Widget build(final BuildContext context, final GoRouterState state) =>
      const PersistedMultiSettingsScreen();
}

class PersistedSingleSettingsRoute extends GoRouteData {
  PersistedSingleSettingsRoute({this.$extra});
  final UserModel? $extra;

  @override
  Widget build(final BuildContext context, final GoRouterState state) =>
      PersistedSingleSettingsScreen(
        user: $extra!,
      );
}

class PersistedSignInRoute extends GoRouteData {
  const PersistedSignInRoute();

  @override
  Widget build(final BuildContext context, final GoRouterState state) =>
      const SignInScreen();
}

class SignInFlowRoute extends GoRouteData {
  const SignInFlowRoute();

  @override
  Widget build(final BuildContext context, final GoRouterState state) =>
      const SignInScreen();
}

class PersistedCompleteNameRoute extends GoRouteData {
  const PersistedCompleteNameRoute();

  @override
  Widget build(final BuildContext context, final GoRouterState state) =>
      const CompleteNameFormScreen();
}

class PersistedRecoverPasswordRoute extends GoRouteData {
  const PersistedRecoverPasswordRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const RecoverPasswordScreen();
}

class RecoverPasswordRoute extends GoRouteData {
  const RecoverPasswordRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const RecoverPasswordScreen();
}

class CompleteNameRoute extends GoRouteData {
  const CompleteNameRoute();

  @override
  Widget build(final BuildContext context, final GoRouterState state) =>
      const CompleteNameFormScreen();
}

class PersistedBirthdayRoute extends GoRouteData {
  const PersistedBirthdayRoute();

  @override
  Widget build(final BuildContext context, final GoRouterState state) =>
      const BirthdayFormScreen();
}

class BirthdayRoute extends GoRouteData {
  const BirthdayRoute();

  @override
  Widget build(final BuildContext context, final GoRouterState state) =>
      const BirthdayFormScreen();
}

class PersistedEmailRoute extends GoRouteData {
  const PersistedEmailRoute();

  @override
  Widget build(final BuildContext context, final GoRouterState state) =>
      const EmailFormScreen();
}

class EmailRoute extends GoRouteData {
  const EmailRoute();

  @override
  Widget build(final BuildContext context, final GoRouterState state) =>
      const EmailFormScreen();
}

class PersistedPasswordRoute extends GoRouteData {
  const PersistedPasswordRoute();

  @override
  Widget build(final BuildContext context, final GoRouterState state) =>
      const PasswordFormScreen();
}

class PasswordRoute extends GoRouteData {
  const PasswordRoute();

  @override
  Widget build(final BuildContext context, final GoRouterState state) =>
      const PasswordFormScreen();
}

class PersistedPersistAccountRoute extends GoRouteData {
  const PersistedPersistAccountRoute();

  @override
  Widget build(final BuildContext context, final GoRouterState state) =>
      const PersistAccountFormScreen();
}

class PersistAccountRoute extends GoRouteData {
  const PersistAccountRoute();

  @override
  Widget build(final BuildContext context, final GoRouterState state) =>
      const PersistAccountFormScreen();
}

class PersistedPhoneNumberRoute extends GoRouteData {
  const PersistedPhoneNumberRoute();

  @override
  Widget build(final BuildContext context, final GoRouterState state) =>
      const PhoneNumberFormScreen();
}

class PhoneNumberRoute extends GoRouteData {
  const PhoneNumberRoute();

  @override
  Widget build(final BuildContext context, final GoRouterState state) =>
      const PhoneNumberFormScreen();
}

class PersistedUsernameRoute extends GoRouteData {
  const PersistedUsernameRoute();

  @override
  Widget build(final BuildContext context, final GoRouterState state) =>
      const UsernameFormScreen();
}

class UsernameRoute extends GoRouteData {
  const UsernameRoute();

  @override
  Widget build(final BuildContext context, final GoRouterState state) =>
      const UsernameFormScreen();
}
