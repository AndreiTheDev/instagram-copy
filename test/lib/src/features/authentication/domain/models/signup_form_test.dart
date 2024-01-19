import 'package:flutter_test/flutter_test.dart';
import 'package:instagram_copy/src/features/authentication/domain/models/auth_field.dart';
import 'package:instagram_copy/src/features/authentication/domain/models/signup_form.dart';

void main() {
  group('Sign Up Form Test Group', () {
    test('Sign Up Form initial initialization', () {
      final sut = SignUpFormModel.initial();
      expect(sut, isA<SignUpFormModel>());
      expect(sut.completeName, isA<AuthFieldItem>());
      expect(sut.password, isA<AuthFieldItem>());
      expect(sut.birthday, isA<AuthFieldItem>());
      expect(sut.username, isA<AuthFieldItem>());
      expect(sut.phoneNumber, isA<AuthFieldItem>());
      expect(sut.email, isA<AuthFieldItem>());
      expect(sut.completeName.fieldValue, '');
      expect(sut.password.fieldValue, '');
      expect(sut.birthday.fieldValue, isA<DateTime>());
      expect(sut.username.fieldValue, '');
      expect(sut.phoneNumber.fieldValue, '');
      expect(sut.email.fieldValue, '');
    });

    test('Sign Up Form to json', () {
      final sut = SignUpFormModel(
        completeName: AuthFieldItem(
          fieldValue: 'nameTest',
        ),
        password: AuthFieldItem(
          fieldValue: 'passwordTest',
        ),
        birthday: AuthFieldItem(
          fieldValue: DateTime(2000),
        ),
        username: AuthFieldItem(
          fieldValue: 'usernameTest',
        ),
        phoneNumber: AuthFieldItem(
          fieldValue: '0724',
        ),
        email: AuthFieldItem(
          fieldValue: 'emailtest@gmail.com',
        ),
      );

      expect(sut.toJson(), {
        'completeName': 'nameTest',
        'birthday': '2000-01-01 00:00:00.000',
        'username': 'usernameTest',
        'phoneNumber': '0724',
        'email': 'emailtest@gmail.com',
      });
    });
  });
}
