import 'package:flutter/material.dart';

import '../../../../constants/exports.dart';

class ErrorButton extends StatelessWidget {
  const ErrorButton({required this.onPressed, required this.text, super.key});

  final VoidCallback onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: const ButtonStyle(
        foregroundColor: MaterialStatePropertyAll<Color>(textColor),
        overlayColor: MaterialStatePropertyAll<Color>(Colors.transparent),
      ),
      child: Text(text),
    );
  }
}
