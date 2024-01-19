import 'package:flutter/material.dart';

import '../../../../constants/exports.dart';

class GradientDecoration extends StatelessWidget {
  const GradientDecoration({required this.child, super.key});

  final Widget child;

  @override
  Widget build(final BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            loginGradienYellow,
            loginGradienRed,
            loginGradienDarkBlue,
            loginGradienLightBlue,
          ],
          begin: Alignment(-1.2, -0.6),
          end: Alignment(1, -0.5),
          stops: [0.07, 0.20, 0.5, 1],
        ),
      ),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomRight,
            end: Alignment(0.1, 0.6),
            colors: [
              loginGradienGreen,
              Color.fromARGB(0, 255, 255, 255),
            ],
            stops: [0.7, 1],
          ),
        ),
        child: child,
      ),
    );
  }
}
