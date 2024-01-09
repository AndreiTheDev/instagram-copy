// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:freezed_annotation/freezed_annotation.dart';

import 'auth_field.dart';

part 'signup_form.freezed.dart';

@freezed
class SignUpFormModel with _$SignUpFormModel {
  factory SignUpFormModel({
    required AuthFieldItem<String> completeName,
    required AuthFieldItem<String> password,
    required AuthFieldItem<DateTime> birthday,
    required AuthFieldItem<String> username,
    required AuthFieldItem<String> phoneNumber,
    required AuthFieldItem<String> email,
  }) = _SignUpFormModel;

  factory SignUpFormModel.initial() {
    return SignUpFormModel(
      completeName: AuthFieldItem(fieldValue: ''),
      password: AuthFieldItem(fieldValue: ''),
      birthday: AuthFieldItem(fieldValue: DateTime.now()),
      username: AuthFieldItem(fieldValue: ''),
      phoneNumber: AuthFieldItem(fieldValue: ''),
      email: AuthFieldItem(fieldValue: ''),
    );
  }
  SignUpFormModel._();

  Map<String, dynamic> toJson() {
    return {
      'completeName': completeName.fieldValue,
      'birthday': birthday.fieldValue.toString(),
      'username': username.fieldValue,
      'phoneNumber': phoneNumber.fieldValue,
      'email': email.fieldValue,
    };
  }
}
