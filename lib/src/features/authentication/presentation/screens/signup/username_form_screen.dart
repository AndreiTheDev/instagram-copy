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

class UsernameFormScreen extends ConsumerStatefulWidget {
  const UsernameFormScreen({super.key});

  @override
  ConsumerState<UsernameFormScreen> createState() => _UsernameFormScreenState();
}

class _UsernameFormScreenState extends ConsumerState<UsernameFormScreen> {
  late final TextEditingController _controller;
  bool _textFieldEnabled = true;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: ref.read(signUpFormControllerProvider).username.fieldValue,
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
        ref.read(signUpFormControllerProvider.notifier).resetUsername();
        context.pop();
      },
      child: SignUpScaffold(
        child: Column(
          children: [
            const HeadlineText(text: 'Create an username'),
            xsSeparator,
            const DescriptionText(
              text:
                  'Add a username or use our suggestion. You can change it anytime.',
            ),
            smallSeparator,
            Consumer(
              builder: (context, ref, widget) {
                final isValidating = ref.watch(
                  signUpFormControllerProvider
                      .select((value) => value.username.isValidating),
                );
                final error = ref.watch(
                  signUpFormControllerProvider
                      .select((value) => value.username.error?.errorText),
                );
                final bool hasError = error != null && true;
                return AuthTextField(
                  textController: _controller,
                  labelText: 'Username',
                  onChanged: ref
                      .read(signUpFormControllerProvider.notifier)
                      .onUsernameChange,
                  enabled: _textFieldEnabled,
                  errorText: error,
                  suffixIcon: isValidating
                      ? Transform.scale(
                          scale: 0.5,
                          child: const CircularProgressIndicator(
                            color: Color(0xff6f7a85),
                          ),
                        )
                      : hasError
                          ? const Icon(
                              Icons.close,
                              size: 30,
                              color: Color(0xff6f7a85),
                            )
                          : null,
                );
              },
            ),
            smallSeparator,
            AuthButton(
              text: 'Next',
              callback: () async {
                setState(() {
                  _textFieldEnabled = false;
                });
                final isValidUsername = ref
                    .read(signUpFormControllerProvider.notifier)
                    .shouldValidateUsername();
                if (isValidUsername) {
                  if (isPersisted.hasValue && isPersisted.value!) {
                    await const PersistedPhoneNumberRoute().push(context);
                  } else {
                    await const PhoneNumberRoute().push(context);
                  }
                }
                setState(() {
                  _textFieldEnabled = true;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
