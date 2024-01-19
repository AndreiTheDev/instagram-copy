import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:instagram_copy/src/features/authentication/data/entities/user_entity.dart';
import 'package:instagram_copy/src/features/authentication/data/persisted_users_repository.dart';
import 'package:logger/logger.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../../test_utils.dart';
import 'persisted_users_repository_test.mocks.dart';

@GenerateNiceMocks([MockSpec<FlutterSecureStorage>(), MockSpec<Logger>()])
void main() {
  group(
    'Persisted User Repository Test Group',
    () {
      late final MockFlutterSecureStorage mockStorage;
      late final MockLogger mockLogger;

      setUpAll(() {
        mockStorage = MockFlutterSecureStorage();
        mockLogger = MockLogger();
      });

      test(
        'Add User success',
        () async {
          final entity = UserEntity(
            uid: '123',
            emailVerified: true,
            email: 'testemail@gmail.com',
          );
          final sut = PersistedUsersRepository(mockStorage, mockLogger);

          when(mockStorage.containsKey(key: anyNamed('key'))).thenAnswer(
            (realInvocation) async => false,
          );

          await sut.addUser(entity);

          verify(mockStorage.containsKey(key: entity.uid)).called(1);
          verify(
            mockStorage.write(
              key: entity.uid,
              value: jsonEncode(entity.toJson()),
            ),
          ).called(1);
          verifyNoMoreInteractions(mockStorage);
        },
      );

      test(
        'Add User but user is already in database',
        () async {
          final entity = UserEntity(
            uid: '123',
            emailVerified: true,
            email: 'testemail@gmail.com',
          );
          final sut = PersistedUsersRepository(mockStorage, mockLogger);

          when(mockStorage.containsKey(key: anyNamed('key'))).thenAnswer(
            (realInvocation) async => true,
          );

          await sut.addUser(entity);

          verify(mockStorage.containsKey(key: entity.uid)).called(1);
          verifyNever(
            mockStorage.write(
              key: entity.uid,
              value: jsonEncode(entity.toJson()),
            ),
          );
          verifyNoMoreInteractions(mockStorage);
        },
      );

      test(
        'Add User throws error',
        () async {
          final entity = UserEntity(
            uid: '123',
            emailVerified: true,
            email: 'testemail@gmail.com',
          );
          final sut = PersistedUsersRepository(mockStorage, mockLogger);

          when(mockStorage.containsKey(key: anyNamed('key'))).thenAnswer(
            (realInvocation) async => false,
          );
          when(
            mockStorage.write(
              key: anyNamed('key'),
              value: jsonEncode(entity.toJson()),
            ),
          ).thenThrow(Exception());

          await sut.addUser(entity);

          verify(mockStorage.containsKey(key: entity.uid)).called(1);
          verify(
            mockStorage.write(
              key: entity.uid,
              value: jsonEncode(entity.toJson()),
            ),
          ).called(1);
          verify(mockLogger.e(Exception().toString())).called(1);
          verifyNoMoreInteractions(mockStorage);
          verifyNoMoreInteractions(mockLogger);
        },
      );

      test(
        'Delete user from storage',
        () async {
          final entity = UserEntity(
            uid: '123',
            emailVerified: true,
            email: 'testemail@gmail.com',
          );
          final sut = PersistedUsersRepository(mockStorage, mockLogger);

          await sut.deleteUser(entity.uid);

          verify(
            mockStorage.delete(
              key: entity.uid,
            ),
          ).called(1);
          verifyNoMoreInteractions(mockStorage);
        },
      );

      test(
        'Delete user from storage throws error',
        () async {
          final entity = UserEntity(
            uid: '123',
            emailVerified: true,
            email: 'testemail@gmail.com',
          );
          final sut = PersistedUsersRepository(mockStorage, mockLogger);

          when(mockStorage.delete(key: entity.uid)).thenThrow(Exception());

          await sut.deleteUser(entity.uid);

          verify(
            mockStorage.delete(
              key: entity.uid,
            ),
          ).called(1);
          verify(mockLogger.e(Exception().toString())).called(1);
          verifyNoMoreInteractions(mockStorage);
          verifyNoMoreInteractions(mockLogger);
        },
      );

      test(
        'Get all users from storage return user list',
        () async {
          final entity = UserEntity(
            uid: '123',
            emailVerified: true,
            email: 'testemail@gmail.com',
          );
          final sut = PersistedUsersRepository(mockStorage, mockLogger);

          when(mockStorage.readAll()).thenAnswer(
            (realInvocation) => Future.value({
              entity.uid: jsonEncode(entity.toJson()),
            }),
          );

          final usersInStorage = await sut.getAllUsers();

          verify(mockStorage.readAll()).called(1);
          verifyNoMoreInteractions(mockStorage);

          expect(usersInStorage, [entity]);
        },
      );

      test(
        'Get all users from storage throws error and return empty user list',
        () async {
          final sut = PersistedUsersRepository(mockStorage, mockLogger);

          when(mockStorage.readAll()).thenThrow(Exception());

          final usersInStorage = await sut.getAllUsers();

          verify(mockStorage.readAll()).called(1);
          verify(mockLogger.e(Exception().toString())).called(1);
          verifyNoMoreInteractions(mockLogger);
          expect(usersInStorage, <UserEntity>[]);
        },
      );

      test('Persisted Users Repository Provider exists', () {
        final container = createContainer()
          ..listen(persistedUsersRepositoryProvider, (_, __) {});

        expect(container.exists(persistedUsersRepositoryProvider), true);
      });
    },
  );
}
