import 'package:freezed_annotation/freezed_annotation.dart';

import 'auth_field_errors.dart';

part 'auth_field.freezed.dart';

@freezed
class AuthFieldItem<T> with _$AuthFieldItem {
  factory AuthFieldItem({
    required T fieldValue,
    AuthFieldError? error,
    @Default(false) bool isValidating,
  }) = _AuthFieldItem;
}
