// ignore_for_file: unused_local_variable

import 'package:flutter_test/flutter_test.dart';
import 'package:instagram_copy/src/features/authentication/data/entities/user_entity.dart';
import 'package:instagram_copy/src/features/authentication/data/persisted_users_repository.dart';
import 'package:instagram_copy/src/features/authentication/domain/controllers/persisted_users_controller.dart';
import 'package:instagram_copy/src/features/authentication/domain/controllers/user_controller.dart';
import 'package:instagram_copy/src/features/authentication/domain/models/user.dart';
import 'package:instagram_copy/src/features/authentication/domain/states/user_state.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../../../test_utils.dart';
import 'persisted_users_controller_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<PersistedUsersRepository>(),
  MockSpec<PersistedUsersController>(),
])
void main() {
  group(
    'Persisted Users Controller Test Group',
    () {
      late MockPersistedUsersRepository mockPersistedRepository;
      late UserEntity userEntity;
      late UserModel userModel;

      setUp(() {
        mockPersistedRepository = MockPersistedUsersRepository();
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

      test('Provider build function', () async {
        final container = createContainer(
          overrides: [
            persistedUsersRepositoryProvider.overrideWithValue(
              mockPersistedRepository,
            ),
          ],
        );

        when(mockPersistedRepository.getAllUsers()).thenAnswer(
          (realInvocation) async => [userEntity],
        );

        final sutProviderListener =
            container.listen(persistedUsersControllerProvider, (_, __) {});

        await expectLater(
            await container.read(persistedUsersControllerProvider.future), [
          userModel,
        ]);
        verify(mockPersistedRepository.getAllUsers()).called(1);
        verifyNoMoreInteractions(mockPersistedRepository);
      });

      test('Add current user function user is authenticated', () async {
        final container = createContainer(
          overrides: [
            persistedUsersRepositoryProvider.overrideWithValue(
              mockPersistedRepository,
            ),
            userStateProvider.overrideWith(
              (ref) => UserAuthenticated(
                userModel,
              ),
            ),
          ],
        );

        when(mockPersistedRepository.getAllUsers()).thenAnswer(
          (realInvocation) async => [userEntity],
        );

        final sutProviderListener =
            container.listen(persistedUsersControllerProvider, (_, __) {});

        //state has only one user
        await expectLater(
            await container.read(persistedUsersControllerProvider.future), [
          UserModel.fromEntity(userEntity),
        ]);

        //state will have 2 users now
        when(mockPersistedRepository.getAllUsers()).thenAnswer(
          (realInvocation) async => [userEntity, userEntity],
        );

        await container
            .read(persistedUsersControllerProvider.notifier)
            .addCurrentUser();

        verify(mockPersistedRepository.addUser(userModel.toEntity())).called(1);

        await expectLater(
            await container.read(persistedUsersControllerProvider.future), [
          UserModel.fromEntity(userEntity),
          UserModel.fromEntity(userEntity),
        ]);

        verify(mockPersistedRepository.getAllUsers()).called(2);
        verifyNoMoreInteractions(mockPersistedRepository);
      });

      test('Add current user function user is not authenticated', () async {
        final container = createContainer(
          overrides: [
            persistedUsersRepositoryProvider.overrideWithValue(
              mockPersistedRepository,
            ),
            userStateProvider.overrideWith(
              (ref) => UserUnauthenticated(),
            ),
          ],
        );

        when(mockPersistedRepository.getAllUsers()).thenAnswer(
          (realInvocation) async => [userEntity],
        );

        final sutProviderListener =
            container.listen(persistedUsersControllerProvider, (_, __) {});

        //state has only one user
        await expectLater(
            await container.read(persistedUsersControllerProvider.future), [
          UserModel.fromEntity(userEntity),
        ]);

        await container
            .read(persistedUsersControllerProvider.notifier)
            .addCurrentUser();

        verifyNever(mockPersistedRepository.addUser(userModel.toEntity()));

        //state will not change
        await expectLater(
            await container.read(persistedUsersControllerProvider.future), [
          UserModel.fromEntity(userEntity),
        ]);

        verify(mockPersistedRepository.getAllUsers()).called(2);
        verifyNoMoreInteractions(mockPersistedRepository);
      });

      test('Delete User function deletes user', () async {
        final container = createContainer(
          overrides: [
            persistedUsersRepositoryProvider.overrideWithValue(
              mockPersistedRepository,
            ),
          ],
        );
        when(mockPersistedRepository.getAllUsers()).thenAnswer(
          (realInvocation) async => [userEntity],
        );
        final sutProviderListener =
            container.listen(persistedUsersControllerProvider, (_, __) {});

        //state has only one user
        await expectLater(
            await container.read(persistedUsersControllerProvider.future), [
          UserModel.fromEntity(userEntity),
        ]);

        when(mockPersistedRepository.getAllUsers()).thenAnswer(
          (realInvocation) async => [],
        );

        await container
            .read(persistedUsersControllerProvider.notifier)
            .deleteUser(userModel.uid);

        //state has no users
        await expectLater(
          await container.read(persistedUsersControllerProvider.future),
          [],
        );

        verify(mockPersistedRepository.deleteUser(userModel.uid)).called(1);
        verify(mockPersistedRepository.getAllUsers()).called(2);
        verifyNoMoreInteractions(mockPersistedRepository);
      });
    },
  );

  group('Is Persisted Flow Test Group', () {
    late MockPersistedUsersRepository mockPersistedRepository;
    late UserEntity userEntity;
    late UserModel userModel;

    setUp(() {
      mockPersistedRepository = MockPersistedUsersRepository();
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

    test('Test Flow is persisted returns true', () async {
      final container = createContainer(
        overrides: [
          persistedUsersRepositoryProvider.overrideWithValue(
            mockPersistedRepository,
          ),
        ],
      );
      when(mockPersistedRepository.getAllUsers())
          .thenAnswer((realInvocation) async => [userEntity]);

      final sutListener = container.listen(isPersistedFlowProvider, (_, __) {});

      await expectLater(
        await container.read(isPersistedFlowProvider.future),
        true,
      );
      verify(mockPersistedRepository.getAllUsers()).called(1);
      verifyNoMoreInteractions(mockPersistedRepository);
    });

    test('Test Flow is persisted returns false', () async {
      final container = createContainer(
        overrides: [
          persistedUsersRepositoryProvider.overrideWithValue(
            mockPersistedRepository,
          ),
        ],
      );
      when(mockPersistedRepository.getAllUsers())
          .thenAnswer((realInvocation) async => []);

      final sutListener = container.listen(isPersistedFlowProvider, (_, __) {});

      await expectLater(
        await container.read(isPersistedFlowProvider.future),
        false,
      );
      verify(mockPersistedRepository.getAllUsers()).called(1);
      verifyNoMoreInteractions(mockPersistedRepository);
    });
  });
}
