import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:instagram_copy/src/features/core/error_handling/error_codes.dart';
import 'package:instagram_copy/src/features/core/error_handling/error_state.dart';

void main() {
  group('Error states Test Group', () {
    group('Dialog Error Group', () {
      test('Dialog error constructor', () {
        final sut = DialogError(
          title: 'testtitle',
          code: 'testcode',
          description: 'testdescription',
        );

        expect(sut, isA<DialogError>());
        expect(sut.title, 'testtitle');
        expect(sut.code, 'testcode');
        expect(sut.description, 'testdescription');
        expect(sut.leftButton, null);
        expect(sut.rightButton, isA<Widget>());
      });

      test('Dialog Init From Firebase Auth Error emailExistsCode', () {
        final sut =
            DialogError.initFromFirebaseAuthError(code: emailExistsCode);

        expect(sut, isA<DialogError>());
        expect(sut.title, emailExistsMessage);
        expect(sut.code, emailExistsCode);
        expect(sut.description, emailExistsDescription);
        expect(sut.leftButton, null);
        expect(sut.rightButton, isA<Widget>());
      });

      test('Dialog Init From Firebase Auth Error internalErrorCode', () {
        final sut =
            DialogError.initFromFirebaseAuthError(code: internalErrorCode);

        expect(sut, isA<DialogError>());
        expect(sut.title, internalErrorMessage);
        expect(sut.code, internalErrorCode);
        expect(sut.description, internalErrorDescription);
        expect(sut.leftButton, null);
        expect(sut.rightButton, isA<Widget>());
      });
      test('Dialog Init From Firebase Auth Error invalidCredentialCode', () {
        final sut =
            DialogError.initFromFirebaseAuthError(code: invalidCredentialCode);

        expect(sut, isA<DialogError>());
        expect(sut.title, invalidCredentialMessage);
        expect(sut.code, invalidCredentialCode);
        expect(sut.description, invalidCredentialDescription);
        expect(sut.leftButton, null);
        expect(sut.rightButton, isA<Widget>());
      });
      test('Dialog Init From Firebase Auth Error invalidPasswordCode', () {
        final sut =
            DialogError.initFromFirebaseAuthError(code: invalidPasswordCode);

        expect(sut, isA<DialogError>());
        expect(sut.title, invalidPasswordMessage);
        expect(sut.code, invalidPasswordCode);
        expect(sut.description, invalidPasswordDescription);
        expect(sut.leftButton, null);
        expect(sut.rightButton, isA<Widget>());
      });
      test('Dialog Init From Firebase Auth Error userDisabledCode', () {
        final sut =
            DialogError.initFromFirebaseAuthError(code: userDisabledCode);

        expect(sut, isA<DialogError>());
        expect(sut.title, userDisabledMessage);
        expect(sut.code, userDisabledCode);
        expect(sut.description, userDisabledDescription);
        expect(sut.leftButton, null);
        expect(sut.rightButton, isA<Widget>());
      });
      test('Dialog Init From Firebase Auth Error userNotFoundCode', () {
        final sut =
            DialogError.initFromFirebaseAuthError(code: userNotFoundCode);

        expect(sut, isA<DialogError>());
        expect(sut.title, userNotFoundMessage);
        expect(sut.code, userNotFoundCode);
        expect(sut.description, userNotFoundDescription);
        expect(sut.leftButton, null);
        expect(sut.rightButton, isA<Widget>());
      });
      test('Dialog Init From Firebase Auth Error wrongPasswordCode', () {
        final sut =
            DialogError.initFromFirebaseAuthError(code: wrongPasswordCode);

        expect(sut, isA<DialogError>());
        expect(sut.title, wrongPasswordMessage);
        expect(sut.code, wrongPasswordCode);
        expect(sut.description, wrongPasswordDescription);
        expect(sut.leftButton, null);
        expect(sut.rightButton, isA<Widget>());
      });
      test('Dialog Init From Firebase Auth Error userCancelCode', () {
        final sut = DialogError.initFromFirebaseAuthError(code: userCancelCode);

        expect(sut, isA<DialogError>());
        expect(sut.title, userCancelCode);
        expect(sut.code, userCancelCode);
        expect(sut.description, userCancelCode);
        expect(sut.leftButton, null);
        expect(sut.rightButton, isA<Widget>());
      });
      test('Dialog Init From Firebase Auth Error userNotExistsCode', () {
        final sut =
            DialogError.initFromFirebaseAuthError(code: userNotExistsCode);

        expect(sut, isA<DialogError>());
        expect(sut.title, userNotExistsMessage);
        expect(sut.code, userNotExistsCode);
        expect(sut.description, userNotExistsDescription);
        expect(sut.leftButton, null);
        expect(sut.rightButton, isA<Widget>());
      });
      test('Dialog Init From Firebase Auth Error noUserDataCode', () {
        final sut = DialogError.initFromFirebaseAuthError(code: noUserDataCode);

        expect(sut, isA<DialogError>());
        expect(sut.title, noUserDataMessage);
        expect(sut.code, noUserDataCode);
        expect(sut.description, noUserDataDescription);
        expect(sut.leftButton, null);
        expect(sut.rightButton, isA<Widget>());
      });
      test('Dialog Init From Firebase Auth Error unknownErrorCode', () {
        final sut =
            DialogError.initFromFirebaseAuthError(code: unknownErrorCode);

        expect(sut, isA<DialogError>());
        expect(sut.title, unknownErrorMessage);
        expect(sut.code, unknownErrorCode);
        expect(sut.description, unknownErrorDescription);
        expect(sut.leftButton, null);
        expect(sut.rightButton, isA<Widget>());
      });
    });

    group('SnackBar Error Group', () {
      test('SnackBar error constructor', () {
        final sut = SnackBarError(
          title: 'testtitle',
          code: 'testcode',
        );

        expect(sut, isA<SnackBarError>());
        expect(sut.title, 'testtitle');
        expect(sut.code, 'testcode');
      });

      test('SnackBar Init From Firebase Auth Error emailExistsCode', () {
        final sut =
            SnackBarError.initFromFirebaseAuthError(code: emailExistsCode);

        expect(sut, isA<SnackBarError>());
        expect(sut.title, emailExistsMessage);
        expect(sut.code, emailExistsCode);
      });

      test('SnackBar Init From Firebase Auth Error internalErrorCode', () {
        final sut =
            SnackBarError.initFromFirebaseAuthError(code: internalErrorCode);

        expect(sut, isA<SnackBarError>());
        expect(sut.title, internalErrorMessage);
        expect(sut.code, internalErrorCode);
      });
      test('SnackBar Init From Firebase Auth Error invalidCredentialCode', () {
        final sut = SnackBarError.initFromFirebaseAuthError(
            code: invalidCredentialCode);

        expect(sut, isA<SnackBarError>());
        expect(sut.title, invalidCredentialMessage);
        expect(sut.code, invalidCredentialCode);
      });
      test('SnackBar Init From Firebase Auth Error invalidPasswordCode', () {
        final sut =
            SnackBarError.initFromFirebaseAuthError(code: invalidPasswordCode);

        expect(sut, isA<SnackBarError>());
        expect(sut.title, invalidPasswordMessage);
        expect(sut.code, invalidPasswordCode);
      });
      test('SnackBar Init From Firebase Auth Error userDisabledCode', () {
        final sut =
            SnackBarError.initFromFirebaseAuthError(code: userDisabledCode);

        expect(sut, isA<SnackBarError>());
        expect(sut.title, userDisabledMessage);
        expect(sut.code, userDisabledCode);
      });
      test('SnackBar Init From Firebase Auth Error userNotFoundCode', () {
        final sut =
            SnackBarError.initFromFirebaseAuthError(code: userNotFoundCode);

        expect(sut, isA<SnackBarError>());
        expect(sut.title, userNotFoundMessage);
        expect(sut.code, userNotFoundCode);
      });
      test('SnackBar Init From Firebase Auth Error wrongPasswordCode', () {
        final sut =
            SnackBarError.initFromFirebaseAuthError(code: wrongPasswordCode);

        expect(sut, isA<SnackBarError>());
        expect(sut.title, wrongPasswordMessage);
        expect(sut.code, wrongPasswordCode);
      });
      test('SnackBar Init From Firebase Auth Error userCancelCode', () {
        final sut =
            SnackBarError.initFromFirebaseAuthError(code: userCancelCode);

        expect(sut, isA<SnackBarError>());
        expect(sut.title, userCancelCode);
        expect(sut.code, userCancelCode);
      });
      test('SnackBar Init From Firebase Auth Error userNotExistsCode', () {
        final sut =
            SnackBarError.initFromFirebaseAuthError(code: userNotExistsCode);

        expect(sut, isA<SnackBarError>());
        expect(sut.title, userNotExistsMessage);
        expect(sut.code, userNotExistsCode);
      });
      test('SnackBar Init From Firebase Auth Error noUserDataCode', () {
        final sut =
            SnackBarError.initFromFirebaseAuthError(code: noUserDataCode);

        expect(sut, isA<SnackBarError>());
        expect(sut.title, noUserDataMessage);
        expect(sut.code, noUserDataCode);
      });
      test('SnackBar Init From Firebase Auth Error unknownErrorCode', () {
        final sut =
            SnackBarError.initFromFirebaseAuthError(code: unknownErrorCode);

        expect(sut, isA<SnackBarError>());
        expect(sut.title, unknownErrorMessage);
        expect(sut.code, unknownErrorCode);
      });
    });
  });
}
