import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_entity.freezed.dart';

@freezed
class UserEntity with _$UserEntity {
  factory UserEntity({
    required final String uid,
    required final bool emailVerified,
    required final String email,
    final String? displayName,
    final String? phoneNumber,
  }) = _UserEntity;

  UserEntity._();

  factory UserEntity.fromJson(final Map<String, dynamic> data) {
    return UserEntity(
      uid: data['uid'],
      emailVerified: data['emailVerified'],
      displayName: data['displayName'],
      email: data['email'],
      phoneNumber: data['phoneNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'emailVerified': emailVerified,
      'displayName': displayName,
      'email': email,
      'phoneNumber': phoneNumber,
    };
  }
}
