// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'error_codes.dart';
import 'presentation/error_button.dart';

final defaultRightButton = Builder(
  builder: (context) {
    return ErrorButton(onPressed: context.pop, text: 'Cancel');
  },
);

sealed class ErrorState {}

class DialogError extends ErrorState {
  final String title;
  final String? description;
  final String code;
  final Widget? leftButton;
  final Widget rightButton;

  DialogError({
    required this.title,
    required this.code,
    this.description,
    this.leftButton,
    Widget? rightButton,
  }) : rightButton = rightButton ?? defaultRightButton;

  factory DialogError.initFromFirebaseAuthError({
    required final String code,
    final Widget? leftButton,
    final Widget? rightButton,
  }) {
    switch (code) {
      case emailExistsCode:
        return DialogError(
          code: emailExistsCode,
          title: emailExistsMessage,
          description: emailExistsDescription,
          leftButton: leftButton,
          rightButton: rightButton,
        );
      case internalErrorCode:
        return DialogError(
          code: internalErrorCode,
          title: internalErrorMessage,
          description: internalErrorDescription,
          leftButton: leftButton,
          rightButton: rightButton,
        );
      case invalidCredentialCode:
        return DialogError(
          code: invalidCredentialCode,
          title: invalidCredentialMessage,
          description: invalidCredentialDescription,
          leftButton: leftButton,
          rightButton: rightButton,
        );
      case invalidPasswordCode:
        return DialogError(
          code: invalidPasswordCode,
          title: invalidPasswordMessage,
          description: invalidPasswordDescription,
          leftButton: leftButton,
          rightButton: rightButton,
        );
      case userDisabledCode:
        return DialogError(
          code: userDisabledCode,
          title: userDisabledMessage,
          description: userDisabledDescription,
          leftButton: leftButton,
          rightButton: rightButton,
        );
      case userNotFoundCode:
        return DialogError(
          code: userNotFoundCode,
          title: userNotFoundMessage,
          description: userNotFoundDescription,
          leftButton: leftButton,
          rightButton: rightButton,
        );
      case wrongPasswordCode:
        return DialogError(
          code: wrongPasswordCode,
          title: wrongPasswordMessage,
          description: wrongPasswordDescription,
          leftButton: leftButton,
          rightButton: rightButton,
        );
      case userCancelCode:
        return DialogError(
          code: userCancelCode,
          title: userCancelCode,
          description: userCancelCode,
          leftButton: leftButton,
          rightButton: rightButton,
        );
      case noUserDataCode:
        return DialogError(
          code: noUserDataCode,
          title: noUserDataMessage,
          description: noUserDataDescription,
          leftButton: leftButton,
          rightButton: rightButton,
        );
      case userNotExistsCode:
        return DialogError(
          code: userNotExistsCode,
          title: userNotExistsMessage,
          description: userNotExistsDescription,
          leftButton: leftButton,
          rightButton: rightButton,
        );
      default:
        return DialogError(
          code: unknownErrorCode,
          title: unknownErrorMessage,
          description: unknownErrorDescription,
          leftButton: leftButton,
          rightButton: rightButton,
        );
    }
  }
}

class SnackBarError extends ErrorState {
  final String title;
  final String code;

  SnackBarError({required this.title, required this.code});

  factory SnackBarError.initFromFirebaseAuthError({
    required final String code,
  }) {
    switch (code) {
      case emailExistsCode:
        return SnackBarError(
          code: emailExistsCode,
          title: emailExistsMessage,
        );
      case internalErrorCode:
        return SnackBarError(
          code: internalErrorCode,
          title: internalErrorMessage,
        );
      case invalidCredentialCode:
        return SnackBarError(
          code: invalidCredentialCode,
          title: invalidCredentialMessage,
        );
      case invalidPasswordCode:
        return SnackBarError(
          code: invalidPasswordCode,
          title: invalidPasswordMessage,
        );
      case userDisabledCode:
        return SnackBarError(
          code: userDisabledCode,
          title: userDisabledMessage,
        );
      case userNotFoundCode:
        return SnackBarError(
          code: userNotFoundCode,
          title: userNotFoundMessage,
        );
      case wrongPasswordCode:
        return SnackBarError(
          code: wrongPasswordCode,
          title: wrongPasswordMessage,
        );
      case userCancelCode:
        return SnackBarError(
          code: userCancelCode,
          title: userCancelCode,
        );
      case noUserDataCode:
        return SnackBarError(
          code: noUserDataCode,
          title: noUserDataMessage,
        );
      case userNotExistsCode:
        return SnackBarError(
          code: userNotExistsCode,
          title: userNotExistsMessage,
        );
      default:
        return SnackBarError(
          code: unknownErrorCode,
          title: unknownErrorMessage,
        );
    }
  }
}
