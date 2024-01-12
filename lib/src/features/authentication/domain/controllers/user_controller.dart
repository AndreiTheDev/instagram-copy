import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/user_repository.dart';
import '../models/user.dart';
import '../states/user_state.dart';
// import 'auth_controller.dart';

part 'user_controller.g.dart';

@riverpod
Stream<UserModel?> userChanges(final UserChangesRef ref) async* {
  final userChanges = ref.read(userRepositoryProvider).userChanges();

  await for (final userEntity in userChanges) {
    if (userEntity != null) {
      yield UserModel.fromEntity(userEntity);
    } else {
      yield null;
    }
  }
}

@riverpod
Future<UserState> userState(final UserStateRef ref) async {
  final UserModel? newUser = await ref.watch(userChangesProvider.future);
  // await Future.delayed(const Duration(seconds: 2));
  if (newUser == null) {
    return UserUnauthenticated();
  }
  if (newUser.emailVerified) {
    // ref.read(authControllerProvider).verifyEmail();
  }
  return UserAuthenticated(newUser);
}
