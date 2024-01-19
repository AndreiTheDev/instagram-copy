import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/entities/user_entity.dart';

part 'user.freezed.dart';

@freezed
class UserModel with _$UserModel {
  factory UserModel({
    required final String uid,
    required final bool emailVerified,
    required final String email,
    final String? displayName,
    final String? phoneNumber,
  }) = _UserModel;

  UserModel._();

  factory UserModel.fromEntity(final UserEntity entity) {
    return UserModel(
      uid: entity.uid,
      emailVerified: entity.emailVerified,
      displayName: entity.displayName,
      email: entity.email,
      phoneNumber: entity.phoneNumber,
    );
  }

  UserEntity toEntity() {
    return UserEntity(
      uid: uid,
      emailVerified: emailVerified,
      displayName: displayName,
      email: email,
      phoneNumber: phoneNumber,
    );
  }
}
