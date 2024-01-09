import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../utils/logger.dart';
import '../data/interfaces/auth_repository_interface.dart';
import '../data/mobile_auth_repository.dart';
import '../domain/models/signup_form.dart';

part 'auth_service.g.dart';

@riverpod
AuthService authService(final AuthServiceRef ref) {
  return AuthService(ref.watch(mobileAuthRepositoryProvider));
}

class AuthService {
  AuthService(this._authRepository);

  final IAuthRepository _authRepository;
  final _logger = getLogger(AuthService);

  Future<void> signIn(final String email, final String password) async {
    try {
      await _authRepository.signIn(email, password);
    } on FirebaseAuthException catch (e) {
      _logger.e(e.message);
    }
  }

  Future<void> signUpWithEmail(
    final String email,
    final String password,
    final SignUpFormModel signUpData,
  ) async {
    try {
      final user = await _authRepository.signUpWithEmail(email, password);
      print(user);
      if (user != null) {
        await _authRepository.initFirestoreUser(
          user.uid,
          signUpData.toJson(),
        );
      } else {
        throw Exception('unable to authenticate');
      }
    } on FirebaseAuthException catch (e) {
      _logger.e(e.code);
    } on FirebaseFunctionsException catch (e) {
      _logger.e(e.code);
    }
  }

  Future<void> signOut() async {
    try {
      await _authRepository.signOut();
    } on FirebaseAuthException catch (e) {
      _logger.e(e.message);
    }
  }

  Future<void> deleteAccount() async {
    try {
      await _authRepository.deleteAccount();
    } on FirebaseAuthException catch (e) {
      _logger.e(e.message);
    } on Exception catch (e) {
      _logger.e(e);
    }
  }
}
