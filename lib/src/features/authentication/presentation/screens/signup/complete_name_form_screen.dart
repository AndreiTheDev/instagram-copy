import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../constants/exports.dart';
import '../../../../../routing/app_routes/persisted_signin_routes.dart';
import '../../../domain/controllers/signup_form_controller.dart';
import '../../widgets/auth_button.dart';
import '../../widgets/auth_text_field.dart';
import '../../widgets/signup_widgets/headline_text.dart';
import '../../widgets/signup_widgets/signup_scaffold.dart';

class CompleteNameFormScreen extends ConsumerStatefulWidget {
  const CompleteNameFormScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CompleteNameSignUpState();
}

class _CompleteNameSignUpState extends ConsumerState<CompleteNameFormScreen> {
  late final TextEditingController _controller;
  bool _textFieldEnabled = true;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: ref.read(signUpFormControllerProvider).completeName.fieldValue,
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
      onPopInvoked: (final didPop) async {
        await showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              child: Container(
                height: 200,
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    context
                      ..pop()
                      ..pop();
                  },
                  child: Text('pop'),
                ),
              ),
            );
          },
        );
      },
      child: SignUpScaffold(
        child: Column(
          children: [
            const HeadlineText(text: "What's your name?"),
            xsSeparator,
            Consumer(
              builder: (context, ref, widget) {
                return AuthTextField(
                  textController: _controller,
                  labelText: 'Complete name',
                  onChanged: ref
                      .read(signUpFormControllerProvider.notifier)
                      .onCompleteNameChange,
                  enabled: _textFieldEnabled,
                  errorText: ref.watch(
                    signUpFormControllerProvider
                        .select((value) => value.completeName.error?.errorText),
                  ),
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
                final bool isValid = ref
                    .read(signUpFormControllerProvider.notifier)
                    .isValidCompleteName();
                if (isValid) {
                  await const PasswordRoute().push(context);
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
