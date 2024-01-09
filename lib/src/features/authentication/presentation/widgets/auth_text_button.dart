import 'package:flutter/material.dart';

import '../../../../constants/exports.dart';

class AuthTextButton extends StatelessWidget {
  const AuthTextButton({
    required this.text,
    required this.callback,
    this.color,
    this.fontWeight = FontWeight.w500,
    super.key,
  });

  final String text;
  final Color? color;
  final FontWeight? fontWeight;
  final VoidCallback callback;

  @override
  Widget build(final BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: callback,
      child: SizedBox(
        height: mediumSize,
        child: Text(
          text,
          style: TextStyle(
            color: color ?? textColor,
            fontSize: smallText,
            fontWeight: fontWeight,
          ),
        ),
      ),
    );
  }
}
