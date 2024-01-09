import 'package:flutter/material.dart';

import '../../../../../common_widgets/custom_back_button.dart';
import '../../../../../constants/exports.dart';
import '../../../../../routing/app_routes/persisted_signin_routes.dart';
import '../auth_text_button.dart';
import '../custom_app_bar.dart';
import '../gradient_decoration.dart';

class SignUpScaffold extends StatelessWidget {
  const SignUpScaffold({required this.child, super.key});

  final Widget child;

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
                buttonLeft: CustomBackButton(
                  onPressed: () async {
                    await Navigator.maybePop(context);
                  },
                ),
              ),
              child,
              const Expanded(child: SizedBox()),
              AuthTextButton(
                text: 'Already have an account?',
                callback: () {
                  const SignInRoute().go(context);
                },
                color: loginBlueColor,
              ),
              if (isIos) minuscleSeparator,
            ],
          ),
        ),
      ),
    );
  }
}
