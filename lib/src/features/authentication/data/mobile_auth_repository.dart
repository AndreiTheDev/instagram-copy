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
  final _authInstance = FirebaseAuth.instance;

  @override
  Future<void> signIn(
    final String email,
    final String password,
  ) async {
    await _authInstance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> signInWithToken(final String token) async {
    await _authInstance.signInWithCustomToken(token);
  }

  @override
  Future<User?> signUpWithEmail(
    final String email,
    final String password,
  ) async {
    final userCredential = await _authInstance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential.user;
  }

  @override
  Future<void> signOut() async {
    await _authInstance.signOut();
  }

  @override
  Future<void> resetPassword(final String email) async {
    await _authInstance.sendPasswordResetEmail(
      email: email,
    );
  }

  @override
  Future<void> deleteAccount() async {
    if (_authInstance.currentUser != null) {
      await _authInstance.currentUser!.delete();
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

  @override
  Future<String> generateSignInToken(final String uid) async {
    // final String uid = _getUserUid();
    final String token = await _functionsInstance
        .httpsCallableFromUrl(
      'http://127.0.0.1:5001/instagram-copy-c694f/us-central1/postsignupdetails-generateSignInToken',
    )
        .call<String>(
      {'uid': uid},
    ).then((result) => result.data);
    return token;
  }
}
