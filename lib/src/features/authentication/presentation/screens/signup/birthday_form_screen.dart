// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../constants/exports.dart';
import '../../../../../routing/app_routes/auth_routes.dart';
import '../../../../../utils/logger.dart';
import '../../../domain/controllers/persisted_users_controller.dart';
import '../../../domain/controllers/signup_form_controller.dart';
import '../../widgets/auth_button.dart';
import '../../widgets/auth_text_field.dart';
import '../../widgets/signup_widgets/headline_text.dart';
import '../../widgets/signup_widgets/signup_scaffold.dart';

class BirthdayFormScreen extends ConsumerStatefulWidget {
  const BirthdayFormScreen({super.key});

  @override
  ConsumerState<BirthdayFormScreen> createState() => _BirthdayFormScreenState();
}

class _BirthdayFormScreenState extends ConsumerState<BirthdayFormScreen> {
  late final TextEditingController _controller;
  late final TapGestureRecognizer _textTapRecognizer;
  bool _textFieldEnabled = true;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _textTapRecognizer = TapGestureRecognizer();
  }

  @override
  void dispose() {
    _controller.dispose();
    _textTapRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) {
    final isPersisted = ref.watch(isPersistedFlowProvider);
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        ref.read(signUpFormControllerProvider.notifier).resetBirthday();
        context.pop();
      },
      child: SignUpScaffold(
        child: Column(
          children: [
            const HeadlineText(text: 'What is your birthday?'),
            xsSeparator,
            RichText(
              text: TextSpan(
                text:
                    'Use your birthday, even though this account is for a business, a pet or anything else. Nobody will see this information only if you choose to make it public. ',
                style: const TextStyle(
                  color: Color(0xff1b2830),
                  fontSize: smallText,
                ),
                children: [
                  TextSpan(
                    text: '\nWhy should I give my birthday?',
                    style: const TextStyle(
                      color: loginBlueColor,
                    ),
                    recognizer: _textTapRecognizer
                      ..onTap = () {
                        getLogger(BirthdayFormScreen).d('text tap');
                      },
                  ),
                ],
              ),
            ),
            smallSeparator,
            AuthTextField(
              textController: _controller,
              labelText: 'Birthday',
              keyboardType: TextInputType.datetime,
              readOnly: true,
              enabled: _textFieldEnabled,
              onTap: () async {
                final DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );
                if (pickedDate != null) {
                  _controller.value = TextEditingValue(
                    text:
                        '${pickedDate.day} ${pickedDate.month} ${pickedDate.year}',
                  );
                  ref
                      .read(signUpFormControllerProvider.notifier)
                      .onBirthdayChange(pickedDate);
                }
              },
              errorText: ref.watch(
                signUpFormControllerProvider
                    .select((value) => value.birthday.error?.errorText),
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
                    .isValidBirhday();
                if (isValid) {
                  if (isPersisted.hasValue && isPersisted.value!) {
                    await const PersistedUsernameRoute().push(context);
                  } else {
                    await const UsernameRoute().push(context);
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
