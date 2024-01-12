import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/persisted_users_repository.dart';
import '../models/user.dart';
import '../states/user_state.dart';
import 'user_controller.dart';

part 'persisted_users_controller.g.dart';

@riverpod
class PersistedUsersController extends _$PersistedUsersController {
  @override
  Future<List<UserModel>> build() async {
    final usersInStorage = await getAllUsers();
    print(usersInStorage);
    return usersInStorage;
  }

  Future<void> addCurrentUser() async {
    final userState = await ref.read(userStateProvider.future);
    final user = switch (userState) {
      UserAuthenticated() => userState.user,
      _ => null,
    };
    if (user != null) {
      await ref.read(persistedUsersRepositoryProvider).addUser(user.toEntity());
    }
    state = AsyncData(await getAllUsers());
  }

  Future<void> deleteUser(final String uid) async {
    await ref.read(persistedUsersRepositoryProvider).deleteUser(uid);
    state = AsyncData(await getAllUsers());
  }

  Future<List<UserModel>> getAllUsers() async {
    final response =
        await ref.read(persistedUsersRepositoryProvider).getAllUsers();
    return response.map(UserModel.fromEntity).toList();
  }
}

@riverpod
class IsPersistedFlow extends _$IsPersistedFlow {
  @override
  Future<bool> build() async {
    final isPersisted = await ref
        .watch(persistedUsersControllerProvider.future)
        .then((value) => value.isNotEmpty);

    return isPersisted;
  }
}
