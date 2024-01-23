import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:instagram_copy/src/features/core/error_handling/error_codes.dart';
import 'package:instagram_copy/src/features/core/error_handling/error_controller.dart';
import 'package:instagram_copy/src/features/core/error_handling/error_state.dart';

import '../../../../../test_utils.dart';

void main() {
  group('Error Controller Test Group', () {
    test('Error Controller initialization', () {
      final container = createContainer();

      final sutListener = container.listen(errorControllerProvider, (_, __) {});

      expect(sutListener.read(), isNull);
    });

    test('Error Controller Set Dialog Error', () {
      final container = createContainer();

      final sutListener = container.listen(errorControllerProvider, (_, __) {});

      container
          .read(errorControllerProvider.notifier)
          .setDialogError('unknown');

      final sutValue = sutListener.read();

      final state = switch (sutValue) { DialogError() => sutValue, _ => null };

      expect(state, isA<DialogError>());
      expect(state!.code, unknownErrorCode);
      expect(state.title, unknownErrorMessage);
      expect(state.description, unknownErrorDescription);
      expect(state.leftButton, null);
      expect(state.rightButton, isA<Widget>());
    });

    test('Error Controller Set SnackBar Error', () {
      final container = createContainer();

      final sutListener = container.listen(errorControllerProvider, (_, __) {});

      container
          .read(errorControllerProvider.notifier)
          .setSnackBarError('unknown');

      final sutValue = sutListener.read();

      final state =
          switch (sutValue) { SnackBarError() => sutValue, _ => null };

      expect(state, isA<SnackBarError>());
      expect(state!.code, unknownErrorCode);
      expect(state.title, unknownErrorMessage);
    });
  });
}
