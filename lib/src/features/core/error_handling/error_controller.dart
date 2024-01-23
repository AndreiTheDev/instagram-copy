import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../constants/exports.dart';
import 'error_state.dart';

part 'error_controller.g.dart';

@riverpod
class ErrorController extends _$ErrorController {
  @override
  ErrorState? build() {
    return null;
  }

  void setDialogError(
    final String code, [
    final Widget? leftButton,
    final Widget? rightButton,
  ]) {
    state = DialogError.initFromFirebaseAuthError(
      code: code,
      leftButton: leftButton,
      rightButton: rightButton,
    );
  }

  void setSnackBarError(
    final String code,
  ) {
    state = SnackBarError.initFromFirebaseAuthError(
      code: code,
    );
  }
}

void errorDisplayer(final BuildContext context, final WidgetRef ref) {
  ref.listen(errorControllerProvider, (previous, next) async {
    switch (next) {
      case null:
        break;
      case DialogError():
        await displayDialog(context, next);
      case SnackBarError():
        await displaySnackbar(context, next);
    }
  });
}

Future<void> displayDialog(
  final BuildContext context,
  final DialogError error,
) async {
  return showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        child: Container(
          padding: const EdgeInsets.all(xsSize),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                error.title,
                style: const TextStyle(
                  fontSize: smallText,
                  fontWeight: FontWeight.w600,
                ),
              ),
              xsSeparator,
              if (error.description != null) Text(error.description!),
              xsSeparator,
              Align(
                alignment: Alignment.centerRight,
                child: error.leftButton,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: error.rightButton,
              ),
            ],
          ),
        ),
      );
    },
  );
}

Future<void> displaySnackbar(
  final BuildContext context,
  final SnackBarError error,
) async {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(error.title),
      backgroundColor: const Color(0xffff2222),
    ),
  );
}
