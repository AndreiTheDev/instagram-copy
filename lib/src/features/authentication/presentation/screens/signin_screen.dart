import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

// import '../../domain/auth_controller.dart';
import '../../../../common_widgets/custom_back_button.dart';
import '../../../../constants/exports.dart';
import '../../../../routing/app_routes/auth_routes.dart';
import '../../domain/controllers/auth_controller.dart';
import '../../domain/controllers/persisted_users_controller.dart';
import '../widgets/auth_button.dart';
import '../widgets/auth_outlined_button.dart';
import '../widgets/auth_text_button.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/gradient_decoration.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  bool obscurePassword = true;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) {
    final bool isIos = Theme.of(context).platform == TargetPlatform.iOS;
    final isPersisted = ref.watch(isPersistedFlowProvider);
    print('$isPersisted');

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GradientDecoration(
        child: Padding(
          padding: const EdgeInsets.all(xsSize),
          child: Column(
            children: [
              if (isPersisted.hasValue && isPersisted.value!)
                CustomAppBar(
                  buttonLeft: CustomBackButton(onPressed: context.pop),
                )
              else
                xlSeparator,
              const Text(
                'English',
                style: TextStyle(
                  fontSize: smallText,
                ),
              ),
              xlSeparator,
              Image.asset(igLogoPath),
              xlSeparator,
              AuthTextField(
                textController: _emailController,
                labelText: 'Username, email adress or phone number',
                suffixIcon: IconButton(
                  onPressed: () {
                    _emailController.value = TextEditingValue.empty;
                  },
                  icon: const Icon(
                    Icons.close,
                    size: 30,
                    color: Color(0xff6f7a85),
                  ),
                ),
              ),
              xsSeparator,
              AuthTextField(
                textController: _passwordController,
                labelText: 'Password',
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      obscurePassword = !obscurePassword;
                    });
                  },
                  icon: Icon(
                    obscurePassword
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    size: 30,
                    color: const Color(0xff6f7a85),
                  ),
                ),
                iconVisibility: obscurePassword,
              ),
              xsSeparator,
              Consumer(
                builder: (final context, final ref, final child) => AuthButton(
                  text: 'Log in',
                  callback: () async {
                    await ref.read(authControllerProvider).signIn(
                          _emailController.text,
                          _passwordController.text,
                        );
                  },
                ),
              ),
              xsSeparator,
              AuthTextButton(
                text: 'Forgotten password?',
                callback: () {},
              ),
              const Expanded(
                child: SizedBox(),
              ),
              AuthOutlinedButton(
                text: 'Create a new account',
                callback: () async {
                  if (isPersisted.hasValue && isPersisted.value!) {
                    const PersistedCompleteNameRoute().pushReplacement(context);
                  } else {
                    await const CompleteNameRoute().push(context);
                  }
                },
                textColor: const Color(0xff0665bd),
                borderColor: const Color(0xff2169b1),
              ),
              xsSeparator,
              Image.asset(
                metaLogoPath,
                width: 64,
              ),
              if (isIos) xsSeparator,
            ],
          ),
        ),
      ),
    );
  }
}
