import 'package:flutter/material.dart';

import '../../../../../constants/exports.dart';
import '../../../../../routing/app_routes/persisted_signin_routes.dart';
import '../../widgets/auth_button.dart';
import '../../widgets/auth_outlined_button.dart';
import '../../widgets/signup_widgets/description_text.dart';
import '../../widgets/signup_widgets/headline_text.dart';
import '../../widgets/signup_widgets/signup_scaffold.dart';

class PersistAccountFormScreen extends StatelessWidget {
  const PersistAccountFormScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    return SignUpScaffold(
      child: Column(
        children: [
          const HeadlineText(text: 'Do you want to save sign in informations?'),
          xsSeparator,
          const DescriptionText(
            text:
                'We will save you sign in informations for you new account, such that you will not need to reintroduce them again next time when you will sign in.',
          ),
          smallSeparator,
          AuthButton(
            text: 'Save',
            callback: () {
              const BirthdayRoute().push(context);
            },
          ),
          xsSeparator,
          AuthOutlinedButton(
            text: 'Not now',
            callback: () {
              const BirthdayRoute().push(context);
            },
          ),
        ],
      ),
    );
  }
}
