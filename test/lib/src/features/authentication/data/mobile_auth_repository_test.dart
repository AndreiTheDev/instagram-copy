import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:instagram_copy/src/features/authentication/data/mobile_auth_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../../test_utils.dart';
import 'mobile_auth_repository_test.mocks.dart';

@GenerateNiceMocks(
  [
    MockSpec<FirebaseFunctions>(),
    MockSpec<HttpsCallable>(),
    MockSpec<HttpsCallableResult>(),
  ],
)
void main() {
  group('Mobile Auth Repository Test Group', () {
    const String email = 'testemail@gmail.com';
    const String token = 'thisisatesttoken';
    late final MockUser mockUser;
    late final MockFirebaseFunctions mockFunctions;

    setUpAll(() {
      mockUser = MockUser(uid: 'someuid', email: email);
      mockFunctions = MockFirebaseFunctions();
    });

    test(
      'Sign In User test',
      () async {
        final mockAuth = MockFirebaseAuth(mockUser: mockUser);
        final sut = MobileAuthRepository(mockFunctions, mockAuth);

        expect(mockAuth.currentUser, null);
        await sut.signIn(email, 'password');
        final currentUser = mockAuth.currentUser;
        expect(currentUser?.email, email);
      },
    );

    test(
      'Sign In User With Token test',
      () async {
        final mockAuth = MockFirebaseAuth(mockUser: mockUser);
        final sut = MobileAuthRepository(mockFunctions, mockAuth);

        expect(mockAuth.currentUser, null);
        await sut.signInWithToken(token);
        final currentUser = mockAuth.currentUser;
        expect(currentUser?.email, email);
      },
    );

    test(
      'Sign Up User test',
      () async {
        final mockAuth = MockFirebaseAuth(mockUser: mockUser);
        final sut = MobileAuthRepository(mockFunctions, mockAuth);

        expect(mockAuth.currentUser, null);
        final user = await sut.signUpWithEmail(email, 'password');
        final currentUser = mockAuth.currentUser;
        expect(currentUser, user);
        expect(currentUser?.email, email);
      },
    );

    test(
      'Sign Out User test',
      () async {
        final mockAuth = MockFirebaseAuth(mockUser: mockUser, signedIn: true);
        final sut = MobileAuthRepository(mockFunctions, mockAuth);

        expect(mockAuth.currentUser, mockUser);
        await sut.signOut();
        final currentUser = mockAuth.currentUser;
        expect(currentUser, null);
      },
    );

    test(
      'Reset Password test',
      () async {
        final mockAuth = MockFirebaseAuth(mockUser: mockUser);
        final sut = MobileAuthRepository(mockFunctions, mockAuth);

        expect(mockAuth.currentUser, null);
        await sut.resetPassword(email);
        final currentUser = mockAuth.currentUser;
        expect(currentUser, null);
      },
    );

    //the mock delete function does nothing so I'm unable to test it
    test(
      'Delete Account success test',
      () async {
        final mockAuth = MockFirebaseAuth(mockUser: mockUser, signedIn: true);
        final sut = MobileAuthRepository(mockFunctions, mockAuth);

        expect(mockAuth.currentUser, mockUser);
        await sut.deleteAccount();
      },
    );

    test(
      'Delete Account fail test',
      () async {
        final mockAuth = MockFirebaseAuth(
          mockUser: mockUser,
        );
        final sut = MobileAuthRepository(mockFunctions, mockAuth);

        expect(mockAuth.currentUser, null);
        late final Object? sutError;
        await sut
            .deleteAccount()
            .onError((error, stackTrace) => sutError = error);
        expect(sutError, isException);
      },
    );

    test('InitFirestore test', () async {
      final mockAuth = MockFirebaseAuth(
        mockUser: mockUser,
      );
      final mockHttpsCallable = MockHttpsCallable();
      const uid = 'testUser';
      final data = {'key': 'value'};

      when(mockFunctions.httpsCallableFromUrl(any))
          .thenReturn(mockHttpsCallable);
      when(mockHttpsCallable.call(any))
          .thenAnswer((realInvocation) async => MockHttpsCallableResult());
      final sut = MobileAuthRepository(mockFunctions, mockAuth);

      await sut.initFirestoreUser(uid, data);

      verify(
        mockFunctions.httpsCallableFromUrl(
          'http://127.0.0.1:5001/instagram-copy-c694f/us-central1/postsignupdetails-initUserWithData',
        ),
      ).called(1);
      verify(mockHttpsCallable.call({'uid': uid, 'signUpData': data}))
          .called(1);
      verifyNoMoreInteractions(mockFunctions);
      verifyNoMoreInteractions(mockHttpsCallable);
    });

    test('GenerateSignInToken test', () async {
      final mockAuth = MockFirebaseAuth(
        mockUser: mockUser,
      );
      final mockHttpsCallable = MockHttpsCallable();
      const uid = 'testUser';

      when(mockFunctions.httpsCallableFromUrl(any))
          .thenReturn(mockHttpsCallable);
      when(mockHttpsCallable.call(any)).thenAnswer(
        (realInvocation) async => MockHttpsCallableResult<String>(),
      );
      final sut = MobileAuthRepository(mockFunctions, mockAuth);

      final response = await sut.generateSignInToken(uid);

      verify(
        mockFunctions.httpsCallableFromUrl(
          'http://127.0.0.1:5001/instagram-copy-c694f/us-central1/postsignupdetails-generateSignInToken',
        ),
      ).called(1);
      verify(mockHttpsCallable.call({'uid': uid})).called(1);
      verifyNoMoreInteractions(mockFunctions);
      verifyNoMoreInteractions(mockHttpsCallable);
      expect(response, isA<String>());
    });

    //this test seems useless
    test('Mobile Auth Repository Provider exists', () {
      final container = createContainer()
        ..listen(mobileAuthRepositoryProvider, (_, __) {});

      expect(container.exists(mobileAuthRepositoryProvider), true);
    });
  });
}
