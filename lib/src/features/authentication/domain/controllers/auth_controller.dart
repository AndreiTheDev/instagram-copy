import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../services/auth_service.dart';
import '../models/signup_form.dart';
import '../models/user.dart';
import 'signup_form_controller.dart';

part 'auth_controller.g.dart';

@riverpod
AuthController authController(final AuthControllerRef ref) {
  final signUpFormModel = ref.watch(signUpFormControllerProvider);
  return AuthController(
    ref.watch(authServiceProvider),
    signUpFormModel,
  );
}

class AuthController {
  AuthController(this._authService, this._signUpFormModel);

  final AuthService _authService;
  final SignUpFormModel _signUpFormModel;

  Future<void> signIn(final String email, final String password) async {
    await _authService.signIn(email, password);
  }

  Future<void> signInWithToken(final UserModel user) async {
    await _authService.signInWithToken(user);
  }

  Future<void> signUpWithEmail() async {
    final String email = _signUpFormModel.email.fieldValue;
    final String password = _signUpFormModel.password.fieldValue;
    if (email.isNotEmpty && password.isNotEmpty) {
      await _authService.signUpWithEmail(email, password, _signUpFormModel);
    }
  }

  Future<void> resetPassword(final String email) async {
    await _authService.resetPassword(email);
  }

  Future<void> signOut() async {
    await _authService.signOut();
  }

  Future<void> deleteAccount() async {
    await _authService.deleteAccount();
  }
}
