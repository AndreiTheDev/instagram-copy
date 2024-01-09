import 'package:flutter/material.dart';
import 'signup/complete_name_form_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({this.isPersisted = false, super.key});

  final bool isPersisted;

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(final BuildContext context) {
    return const CompleteNameFormScreen();
  }
}
