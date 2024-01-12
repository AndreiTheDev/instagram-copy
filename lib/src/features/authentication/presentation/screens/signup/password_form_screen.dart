// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../constants/exports.dart';
import '../../../../../routing/app_routes/auth_routes.dart';
import '../../../domain/controllers/persisted_users_controller.dart';
import '../../../domain/controllers/signup_form_controller.dart';
import '../../widgets/auth_button.dart';
import '../../widgets/auth_text_field.dart';
import '../../widgets/signup_widgets/description_text.dart';
import '../../widgets/signup_widgets/headline_text.dart';
import '../../widgets/signup_widgets/signup_scaffold.dart';

class PasswordFormScreen extends ConsumerStatefulWidget {
  const PasswordFormScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PasswordSignUpState();
}

class _PasswordSignUpState extends ConsumerState<PasswordFormScreen> {
  late final TextEditingController _controller;
  bool _isObscurePassword = true;
  bool _textFieldEnabled = true;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: ref.read(signUpFormControllerProvider).password.fieldValue,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) {
    final isPersisted = ref.watch(isPersistedFlowProvider);
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        ref.read(signUpFormControllerProvider.notifier).resetPassword();
        context.pop();
      },
      child: SignUpScaffold(
        child: Column(
          children: [
            const HeadlineText(text: 'Create a password'),
            xsSeparator,
            const DescriptionText(
              text:
                  'Create a password with at leat 6 letters or numbers.\nIt needs to be secure.',
            ),
            xsSeparator,
            AuthTextField(
              textController: _controller,
              labelText: 'Password',
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _isObscurePassword = !_isObscurePassword;
                  });
                },
                icon: Icon(
                  _isObscurePassword
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  size: 30,
                  color: const Color(0xff6f7a85),
                ),
              ),
              iconVisibility: _isObscurePassword,
              onChanged: ref
                  .read(signUpFormControllerProvider.notifier)
                  .onPasswordChange,
              enabled: _textFieldEnabled,
              errorText: ref.watch(
                signUpFormControllerProvider
                    .select((value) => value.password.error?.errorText),
              ),
            ),
            smallSeparator,
            AuthButton(
              text: 'Next',
              callback: () async {
                setState(() {
                  _textFieldEnabled = false;
                });
                final isValid = ref
                    .read(signUpFormControllerProvider.notifier)
                    .isValidPassword();
                if (isValid) {
                  if (isPersisted.hasValue && isPersisted.value!) {
                    await const PersistedPersistAccountRoute().push(context);
                  } else {
                    await const PersistAccountRoute().push(context);
                  }
                }
                setState(() {
                  _textFieldEnabled = true;
                });
              },
            ),
            xsSeparator,
          ],
        ),
      ),
    );
  }
}
