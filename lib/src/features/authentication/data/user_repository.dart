import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'entities/user_entity.dart';

part 'user_repository.g.dart';

@riverpod
UserRepository userRepository(final UserRepositoryRef ref) {
  return UserRepository(FirebaseAuth.instance);
}

class UserRepository {
  UserRepository(this._authInstance);
  final FirebaseAuth _authInstance;

  Stream<UserEntity?> userChanges() async* {
    final changes = _authInstance.userChanges();

    await for (final user in changes) {
      if (user != null) {
        yield UserEntity(
          uid: user.uid,
          emailVerified: user.emailVerified,
          displayName: user.displayName,
          email: user.email!,
          phoneNumber: user.phoneNumber,
        );
      } else {
        yield null;
      }
    }
  }
}
