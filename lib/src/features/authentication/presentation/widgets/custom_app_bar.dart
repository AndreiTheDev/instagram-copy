import 'package:flutter/material.dart';

import '../../../../constants/exports.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({this.buttonLeft, this.buttonRight, super.key});

  final Widget? buttonLeft;
  final Widget? buttonRight;

  @override
  Widget build(final BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: mediumSize, bottom: xsSize),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buttonLeft ??
              const SizedBox(
                width: 1,
              ),
          buttonRight ??
              const SizedBox(
                width: 1,
              ),
        ],
      ),
    );
  }
}
