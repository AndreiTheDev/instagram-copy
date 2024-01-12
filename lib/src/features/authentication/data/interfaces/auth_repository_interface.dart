import 'package:firebase_auth/firebase_auth.dart';

abstract interface class IAuthRepository {
  Future<void> signIn(
    final String email,
    final String password,
  );

  Future<User?> signUpWithEmail(
    final String email,
    final String password,
  );

  Future<void> signOut();

  Future<void> deleteAccount();

  Future<void> initFirestoreUser(
    final String uid,
    final Map<String, dynamic> data,
  );

  Future<void> signInWithToken(final String token);

  Future<String> generateSignInToken(final String uid);
}
