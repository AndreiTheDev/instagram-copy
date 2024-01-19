import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:instagram_copy/src/features/authentication/data/entities/user_entity.dart';
import 'package:instagram_copy/src/features/authentication/data/user_repository.dart';

import '../../../../../test_utils.dart';

void main() {
  group(
    'User Repository Test Group',
    () {
      late final MockUser mockUser;
      setUpAll(() {
        mockUser = MockUser(
          uid: 'someuid',
          email: 'testemail@gmail.com',
          isEmailVerified: false,
        );
      });

      test(
        'User changes stream has a user variable',
        () async {
          final mockAuth = MockFirebaseAuth(mockUser: mockUser);

          final sut = UserRepository(mockAuth);
          await mockAuth.signInWithEmailAndPassword(
            email: 'testemail@gmail.com',
            password: 'password',
          );
          expect(
            sut.userChanges(),
            emits(
              UserEntity(
                uid: 'someuid',
                emailVerified: false,
                email: 'testemail@gmail.com',
              ),
            ),
          );
        },
      );

      test(
        'User changes stream returns null',
        () async {
          final mockAuth = MockFirebaseAuth(mockUser: mockUser);

          final sut = UserRepository(mockAuth);

          expect(
            sut.userChanges(),
            emits(null),
          );
        },
      );

      test(
        'User changes Provider exists',
        () async {
          final container = createContainer()
            ..listen(userRepositoryProvider, (_, __) {});

          expect(container.exists(userRepositoryProvider), true);
        },
      );
    },
  );
}
