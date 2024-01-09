import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../constants/exports.dart';

class Dialogs {
  factory Dialogs.incorectPass() {
    return const IncorectPasswordDialog();
  }
}

class IncorectPasswordDialog extends StatelessWidget implements Dialogs {
  const IncorectPasswordDialog({super.key});

  @override
  Widget build(final BuildContext context) {
    return Dialog(
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: xlSize),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Incoorect password, try again.'),
            TextButton(
              onPressed: () async {
                context.pop();
              },
              child: const Text('Ok'),
            ),
          ],
        ),
      ),
    );
  }
}

class CancelSignUpDialog extends StatelessWidget implements Dialogs {
  const CancelSignUpDialog({super.key});

  @override
  Widget build(final BuildContext context) {
    return Dialog(
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: xlSize),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Do you want to stop creating an account?'),
            const Text('If you stop, all your completed steps will be deleted'),
            TextButton(
              onPressed: () async {
                context
                  ..pop()
                  ..pop();
              },
              child: const Text('Ok'),
            ),
          ],
        ),
      ),
    );
  }
}
