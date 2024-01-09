import 'package:flutter/material.dart';

import '../../../../constants/exports.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({
    required this.text,
    required this.callback,
    this.color,
    super.key,
  });

  final String text;
  final Color? color;
  final VoidCallback callback;

  @override
  Widget build(final BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 42,
      child: ElevatedButton(
        onPressed: callback,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(largeSize),
          ),
          backgroundColor: color ?? loginBlueColor,
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: smallText),
        ),
      ),
    );
  }
}
