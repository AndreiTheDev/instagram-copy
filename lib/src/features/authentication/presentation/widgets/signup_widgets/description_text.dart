import 'package:flutter/material.dart';

import '../../../../../constants/exports.dart';

class DescriptionText extends StatelessWidget {
  const DescriptionText({required this.text, super.key});

  final String text;

  @override
  Widget build(final BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: const TextStyle(fontSize: smallText),
      ),
    );
  }
}
