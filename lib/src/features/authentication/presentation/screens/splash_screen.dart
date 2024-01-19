import 'package:flutter/material.dart';

import '../widgets/gradient_decoration.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    return const Scaffold(
      body: GradientDecoration(
        child: Center(
          child: CircularProgressIndicator(
            strokeWidth: 2,
          ),
        ),
      ),
    );
  }
}
