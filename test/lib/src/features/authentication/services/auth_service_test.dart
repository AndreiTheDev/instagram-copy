import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:instagram_copy/src/features/authentication/data/mobile_auth_repository.dart';
import 'package:instagram_copy/src/features/authentication/domain/models/signup_form.dart';
import 'package:instagram_copy/src/features/authentication/domain/models/user.dart';
import 'package:instagram_copy/src/features/authentication/services/auth_service.dart';
import 'package:logger/logger.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../../test_utils.dart';
import 'auth_service_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<MobileAuthRepository>(),
  MockSpec<Logger>(),
  MockSpec<SignUpFormModel>(),
  // MockSpec<User>(),
])
void main() {
  group('Auth Service Test Group', () {
    const email = 'testemail@gmail.com';
    const password = 'password';
    const uid = 'testuid';
    late MockMobileAuthRepository mockAuthRepository;
    late MockLogger mockLogger;

    setUp(() {
      mockAuthRepository = MockMobileAuthRepository();
      mockLogger = MockLogger();
    });

    test('Sign In user success', () async {
      final sut = AuthService(mockAuthRepository, mockLogger);

      await sut.signIn(email, password);

      verify(mockAuthRepository.signIn(email, password)).called(1);
      verifyNoMoreInteractions(mockAuthRepository);
    });

    test('Sign In user fail', () async {
      final sut = AuthService(mockAuthRepository, mockLogger);

      when(mockAuthRepository.signIn(email, password)).thenThrow(
        FirebaseAuthException(code: 'authError', message: 'authError'),
      );

      await sut.signIn(email, password);

      verify(mockAuthRepository.signIn(email, password)).called(1);
      verify(mockLogger.e('authError')).called(1);
      verifyNoMoreInteractions(mockAuthRepository);
      verifyNoMoreInteractions(mockLogger);
    });

    test('Sign In With Token success', () async {
      final sut = AuthService(mockAuthRepository, mockLogger);
      final userModel = UserModel(uid: uid, emailVerified: false, email: email);
      when(mockAuthRepository.generateSignInToken(uid))
          .thenAnswer((realInvocation) async => 'token');

      await sut.signInWithToken(userModel);

      verify(mockAuthRepository.generateSignInToken(uid)).called(1);
      verify(mockAuthRepository.signInWithToken('token')).called(1);
      verifyNoMoreInteractions(mockAuthRepository);
    });

    test('Sign In With Token functions fail', () async {
      final sut = AuthService(mockAuthRepository, mockLogger);
      final userModel = UserModel(uid: uid, emailVerified: false, email: email);
      when(mockAuthRepository.generateSignInToken(uid)).thenThrow(
        FirebaseFunctionsException(
          message: 'functionsError',
          code: 'functionsError',
        ),
      );

      await sut.signInWithToken(userModel);

      verify(mockAuthRepository.generateSignInToken(uid)).called(1);
      verify(mockLogger.e('functionsError')).called(1);
      verifyNever(mockAuthRepository.signInWithToken('token'));
      verifyNoMoreInteractions(mockAuthRepository);
      verifyNoMoreInteractions(mockLogger);
    });

    test('Sign In With Token auth fail', () async {
      final sut = AuthService(mockAuthRepository, mockLogger);
      final userModel = UserModel(uid: uid, emailVerified: false, email: email);
      when(mockAuthRepository.generateSignInToken(uid))
          .thenAnswer((realInvocation) async => 'token');
      when(mockAuthRepository.signInWithToken('token')).thenThrow(
        FirebaseAuthException(message: 'authError', code: 'authError'),
      );

      await sut.signInWithToken(userModel);

      verify(mockAuthRepository.generateSignInToken(uid)).called(1);
      verify(mockLogger.e('authError')).called(1);
      verify(mockAuthRepository.signInWithToken('token')).called(1);
      verifyNoMoreInteractions(mockAuthRepository);
      verifyNoMoreInteractions(mockLogger);
    });

    test('Sign Up With Email success', () async {
      final sut = AuthService(mockAuthRepository, mockLogger);
      final mockSignUpData = MockSignUpFormModel();

      when(mockSignUpData.toJson()).thenReturn({'test': 'test'});
      when(mockAuthRepository.signUpWithEmail(email, password))
          .thenAnswer((realInvocation) async => MockUser(uid: uid));

      await sut.signUpWithEmail(email, password, mockSignUpData);

      verify(mockSignUpData.toJson()).called(1);
      verify(mockAuthRepository.signUpWithEmail(email, password)).called(1);
      verify(mockAuthRepository.initFirestoreUser(uid, {'test': 'test'}))
          .called(1);
      verifyNoMoreInteractions(mockSignUpData);
      verifyNoMoreInteractions(mockAuthRepository);
    });

    test('Sign Up With Email fail with null user', () async {
      final sut = AuthService(mockAuthRepository, mockLogger);
      final mockSignUpData = MockSignUpFormModel();

      when(mockAuthRepository.signUpWithEmail(email, password))
          .thenAnswer((realInvocation) async => null);

      await sut.signUpWithEmail(email, password, mockSignUpData);

      verify(mockLogger.e('Exception: unable to authenticate')).called(1);
      verify(mockAuthRepository.signUpWithEmail(email, password)).called(1);
      verifyNever(mockAuthRepository.initFirestoreUser(any, any));
      verifyNoMoreInteractions(mockLogger);
      verifyNoMoreInteractions(mockAuthRepository);
    });

    test('Sign Up With Email fail with Firebase Auth Exception', () async {
      final sut = AuthService(mockAuthRepository, mockLogger);
      final mockSignUpData = MockSignUpFormModel();

      when(mockAuthRepository.signUpWithEmail(email, password)).thenThrow(
        FirebaseAuthException(code: 'authError', message: 'authError'),
      );

      await sut.signUpWithEmail(email, password, mockSignUpData);

      verify(mockAuthRepository.signUpWithEmail(email, password)).called(1);
      verifyNever(mockAuthRepository.initFirestoreUser(any, any));
      verify(mockLogger.e('authError')).called(1);
      verifyNoMoreInteractions(mockLogger);
      verifyNoMoreInteractions(mockAuthRepository);
    });

    test('Sign Up With Email fail with Firebase Functions Exception', () async {
      final sut = AuthService(mockAuthRepository, mockLogger);
      final mockSignUpData = MockSignUpFormModel();

      when(mockSignUpData.toJson()).thenReturn({'test': 'test'});
      when(mockAuthRepository.signUpWithEmail(email, password))
          .thenAnswer((realInvocation) async => MockUser(uid: uid));
      when(mockAuthRepository.initFirestoreUser(uid, {'test': 'test'}))
          .thenThrow(
        FirebaseFunctionsException(
          message: 'functionsError',
          code: 'functionsError',
        ),
      );

      await sut.signUpWithEmail(email, password, mockSignUpData);

      verify(mockAuthRepository.signUpWithEmail(email, password)).called(1);
      verify(mockSignUpData.toJson()).called(1);
      verify(mockAuthRepository.initFirestoreUser(uid, {'test': 'test'}))
          .called(1);
      verify(mockLogger.e('functionsError')).called(1);
      verifyNoMoreInteractions(mockSignUpData);
      verifyNoMoreInteractions(mockLogger);
      verifyNoMoreInteractions(mockAuthRepository);
    });

    test('Reset Password success', () async {
      final sut = AuthService(mockAuthRepository, mockLogger);

      await sut.resetPassword(
        email,
      );

      verify(mockAuthRepository.resetPassword(email)).called(1);
      verifyNoMoreInteractions(mockAuthRepository);
    });

    test('Reset Password fail', () async {
      final sut = AuthService(mockAuthRepository, mockLogger);

      when(mockAuthRepository.resetPassword(email)).thenThrow(
        FirebaseAuthException(code: 'authError', message: 'authError'),
      );

      await sut.resetPassword(
        email,
      );

      verify(mockAuthRepository.resetPassword(email)).called(1);
      verify(mockLogger.e('authError')).called(1);
      verifyNoMoreInteractions(mockAuthRepository);
      verifyNoMoreInteractions(mockLogger);
    });

    test('Sign Out success', () async {
      final sut = AuthService(mockAuthRepository, mockLogger);

      await sut.signOut();

      verify(mockAuthRepository.signOut()).called(1);
      verifyNoMoreInteractions(mockAuthRepository);
    });

    test('Sign Out fail', () async {
      final sut = AuthService(mockAuthRepository, mockLogger);

      when(mockAuthRepository.signOut()).thenThrow(
        FirebaseAuthException(code: 'authError', message: 'authError'),
      );

      await sut.signOut();

      verify(mockAuthRepository.signOut()).called(1);
      verify(mockLogger.e('authError')).called(1);
      verifyNoMoreInteractions(mockAuthRepository);
      verifyNoMoreInteractions(mockLogger);
    });

    test('Delete account success', () async {
      final sut = AuthService(mockAuthRepository, mockLogger);

      await sut.deleteAccount();

      verify(mockAuthRepository.deleteAccount()).called(1);
      verifyNoMoreInteractions(mockAuthRepository);
    });

    test('Delete account fail with AuthException', () async {
      final sut = AuthService(mockAuthRepository, mockLogger);
      when(mockAuthRepository.deleteAccount()).thenThrow(
        FirebaseAuthException(code: 'authError', message: 'authError'),
      );

      await sut.deleteAccount();

      verify(mockAuthRepository.deleteAccount()).called(1);
      verify(mockLogger.e('authError')).called(1);
      verifyNoMoreInteractions(mockAuthRepository);
      verifyNoMoreInteractions(mockLogger);
    });

    test('Delete account fail with normal Exception', () async {
      final sut = AuthService(mockAuthRepository, mockLogger);
      when(mockAuthRepository.deleteAccount()).thenThrow(
        Exception('unable to delete account'),
      );

      await sut.deleteAccount();

      verify(mockAuthRepository.deleteAccount()).called(1);
      verify(mockLogger.e('Exception: unable to delete account')).called(1);
      verifyNoMoreInteractions(mockAuthRepository);
      verifyNoMoreInteractions(mockLogger);
    });

    test('Auth Service Provider exists', () async {
      final container = createContainer()
        ..listen(authServiceProvider, (_, __) {});

      expect(container.exists(authServiceProvider), true);
    });
  });
}
