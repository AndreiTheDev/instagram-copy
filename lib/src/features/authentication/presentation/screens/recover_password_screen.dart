import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../common_widgets/custom_back_button.dart';
import '../../../../constants/exports.dart';
import '../widgets/auth_button.dart';
import '../widgets/auth_outlined_button.dart';
import '../widgets/auth_text_button.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/gradient_decoration.dart';

class RecoverPasswordScreen extends StatefulWidget {
  const RecoverPasswordScreen({super.key});

  @override
  State<RecoverPasswordScreen> createState() => _RecoverPasswordScreenState();
}

class _RecoverPasswordScreenState extends State<RecoverPasswordScreen> {
  late final TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientDecoration(
        child: Padding(
          padding: const EdgeInsets.all(xsSize),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(
                buttonLeft: CustomBackButton(
                  onPressed: () {
                    context.pop();
                  },
                ),
              ),
              const Text(
                'Recover your account',
                style: TextStyle(
                  fontSize: largeText,
                  fontWeight: FontWeight.w600,
                ),
              ),
              xsSeparator,
              const Text(
                'Type your username, email or phone number.',
                style: TextStyle(
                  fontSize: smallText,
                ),
              ),
              minuscleSeparator,
              AuthTextButton(
                text: 'Unable to reset your password?',
                callback: () {},
                color: loginBlueColor,
              ),
              xsSeparator,
              AuthTextField(
                textController: _textController,
                labelText: 'Username, email address or phone number',
              ),
              smallSeparator,
              AuthButton(
                text: 'Send recovery link',
                callback: () {},
              ),
              xsSeparator,
              AuthOutlinedButton(
                text: 'Connect with facebook',
                callback: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
