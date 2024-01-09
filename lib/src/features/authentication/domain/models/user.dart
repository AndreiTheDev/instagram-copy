import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/entities/user_entity.dart';

part 'user.freezed.dart';

@freezed
class UserModel with _$UserModel {
  factory UserModel({
    required final String uid,
    required final auth.User user,
  }) = _UserModel;

  UserModel._();

  factory UserModel.fromEntity(final UserEntity entity) {
    return UserModel(uid: entity.uid, user: entity.user);
  }
}
