import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'interfaces/auth_repository_interface.dart';

part 'mobile_auth_repository.g.dart';

@riverpod
MobileAuthRepository mobileAuthRepository(final MobileAuthRepositoryRef ref) =>
    MobileAuthRepository();

class MobileAuthRepository implements IAuthRepository {
  final _functionsInstance = FirebaseFunctions.instance;
  final _authInstace = FirebaseAuth.instance;

  @override
  Future<void> signIn(
    final String email,
    final String password,
  ) async {
    await _authInstace.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  // Future<void> signInWithToken() async {}

  @override
  Future<User?> signUpWithEmail(
    final String email,
    final String password,
  ) async {
    final userCredential = await _authInstace.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential.user;
  }

  @override
  Future<void> signOut() async {
    await _authInstace.signOut();
  }

  @override
  Future<void> deleteAccount() async {
    if (_authInstace.currentUser != null) {
      await _authInstace.currentUser!.delete();
    } else {
      throw Exception('No user signed in');
    }
  }

  @override
  Future<void> initFirestoreUser(
    final String uid,
    final Map<String, dynamic> data,
  ) async {
    await _functionsInstance
        .httpsCallableFromUrl(
      'http://127.0.0.1:5001/instagram-copy-c694f/us-central1/postsignupdetails-initUserWithData',
    )
        .call(
      {
        'uid': uid,
        'signUpData': data,
      },
    );
  }
}
