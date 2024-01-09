import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../constants/exports.dart';
import '../../../../routing/app_routes/persisted_signin_routes.dart';
import '../../data/persisted_signin_repository.dart';
import '../widgets/auth_button.dart';
import '../widgets/auth_outlined_button.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/gradient_decoration.dart';

class PersistedSignInScreen extends StatelessWidget {
  const PersistedSignInScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    final bool isIos = Theme.of(context).platform == TargetPlatform.iOS;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GradientDecoration(
        child: Padding(
          padding: const EdgeInsets.all(xsSize),
          child: Column(
            children: [
              CustomAppBar(
                buttonRight: IconButton(
                  iconSize: 28,
                  onPressed: () {},
                  icon: const Icon(Icons.settings_outlined),
                ),
              ),
              xsSeparator,
              Image.asset(igLogoPath),
              largeSeparator,
              DecoratedBox(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                    width: 4,
                  ),
                  boxShadow: const <BoxShadow>[
                    BoxShadow(
                      color: Color(0xffe0e0e1),
                      spreadRadius: 8,
                      blurRadius: 8,
                    ),
                  ],
                  shape: BoxShape.circle,
                ),
                child: const CircleAvatar(
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage(
                    'assets/images/my_photo.jpg',
                  ),
                  radius: 80,
                ),
              ),
              xsSeparator,
              const Text(
                'emulanuellamba',
                style: TextStyle(
                  fontSize: mediumText,
                  fontWeight: FontWeight.w600,
                ),
              ),
              mediumSeparator,
              Consumer(
                builder: (final context, final ref, final child) => AuthButton(
                  callback: () async {
                    await ref
                        .read(persistedSignInRepositoryProvider)
                        .signInWithToken();
                  },
                  text: 'Log in',
                ),
              ),
              xsSeparator,
              AuthOutlinedButton(
                text: 'Log in another account',
                callback: () async => const SignInRoute().push(context),
              ),
              const Expanded(child: SizedBox()),
              AuthOutlinedButton(
                text: 'Create a new account',
                callback: () async {
                  await const CompleteNameRoute().push(context);
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
    );
  }
}
