// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter_test/flutter_test.dart';
import 'package:instagram_copy/src/features/authentication/domain/models/auth_field_errors.dart';

void main() {
  group('Auth Field Errors Test Group', () {
    test('Auth Field Error creation with custom text', () {
      final sut = AuthFieldError(errorText: 'testError');
      expect(sut, isA<AuthFieldError>());
      expect(sut.errorText, 'testError');
    });

    test('Auth Field Error creation with no password', () {
      final sut = AuthFieldError.noPassword();
      expect(sut, isA<AuthFieldError>());
      expect(sut.errorText, "Password field can't be left uncompleted");
    });

    test('Auth Field Error creation with short password', () {
      final sut = AuthFieldError.shortPassword();
      expect(sut, isA<AuthFieldError>());
      expect(
        sut.errorText,
        'This password is too short. Create a longer password.',
      );
    });

    test('Auth Field Error creation with too young', () {
      final sut = AuthFieldError.tooYoung();
      expect(sut, isA<AuthFieldError>());
      expect(
        sut.errorText,
        'It seems like you introduced the wrong details. Please make sure you use your real birthday.',
      );
    });

    test('Auth Field Error creation with no username', () {
      final sut = AuthFieldError.noUsername();
      expect(sut, isA<AuthFieldError>());
      expect(
        sut.errorText,
        'To continue, please pick an username.',
      );
    });

    test('Auth Field Error creation with username taken', () {
      const String username = 'testUsername';
      final sut = AuthFieldError.usernameTaken(username);
      expect(sut, isA<AuthFieldError>());
      expect(
        sut.errorText,
        'The username $username is not available.',
      );
    });

    test('Auth Field Error creation with no email', () {
      final sut = AuthFieldError.noEmail();
      expect(sut, isA<AuthFieldError>());
      expect(
        sut.errorText,
        'E-mail is mandatory.',
      );
    });

    test('Auth Field Error creation with invalid email', () {
      final sut = AuthFieldError.invalidEmail();
      expect(sut, isA<AuthFieldError>());
      expect(
        sut.errorText,
        'Please insert a valid email.',
      );
    });
  });
}
