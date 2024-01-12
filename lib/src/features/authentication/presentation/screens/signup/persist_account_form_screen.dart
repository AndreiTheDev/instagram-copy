// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../constants/exports.dart';
import '../../../../../routing/app_routes/auth_routes.dart';
import '../../../domain/controllers/persisted_users_controller.dart';
import '../../widgets/auth_button.dart';
import '../../widgets/auth_outlined_button.dart';
import '../../widgets/signup_widgets/description_text.dart';
import '../../widgets/signup_widgets/headline_text.dart';
import '../../widgets/signup_widgets/signup_scaffold.dart';

class PersistAccountFormScreen extends ConsumerWidget {
  const PersistAccountFormScreen({super.key});

  @override
  Widget build(final BuildContext context, WidgetRef ref) {
    final isPersisted = ref.watch(isPersistedFlowProvider);
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
            callback: () async {
              if (isPersisted.hasValue && isPersisted.value!) {
                await const PersistedBirthdayRoute().push(context);
              } else {
                await const BirthdayRoute().push(context);
              }
            },
          ),
          xsSeparator,
          AuthOutlinedButton(
            text: 'Not now',
            callback: () async {
              if (isPersisted.hasValue && isPersisted.value!) {
                await const PersistedBirthdayRoute().push(context);
              } else {
                await const BirthdayRoute().push(context);
              }
            },
          ),
        ],
      ),
    );
  }
}
