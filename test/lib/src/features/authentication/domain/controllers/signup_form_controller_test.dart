// ignore_for_file: unused_local_variable

import 'package:flutter_test/flutter_test.dart';
import 'package:instagram_copy/src/features/authentication/domain/controllers/signup_form_controller.dart';
import 'package:instagram_copy/src/features/authentication/domain/models/auth_field_errors.dart';

import '../../../../../../test_utils.dart';

void main() {
  group('Sign Up Form Controller Test Group', () {
    test('On Complete Name Change', () {
      final container = createContainer();
      final sutListener =
          container.listen(signUpFormControllerProvider, (_, __) {});

      expect(
        container.read(signUpFormControllerProvider).completeName.fieldValue,
        '',
      );
      container
          .read(signUpFormControllerProvider.notifier)
          .onCompleteNameChange('test');

      expect(
        container.read(signUpFormControllerProvider).completeName.fieldValue,
        'test',
      );
      expect(
        container.read(signUpFormControllerProvider).completeName.error,
        null,
      );
    });

    test('On Password Change', () {
      final container = createContainer();
      final sutListener =
          container.listen(signUpFormControllerProvider, (_, __) {});

      expect(
        container.read(signUpFormControllerProvider).password.fieldValue,
        '',
      );
      container
          .read(signUpFormControllerProvider.notifier)
          .onPasswordChange('test');

      expect(
        container.read(signUpFormControllerProvider).password.fieldValue,
        'test',
      );
      expect(
        container.read(signUpFormControllerProvider).password.error,
        null,
      );
    });

    test('On Birthday Change', () {
      final container = createContainer();
      final sutListener =
          container.listen(signUpFormControllerProvider, (_, __) {});

      expect(
        container.read(signUpFormControllerProvider).birthday.fieldValue,
        isA<DateTime>(),
      );
      container
          .read(signUpFormControllerProvider.notifier)
          .onBirthdayChange(DateTime(2000));

      expect(
        container.read(signUpFormControllerProvider).birthday.fieldValue,
        DateTime(2000),
      );
      expect(
        container.read(signUpFormControllerProvider).birthday.error,
        null,
      );
    });

    test('On Username Change', () async {
      final container = createContainer();
      final sutListener =
          container.listen(signUpFormControllerProvider, (_, __) {});

      expect(
        container.read(signUpFormControllerProvider).username.fieldValue,
        '',
      );
      await container
          .read(signUpFormControllerProvider.notifier)
          .onUsernameChange('test');

      expect(
        container.read(signUpFormControllerProvider).username.fieldValue,
        'test',
      );
      expect(
        container.read(signUpFormControllerProvider).username.error,
        null,
      );
    });

    test('On Phone Number Change', () {
      final container = createContainer();
      final sutListener =
          container.listen(signUpFormControllerProvider, (_, __) {});

      expect(
        container.read(signUpFormControllerProvider).phoneNumber.fieldValue,
        '',
      );
      container
          .read(signUpFormControllerProvider.notifier)
          .onPhoneNumberChange('074811');

      expect(
        container.read(signUpFormControllerProvider).phoneNumber.fieldValue,
        '074811',
      );
      expect(
        container.read(signUpFormControllerProvider).phoneNumber.error,
        null,
      );
    });

    test('On Email Change', () {
      final container = createContainer();
      final sutListener =
          container.listen(signUpFormControllerProvider, (_, __) {});

      expect(
        container.read(signUpFormControllerProvider).email.fieldValue,
        '',
      );
      container
          .read(signUpFormControllerProvider.notifier)
          .onEmailChange('testemail@gmail.com');

      expect(
        container.read(signUpFormControllerProvider).email.fieldValue,
        'testemail@gmail.com',
      );
      expect(
        container.read(signUpFormControllerProvider).email.error,
        null,
      );
    });

    test('Is Valid Complete Name', () {
      final container = createContainer();
      final sutListener =
          container.listen(signUpFormControllerProvider, (_, __) {});

      expect(
        container.read(signUpFormControllerProvider).completeName.error,
        null,
      );

      container
          .read(signUpFormControllerProvider.notifier)
          .onCompleteNameChange('testcompletename');

      final result = container
          .read(signUpFormControllerProvider.notifier)
          .isValidCompleteName();

      expect(result, true);
    });

    test('Is Valid Password returns true', () {
      final container = createContainer();
      final sutListener =
          container.listen(signUpFormControllerProvider, (_, __) {});

      expect(
        container.read(signUpFormControllerProvider).password.error,
        null,
      );

      container
          .read(signUpFormControllerProvider.notifier)
          .onPasswordChange('testpassword');

      final result = container
          .read(signUpFormControllerProvider.notifier)
          .isValidPassword();

      expect(result, true);
      expect(container.read(signUpFormControllerProvider).password.error, null);
    });

    test('Is Valid Password returns false because of empty password', () {
      final container = createContainer();
      final sutListener =
          container.listen(signUpFormControllerProvider, (_, __) {});

      expect(
        container.read(signUpFormControllerProvider).password.error,
        null,
      );

      container
          .read(signUpFormControllerProvider.notifier)
          .onPasswordChange('');

      final result = container
          .read(signUpFormControllerProvider.notifier)
          .isValidPassword();

      expect(result, false);
      expect(
        container.read(signUpFormControllerProvider).password.error,
        isA<AuthFieldError>(),
      );
      expect(
        container.read(signUpFormControllerProvider).password.error!.errorText,
        AuthFieldError.noPassword().errorText,
      );
    });

    test('Is Valid Password returns false because of password too short', () {
      final container = createContainer();
      final sutListener =
          container.listen(signUpFormControllerProvider, (_, __) {});

      expect(
        container.read(signUpFormControllerProvider).password.error,
        null,
      );

      container
          .read(signUpFormControllerProvider.notifier)
          .onPasswordChange('pass');

      final result = container
          .read(signUpFormControllerProvider.notifier)
          .isValidPassword();

      expect(result, false);
      expect(
        container.read(signUpFormControllerProvider).password.error,
        isA<AuthFieldError>(),
      );
      expect(
        container.read(signUpFormControllerProvider).password.error!.errorText,
        AuthFieldError.shortPassword().errorText,
      );
    });

    test('Is Valid Birthday returns true', () {
      final container = createContainer();
      final sutListener =
          container.listen(signUpFormControllerProvider, (_, __) {});

      expect(
        container.read(signUpFormControllerProvider).birthday.error,
        null,
      );

      container
          .read(signUpFormControllerProvider.notifier)
          .onBirthdayChange(DateTime(2000));

      final result = container
          .read(signUpFormControllerProvider.notifier)
          .isValidBirhday();

      expect(result, true);
      expect(
        container.read(signUpFormControllerProvider).birthday.error,
        null,
      );
    });

    test('Is Valid Birthday returns false', () {
      final container = createContainer();
      final sutListener =
          container.listen(signUpFormControllerProvider, (_, __) {});

      expect(
        container.read(signUpFormControllerProvider).birthday.error,
        null,
      );

      container
          .read(signUpFormControllerProvider.notifier)
          .onBirthdayChange(DateTime.now());

      final result = container
          .read(signUpFormControllerProvider.notifier)
          .isValidBirhday();

      expect(result, false);
      expect(
        container.read(signUpFormControllerProvider).birthday.error,
        isA<AuthFieldError>(),
      );
      expect(
        container.read(signUpFormControllerProvider).birthday.error!.errorText,
        AuthFieldError.tooYoung().errorText,
      );
    });

    // TODO(isValidUsernameTest): Test it later
    test('Is Valid Username returns true', () {
      final container = createContainer();
      final sutListener =
          container.listen(signUpFormControllerProvider, (_, __) {});

      // expect(
      //   container.read(signUpFormControllerProvider).birthday.error,
      //   null,
      // );

      // container
      //     .read(signUpFormControllerProvider.notifier)
      //     .onBirthdayChange(DateTime.now());

      // final result = container
      //     .read(signUpFormControllerProvider.notifier)
      //     .isValidBirhday();

      // expect(result, false);
      // expect(
      //   container.read(signUpFormControllerProvider).birthday.error,
      //   isA<AuthFieldError>(),
      // );
      // expect(
      //   container.read(signUpFormControllerProvider).birthday.error!.errorText,
      //   AuthFieldError.tooYoung().errorText,
      // );
    });

    // TODO(ShouldValidateUsernameTest): test later
    test('Should Validate Username return true', () async {
      final container = createContainer();
      final sutListener =
          container.listen(signUpFormControllerProvider, (_, __) {});

      expect(
        container.read(signUpFormControllerProvider).username.error,
        null,
      );

      await container
          .read(signUpFormControllerProvider.notifier)
          .onUsernameChange('usernametest');

      final result = container
          .read(signUpFormControllerProvider.notifier)
          .shouldValidateUsername();
      expect(result, true);
    });

    test('Is Valid Phone Number returns true', () {
      final container = createContainer();
      final sutListener =
          container.listen(signUpFormControllerProvider, (_, __) {});

      expect(
        container.read(signUpFormControllerProvider).phoneNumber.error,
        null,
      );

      container
          .read(signUpFormControllerProvider.notifier)
          .onPhoneNumberChange('074113412');

      final result = container
          .read(signUpFormControllerProvider.notifier)
          .isValidPhoneNumber();

      expect(result, true);
      expect(
        container.read(signUpFormControllerProvider).phoneNumber.error,
        null,
      );
    });

    test('Is Valid Phone Number returns false', () {
      final container = createContainer();
      final sutListener =
          container.listen(signUpFormControllerProvider, (_, __) {});

      expect(
        container.read(signUpFormControllerProvider).phoneNumber.error,
        null,
      );

      container
          .read(signUpFormControllerProvider.notifier)
          .onPhoneNumberChange('0741');

      final result = container
          .read(signUpFormControllerProvider.notifier)
          .isValidPhoneNumber();

      expect(result, false);
      expect(
        container.read(signUpFormControllerProvider).phoneNumber.error,
        isA<AuthFieldError>(),
      );
      expect(
        container
            .read(signUpFormControllerProvider)
            .phoneNumber
            .error!
            .errorText,
        AuthFieldError(errorText: 'Phone number is not valid').errorText,
      );
    });

    test('Is Valid Email returns true', () {
      final container = createContainer();
      final sutListener =
          container.listen(signUpFormControllerProvider, (_, __) {});

      expect(
        container.read(signUpFormControllerProvider).email.error,
        null,
      );

      container
          .read(signUpFormControllerProvider.notifier)
          .onEmailChange('testemail@gmail.com');

      final result =
          container.read(signUpFormControllerProvider.notifier).isValidEmail();

      expect(result, true);
      expect(
        container.read(signUpFormControllerProvider).email.error,
        null,
      );
    });

    test('Is Valid Email returns false because is empty', () {
      final container = createContainer();
      final sutListener =
          container.listen(signUpFormControllerProvider, (_, __) {});

      expect(
        container.read(signUpFormControllerProvider).email.error,
        null,
      );

      container.read(signUpFormControllerProvider.notifier).onEmailChange('');

      final result =
          container.read(signUpFormControllerProvider.notifier).isValidEmail();

      expect(result, false);
      expect(
        container.read(signUpFormControllerProvider).email.error,
        isA<AuthFieldError>(),
      );
      expect(
        container.read(signUpFormControllerProvider).email.error!.errorText,
        AuthFieldError.noEmail().errorText,
      );
    });

    test('Is Valid Email returns false because is invalid', () {
      final container = createContainer();
      final sutListener =
          container.listen(signUpFormControllerProvider, (_, __) {});

      expect(
        container.read(signUpFormControllerProvider).email.error,
        null,
      );

      container
          .read(signUpFormControllerProvider.notifier)
          .onEmailChange('test@');

      final result =
          container.read(signUpFormControllerProvider.notifier).isValidEmail();

      expect(result, false);
      expect(
        container.read(signUpFormControllerProvider).email.error,
        isA<AuthFieldError>(),
      );
      expect(
        container.read(signUpFormControllerProvider).email.error!.errorText,
        AuthFieldError.invalidEmail().errorText,
      );
    });

    test('Reset password', () {
      final container = createContainer();
      final sutListener =
          container.listen(signUpFormControllerProvider, (_, __) {});

      container
          .read(signUpFormControllerProvider.notifier)
          .onPasswordChange('testpass');

      expect(
        container.read(signUpFormControllerProvider).password.fieldValue,
        'testpass',
      );

      container.read(signUpFormControllerProvider.notifier).resetPassword();

      expect(
        container.read(signUpFormControllerProvider).password.fieldValue,
        '',
      );
    });

    test('Reset Birthday', () {
      final container = createContainer();
      final sutListener =
          container.listen(signUpFormControllerProvider, (_, __) {});

      container
          .read(signUpFormControllerProvider.notifier)
          .onBirthdayChange(DateTime(2000));

      expect(
        container.read(signUpFormControllerProvider).birthday.fieldValue,
        equals(DateTime(2000)),
      );

      container.read(signUpFormControllerProvider.notifier).resetBirthday();

      expect(
        container.read(signUpFormControllerProvider).birthday.fieldValue,
        isA<DateTime>(),
      );
    });

    test('Reset Username', () async {
      final container = createContainer();
      final sutListener =
          container.listen(signUpFormControllerProvider, (_, __) {});

      await container
          .read(signUpFormControllerProvider.notifier)
          .onUsernameChange('test');

      expect(
        container.read(signUpFormControllerProvider).username.fieldValue,
        'test',
      );

      container.read(signUpFormControllerProvider.notifier).resetUsername();

      expect(
        container.read(signUpFormControllerProvider).username.fieldValue,
        '',
      );
    });

    test('Reset Phone Number', () {
      final container = createContainer();
      final sutListener =
          container.listen(signUpFormControllerProvider, (_, __) {});

      container
          .read(signUpFormControllerProvider.notifier)
          .onPhoneNumberChange('0748');

      expect(
        container.read(signUpFormControllerProvider).phoneNumber.fieldValue,
        '0748',
      );

      container.read(signUpFormControllerProvider.notifier).resetPhoneNumber();

      expect(
        container.read(signUpFormControllerProvider).phoneNumber.fieldValue,
        '',
      );
    });

    test('Reset Email', () {
      final container = createContainer();
      final sutListener =
          container.listen(signUpFormControllerProvider, (_, __) {});

      container
          .read(signUpFormControllerProvider.notifier)
          .onEmailChange('testemail@gmail.com');

      expect(
        container.read(signUpFormControllerProvider).email.fieldValue,
        'testemail@gmail.com',
      );

      container.read(signUpFormControllerProvider.notifier).resetEmail();

      expect(
        container.read(signUpFormControllerProvider).email.fieldValue,
        '',
      );
    });
  });
}
