import 'package:flutter/material.dart';

import '../../../../../constants/exports.dart';

class HeadlineText extends StatelessWidget {
  const HeadlineText({required this.text, super.key});

  final String text;

  @override
  Widget build(final BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: const TextStyle(
          fontSize: mediumText,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
