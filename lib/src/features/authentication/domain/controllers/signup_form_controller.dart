import 'package:cloud_functions/cloud_functions.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../utils/debouncer.dart';
import '../models/auth_field_errors.dart';
import '../models/signup_form.dart';

part 'signup_form_controller.g.dart';

@riverpod
class SignUpFormController extends _$SignUpFormController {
  @override
  SignUpFormModel build() {
    ref.onDispose(() => _debouncer.dispose);
    return SignUpFormModel.initial();
  }

  final _debouncer = Debounce(const Duration(milliseconds: 1500));

  void onCompleteNameChange(final String newValue) {
    state = state.copyWith.completeName(fieldValue: newValue, error: null);
  }

  void onPasswordChange(final String newValue) {
    state = state.copyWith.password(fieldValue: newValue, error: null);
  }

  void onBirthdayChange(final DateTime newValue) {
    state = state.copyWith.birthday(fieldValue: newValue, error: null);
  }

  Future<void> onUsernameChange(final String newValue) async {
    state = state.copyWith
        .username(fieldValue: newValue, error: null, isValidating: false);
    await isValidUsername();
  }

  void onPhoneNumberChange(final String newValue) {
    state = state.copyWith.phoneNumber(fieldValue: newValue, error: null);
  }

  void onEmailChange(final String newValue) {
    state = state.copyWith.email(fieldValue: newValue, error: null);
  }

  bool isValidCompleteName() {
    // final String completeName = state.completeName.fieldValue;
    // if (completeName.length > 10) {
    //   return true;
    // }
    // state = state.copyWith.completeName(
    //   error: AuthFieldError(errorText: 'Name is not valid'),
    // );
    return true;
  }

  bool isValidPassword() {
    final String passwordValue = state.password.fieldValue;
    if (passwordValue.length >= 6) {
      return true;
    }
    if (passwordValue.isEmpty) {
      state = state.copyWith.password(
        error: AuthFieldError.noPassword(),
      );
      return false;
    }
    state = state.copyWith.password(
      error: AuthFieldError.shortPassword(),
    );
    return false;
  }

  bool isValidBirhday() {
    final DateTime birthdayValue = state.birthday.fieldValue;
    const int fiveYearsInDays = 1825;
    if (DateTime.now().difference(birthdayValue).inDays > fiveYearsInDays) {
      return true;
    }
    state = state.copyWith.birthday(
      error: AuthFieldError.tooYoung(),
    );
    return false;
  }

  Future<void> isValidUsername() async {
    final String usernameValue = state.username.fieldValue;
    if (usernameValue.isEmpty) {
      state = state.copyWith.username(error: AuthFieldError.noUsername());
      return;
    }
    state = state.copyWith.username(isValidating: true);
    //debounce rest of function
    _debouncer.call(() async {
      print('debounce call');
      print(usernameValue);
      final isValidUsername = await FirebaseFunctions.instance
          .httpsCallableFromUrl(
              'http://127.0.0.1:5001/instagram-copy-c694f/us-central1/postsignupdetails-checkUsernameExists')
          .call<bool>(usernameValue)
          .then((result) => result.data);
      if (!isValidUsername) {
        state = state.copyWith.username(
          error: AuthFieldError.usernameTaken(usernameValue),
          isValidating: false,
        );
        return;
      }
      state = state.copyWith.username(isValidating: false);
    });
  }

  bool isValidPhoneNumber() {
    final String phoneNumberValue = state.phoneNumber.fieldValue;
    if (phoneNumberValue.length > 8) {
      return true;
    }
    state = state.copyWith.phoneNumber(
      error: AuthFieldError(errorText: 'Phone number is not valid'),
    );
    return false;
  }

  bool isValidEmail() {
    final String emailValue = state.email.fieldValue;
    final bool isEmailValid = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    ).hasMatch(emailValue);
    if (isEmailValid) {
      return true;
    }
    if (emailValue.isEmpty) {
      state = state.copyWith.email(
        error: AuthFieldError.noEmail(),
      );
      return false;
    }
    state = state.copyWith.email(
      error: AuthFieldError.invalidEmail(),
    );
    return false;
  }

  void resetPassword() {
    state = state.copyWith.password(fieldValue: '', error: null);
  }

  void resetBirthday() {
    state = state.copyWith.birthday(fieldValue: DateTime.now(), error: null);
  }

  void resetUsername() {
    state = state.copyWith
        .username(fieldValue: '', error: null, isValidating: false);
  }

  void resetPhoneNumber() {
    state = state.copyWith.phoneNumber(fieldValue: '', error: null);
  }

  void resetEmail() {
    state = state.copyWith.email(fieldValue: '', error: null);
  }
}
