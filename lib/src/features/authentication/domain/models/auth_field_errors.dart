class AuthFieldError {
  final String errorText;
  AuthFieldError({
    required this.errorText,
  });

  factory AuthFieldError.noPassword() {
    return AuthFieldError(
      errorText: "Password field can't be left uncompleted",
    );
  }
  factory AuthFieldError.shortPassword() {
    return AuthFieldError(
      errorText: 'This password is too short. Create a longer password.',
    );
  }
  factory AuthFieldError.tooYoung() {
    return AuthFieldError(
      errorText:
          'It seems like you introduced the wrong details. Please make sure you use your real birthday.',
    );
  }
  factory AuthFieldError.noUsername() {
    return AuthFieldError(
      errorText: 'To continue, please pick an username.',
    );
  }
  factory AuthFieldError.usernameTaken(final String username) {
    return AuthFieldError(
      errorText: 'The username $username is not available.',
    );
  }
  factory AuthFieldError.noEmail() {
    return AuthFieldError(
      errorText: 'E-mail is mandatory.',
    );
  }
  factory AuthFieldError.invalidEmail() {
    return AuthFieldError(
      errorText: 'Please insert a valid email.',
    );
  }
}
