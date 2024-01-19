// ignore_for_file: unused_local_variable

import 'package:flutter_test/flutter_test.dart';
import 'package:instagram_copy/src/features/authentication/data/entities/user_entity.dart';
import 'package:instagram_copy/src/features/authentication/data/user_repository.dart';
import 'package:instagram_copy/src/features/authentication/domain/controllers/user_controller.dart';
import 'package:instagram_copy/src/features/authentication/domain/models/user.dart';
import 'package:instagram_copy/src/features/authentication/domain/states/user_state.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../../../test_utils.dart';
import 'user_controller_test.mocks.dart';

@GenerateNiceMocks([MockSpec<UserRepository>()])
void main() {
  group('User Changes Test Group', () {
    late MockUserRepository mockUserRepository;
    late UserEntity userEntity;
    late UserModel userModel;

    setUp(() {
      mockUserRepository = MockUserRepository();
      userEntity = UserEntity(
        uid: 'testUid',
        emailVerified: false,
        email: 'testemail@gmail.com',
      );
      userModel = UserModel(
        uid: 'testUid',
        emailVerified: false,
        email: 'testemail@gmail.com',
      );
    });

    test('User changes returns new user model', () async {
      final container = createContainer(
        overrides: [
          userRepositoryProvider.overrideWithValue(mockUserRepository),
        ],
      );
      final sutListener = container.listen(userChangesProvider, (_, __) {});

      when(mockUserRepository.userChanges()).thenAnswer(
        (realInvocation) => Stream.fromIterable(
          [userEntity],
        ),
      );

      await expectLater(
        await container.read(userChangesProvider.future),
        userModel,
      );
      verify(mockUserRepository.userChanges()).called(1);
      verifyNoMoreInteractions(mockUserRepository);
    });

    test('User changes returns null', () async {
      final container = createContainer(
        overrides: [
          userRepositoryProvider.overrideWithValue(mockUserRepository),
        ],
      );
      final sutListener = container.listen(userChangesProvider, (_, __) {});

      when(mockUserRepository.userChanges()).thenAnswer(
        (realInvocation) => Stream.value(null),
      );

      await expectLater(
        await container.read(userChangesProvider.future),
        null,
      );
      verify(mockUserRepository.userChanges()).called(1);
      verifyNoMoreInteractions(mockUserRepository);
    });
  });

  group('User State Test Group', () {
    late MockUserRepository mockUserRepository;
    late UserEntity userEntity;
    late UserModel userModel;

    setUp(() {
      mockUserRepository = MockUserRepository();
      userEntity = UserEntity(
        uid: 'testUid',
        emailVerified: false,
        email: 'testemail@gmail.com',
      );
      userModel = UserModel(
        uid: 'testUid',
        emailVerified: false,
        email: 'testemail@gmail.com',
      );
    });

    test('User changes returns User Authenticated', () async {
      final container = createContainer(
        overrides: [
          userRepositoryProvider.overrideWithValue(mockUserRepository),
        ],
      );
      final sutListener = container.listen(userStateProvider, (_, __) {});

      when(mockUserRepository.userChanges()).thenAnswer(
        (realInvocation) => Stream.fromIterable(
          [userEntity],
        ),
      );

      await expectLater(
        await container.read(userStateProvider.future),
        isA<UserAuthenticated>(),
      );

      verify(mockUserRepository.userChanges()).called(1);
      verifyNoMoreInteractions(mockUserRepository);
    });

    test('User changes returns User Unauthenticated', () async {
      final container = createContainer(
        overrides: [
          userRepositoryProvider.overrideWithValue(mockUserRepository),
        ],
      );
      final sutListener = container.listen(userStateProvider, (_, __) {});

      when(mockUserRepository.userChanges()).thenAnswer(
        (realInvocation) => Stream.value(null),
      );

      await expectLater(
        await container.read(userStateProvider.future),
        isA<UserUnauthenticated>(),
      );

      verify(mockUserRepository.userChanges()).called(1);
      verifyNoMoreInteractions(mockUserRepository);
    });
  });
}
