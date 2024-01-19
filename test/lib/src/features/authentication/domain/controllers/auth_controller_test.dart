import 'package:flutter_test/flutter_test.dart';
import 'package:instagram_copy/src/features/authentication/domain/controllers/auth_controller.dart';
import 'package:instagram_copy/src/features/authentication/domain/models/auth_field.dart';
import 'package:instagram_copy/src/features/authentication/domain/models/signup_form.dart';
import 'package:instagram_copy/src/features/authentication/domain/models/user.dart';
import 'package:instagram_copy/src/features/authentication/services/auth_service.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../../../test_utils.dart';
import 'auth_controller_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<AuthService>(),
  MockSpec<SignUpFormModel>(),
  MockSpec<AuthFieldItem>(),
])
void main() {
  group(
    'Auth Controller Test Group',
    () {
      late MockAuthService mockAuthService;
      late MockSignUpFormModel mockSignUpFormModel;
      setUp(
        () {
          mockAuthService = MockAuthService();
          mockSignUpFormModel = MockSignUpFormModel();
        },
      );

      test('Sign In test', () async {
        final sut = AuthController(
          mockAuthService,
          mockSignUpFormModel,
        );

        await sut.signIn('testemail@gmail.com', 'password');

        verify(mockAuthService.signIn('testemail@gmail.com', 'password'))
            .called(1);
        verifyNoMoreInteractions(mockAuthService);
        verifyNoMoreInteractions(mockSignUpFormModel);
      });

      test('Sign In With Token test', () async {
        final user = UserModel(
          uid: 'testuid',
          emailVerified: false,
          email: 'testemail@gmail.com',
        );
        final sut = AuthController(
          mockAuthService,
          mockSignUpFormModel,
        );

        await sut.signInWithToken(user);

        verify(mockAuthService.signInWithToken(user)).called(1);
        verifyNoMoreInteractions(mockAuthService);
        verifyNoMoreInteractions(mockSignUpFormModel);
      });

      test('Sign Up With Email test', () async {
        final mockEmailField = MockAuthFieldItem<String>();
        final mockPasswordField = MockAuthFieldItem<String>();
        final sut = AuthController(
          mockAuthService,
          mockSignUpFormModel,
        );

        when(mockSignUpFormModel.email).thenReturn(mockEmailField);
        when(mockSignUpFormModel.password).thenReturn(mockPasswordField);
        when(mockEmailField.fieldValue).thenReturn('testemail@gmail.com');
        when(mockPasswordField.fieldValue).thenReturn('password');

        await sut.signUpWithEmail();

        verify(
          mockAuthService.signUpWithEmail(
            'testemail@gmail.com',
            'password',
            mockSignUpFormModel,
          ),
        ).called(1);
        verify(mockEmailField.fieldValue).called(1);
        verify(mockPasswordField.fieldValue).called(1);
        verify(mockSignUpFormModel.email).called(1);
        verify(mockSignUpFormModel.password).called(1);
        verifyNoMoreInteractions(mockAuthService);
        verifyNoMoreInteractions(mockSignUpFormModel);
        verifyNoMoreInteractions(mockEmailField);
        verifyNoMoreInteractions(mockPasswordField);
      });

      test('Reset Password test', () async {
        final sut = AuthController(
          mockAuthService,
          mockSignUpFormModel,
        );

        await sut.resetPassword('testemail@gmail.com');

        verify(mockAuthService.resetPassword('testemail@gmail.com')).called(1);
        verifyNoMoreInteractions(mockAuthService);
      });

      test('Sign Out test', () async {
        final sut = AuthController(
          mockAuthService,
          mockSignUpFormModel,
        );

        await sut.signOut();

        verify(mockAuthService.signOut()).called(1);
        verifyNoMoreInteractions(mockAuthService);
      });

      test('Delete Account test', () async {
        final sut = AuthController(
          mockAuthService,
          mockSignUpFormModel,
        );

        await sut.deleteAccount();

        verify(mockAuthService.deleteAccount()).called(1);
        verifyNoMoreInteractions(mockAuthService);
      });

      test('Auth Controller Provider exists', () async {
        final container = createContainer()
          ..listen(authControllerProvider, (_, __) {});

        expect(container.exists(authControllerProvider), true);
      });
    },
  );
}
