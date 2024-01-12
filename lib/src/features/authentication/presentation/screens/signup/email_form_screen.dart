// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../constants/exports.dart';
import '../../../domain/controllers/auth_controller.dart';
import '../../../domain/controllers/signup_form_controller.dart';
import '../../widgets/auth_button.dart';
import '../../widgets/auth_outlined_button.dart';
import '../../widgets/auth_text_field.dart';
import '../../widgets/signup_widgets/description_text.dart';
import '../../widgets/signup_widgets/headline_text.dart';
import '../../widgets/signup_widgets/signup_scaffold.dart';

class EmailFormScreen extends ConsumerStatefulWidget {
  const EmailFormScreen({super.key});

  @override
  ConsumerState<EmailFormScreen> createState() => _EmailFormScreenState();
}

class _EmailFormScreenState extends ConsumerState<EmailFormScreen> {
  late final TextEditingController _controller;
  bool _textFieldEnabled = true;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: ref.read(signUpFormControllerProvider).email.fieldValue,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        ref.read(signUpFormControllerProvider.notifier).resetEmail();
        context.pop();
      },
      child: SignUpScaffold(
        child: Column(
          children: [
            const HeadlineText(
              text: 'What is your email adress?',
            ),
            xsSeparator,
            const DescriptionText(
              text:
                  'Enter your email adress where you can be contacted. Nobody else would be able to see it in your profile.',
            ),
            smallSeparator,
            AuthTextField(
              textController: _controller,
              labelText: 'Email adress',
              onChanged:
                  ref.read(signUpFormControllerProvider.notifier).onEmailChange,
              enabled: _textFieldEnabled,
              errorText: ref.watch(
                signUpFormControllerProvider
                    .select((value) => value.email.error?.errorText),
              ),
            ),
            smallSeparator,
            AuthButton(
              text: 'Next',
              callback: () async {
                setState(() {
                  _textFieldEnabled = false;
                });
                final bool isValid = ref
                    .read(signUpFormControllerProvider.notifier)
                    .isValidEmail();
                if (isValid) {
                  await ref.read(authControllerProvider).signUpWithEmail();
                }
                if (context.mounted) {
                  setState(() {
                    _textFieldEnabled = true;
                  });
                }
              },
            ),
            xsSeparator,
            AuthOutlinedButton(
              text: 'Sign up with phone number',
              callback: () async {
                await Navigator.maybePop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
