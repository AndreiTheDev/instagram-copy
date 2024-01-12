// ignore_for_file: use_decorated_box

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../constants/exports.dart';
import '../../../../../routing/app_routes/auth_routes.dart';
import '../../../domain/controllers/persisted_users_controller.dart';
import '../../widgets/auth_button.dart';
import '../../widgets/auth_outlined_button.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/gradient_decoration.dart';
import '../../widgets/persisted_widgets/persisted_users_layout.dart';
import '../splash_screen.dart';

class PersistedSignInScreen extends ConsumerStatefulWidget {
  const PersistedSignInScreen({super.key});

  @override
  ConsumerState<PersistedSignInScreen> createState() =>
      _PersistedSignInScreenState();
}

class _PersistedSignInScreenState extends ConsumerState<PersistedSignInScreen> {
  @override
  Widget build(final BuildContext context) {
    final bool isIos = Theme.of(context).platform == TargetPlatform.iOS;

    final persistedUsers = ref.watch(persistedUsersControllerProvider);

    return switch (persistedUsers) {
      AsyncData(:final value) => Scaffold(
          resizeToAvoidBottomInset: false,
          body: GradientDecoration(
            child: Padding(
              padding: const EdgeInsets.all(xsSize),
              child: Column(
                children: [
                  CustomAppBar(
                    buttonRight: IconButton(
                      iconSize: 28,
                      onPressed: () async {
                        if (value.length == 1) {
                          await PersistedSingleSettingsRoute($extra: value[0])
                              .push(context);
                        }
                        if (value.length > 1 && context.mounted) {
                          await const PersistedMultiSettingsRoute()
                              .push(context);
                        }
                      },
                      icon: const Icon(Icons.settings_outlined),
                    ),
                  ),
                  xsSeparator,
                  Image.asset(igLogoPath),
                  largeSeparator,
                  PersistedUsersLayout(usersList: value),
                  if (value.length == 1) mediumSeparator,
                  if (value.length == 1)
                    Consumer(
                      builder: (final context, final ref, final child) =>
                          AuthButton(
                        text: 'Log in',
                        callback: () async {},
                      ),
                    ),
                  xsSeparator,
                  AuthOutlinedButton(
                    text: 'Log in another account',
                    callback: () async =>
                        const PersistedSignInRoute().push(context),
                  ),
                  const Expanded(child: SizedBox()),
                  AuthOutlinedButton(
                    text: 'Create a new account',
                    callback: () async {
                      await const PersistedCompleteNameRoute().push(context);
                    },
                    textColor: loginBlueColor,
                    borderColor: loginBlueColor,
                  ),
                  minuscleSeparator,
                  Image.asset(
                    metaLogoPath,
                    width: 64,
                  ),
                  if (isIos) xsSeparator,
                ],
              ),
            ),
          ),
        ),
      _ => const SplashScreen(),
    };
  }
}
