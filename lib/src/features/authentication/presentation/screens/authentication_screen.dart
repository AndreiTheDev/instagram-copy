import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../routing/app_routes/auth_routes.dart';

import '../../domain/controllers/persisted_users_controller.dart';
import 'splash_screen.dart';

class AuthenticationScreen extends ConsumerWidget {
  const AuthenticationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
      isPersistedFlowProvider,
      (prev, next) {
        print('prev: $prev');
        if (prev?.value != next.value) {
          switch (next) {
            case AsyncData(:final value):
              value
                  ? const PersistedSignInFlowRoute().go(context)
                  : const SignInFlowRoute().go(context);
              break;
          }
        }
      },
    );

    return const SplashScreen();
  }
}
