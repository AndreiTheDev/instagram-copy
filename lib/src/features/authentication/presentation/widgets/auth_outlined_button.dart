import 'package:flutter/material.dart';

import '../../../../constants/exports.dart';

class AuthOutlinedButton extends StatelessWidget {
  const AuthOutlinedButton({
    required this.text,
    required this.callback,
    this.textColor = const Color(0xff1c262f),
    this.borderColor = const Color(0xffcad1db),
    super.key,
  });

  final String text;
  final Color textColor;
  final Color borderColor;
  final VoidCallback callback;

  @override
  Widget build(final BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 42,
      child: OutlinedButton(
        onPressed: callback,
        style: OutlinedButton.styleFrom(
          foregroundColor: const Color.fromARGB(0, 255, 255, 255),
          side: BorderSide(
            color: borderColor,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(largeSize),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: smallText,
          ),
        ),
      ),
    );
  }
}
