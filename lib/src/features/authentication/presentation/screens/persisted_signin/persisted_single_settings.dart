// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../common_widgets/custom_back_button.dart';
import '../../../../../constants/exports.dart';
import '../../../domain/controllers/persisted_users_controller.dart';
import '../../../domain/models/user.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/gradient_decoration.dart';

class PersistedSingleSettingsScreen extends ConsumerStatefulWidget {
  const PersistedSingleSettingsScreen({required this.user, super.key});

  final UserModel user;

  @override
  ConsumerState<PersistedSingleSettingsScreen> createState() =>
      _PersistedSingleSettingsScreenState();
}

class _PersistedSingleSettingsScreenState
    extends ConsumerState<PersistedSingleSettingsScreen> {
  late final TapGestureRecognizer _tapRecognizer;

  @override
  void initState() {
    super.initState();
    _tapRecognizer = TapGestureRecognizer();
  }

  @override
  void dispose() {
    _tapRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientDecoration(
        child: Padding(
          padding: const EdgeInsets.all(xsSize),
          child: Column(
            children: [
              CustomAppBar(
                buttonLeft: CustomBackButton(onPressed: context.pop),
              ),
              smallSeparator,
              const CircleAvatar(
                backgroundImage: AssetImage(
                  'assets/images/my_photo.jpg',
                ),
                radius: largeSize,
              ),
              xsSeparator,
              Text(
                widget.user.email,
                style: const TextStyle(
                  fontSize: smallText,
                  fontWeight: FontWeight.w600,
                ),
              ),
              largeSeparator,
              GestureDetector(
                child: Container(
                  padding: const EdgeInsets.all(xsSize),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const <BoxShadow>[
                      BoxShadow(
                        color: Color(0xffEEEEEE),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  width: double.infinity,
                  height: xlSize,
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Delete profile',
                      style: TextStyle(
                        color: errorColor,
                        fontSize: xsSize,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                onTap: () async {
                  await ref
                      .read(persistedUsersControllerProvider.notifier)
                      .deleteUser(widget.user.uid);
                  final isPersisted =
                      await ref.read(isPersistedFlowProvider.future);
                  if (context.mounted && isPersisted && context.canPop()) {
                    context.pop();
                  }
                },
              ),
              xsSeparator,
              RichText(
                text: TextSpan(
                  text: 'Find out more',
                  style: const TextStyle(
                    color: loginBlueColor,
                    height: 1.5,
                  ),
                  recognizer: _tapRecognizer..onTap = () {},
                  children: const [
                    TextSpan(
                      text:
                          ' about the reason of why you see this profile and what does his deletion means.',
                      style: TextStyle(
                        color: textColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
