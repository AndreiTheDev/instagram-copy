import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../constants/exports.dart';
import '../../../../../routing/app_routes/persisted_signin_routes.dart';
import '../../../domain/controllers/signup_form_controller.dart';
import '../../widgets/auth_button.dart';
import '../../widgets/auth_outlined_button.dart';
import '../../widgets/auth_text_field.dart';
import '../../widgets/signup_widgets/description_text.dart';
import '../../widgets/signup_widgets/headline_text.dart';
import '../../widgets/signup_widgets/signup_scaffold.dart';

class PhoneNumberFormScreen extends ConsumerStatefulWidget {
  const PhoneNumberFormScreen({super.key});

  @override
  ConsumerState<PhoneNumberFormScreen> createState() =>
      _PhoneNumberFormScreenState();
}

class _PhoneNumberFormScreenState extends ConsumerState<PhoneNumberFormScreen> {
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(
      text: ref.read(signUpFormControllerProvider).phoneNumber.fieldValue,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        ref.read(signUpFormControllerProvider.notifier).resetPhoneNumber();
        context.pop();
      },
      child: SignUpScaffold(
        child: Column(
          children: [
            const HeadlineText(
              text: 'What is your phone number?',
            ),
            xsSeparator,
            const DescriptionText(
              text:
                  'Enter your phone number. Nobody else would be able to see it in your profile.',
            ),
            smallSeparator,
            AuthTextField(
              textController: controller,
              labelText: 'Phone number',
              keyboardType: TextInputType.phone,
              onChanged: ref
                  .read(signUpFormControllerProvider.notifier)
                  .onPhoneNumberChange,
              enabled: false,
              errorText: ref.watch(
                signUpFormControllerProvider
                    .select((value) => value.phoneNumber.error?.errorText),
              ),
            ),
            minuscleSeparator,
            const Text(
              'It is possible to send you SMS notifications for security and sign in.',
            ),
            smallSeparator,
            AuthButton(
              text: 'Next',
              callback: () async {
                await showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      child: Container(
                        height: 200,
                        width: 300,
                        color: Colors.white,
                        child: const Text(
                          'Authentication with phone number is not working at the moment',
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            xsSeparator,
            AuthOutlinedButton(
              text: 'Sign up with email',
              callback: () async {
                await const EmailRoute().push(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
