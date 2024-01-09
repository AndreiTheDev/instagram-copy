import 'package:flutter/material.dart';

import '../constants/exports.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({required this.onPressed, super.key});

  final VoidCallback onPressed;

  @override
  Widget build(final BuildContext context) {
    final isIos = Theme.of(context).platform == TargetPlatform.iOS;
    return IconButton(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(
        minHeight: largeSize,
        maxHeight: largeSize,
        minWidth: mediumSize,
        maxWidth: mediumSize,
      ),
      onPressed: onPressed,
      icon: Container(
        height: 32,
        width: 32,
        alignment: Alignment.centerLeft,
        child: isIos
            ? const Icon(Icons.arrow_back_ios)
            : const Icon(Icons.arrow_back),
      ),
    );
  }
}
