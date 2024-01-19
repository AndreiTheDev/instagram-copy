import 'package:flutter_test/flutter_test.dart';
import 'package:instagram_copy/src/features/authentication/data/entities/user_entity.dart';
import 'package:instagram_copy/src/features/authentication/domain/models/user.dart';

void main() {
  group('User Model Test Group', () {
    late UserEntity userEntity;

    setUp(() {
      userEntity = UserEntity(
        uid: 'testUid',
        emailVerified: false,
        email: 'testemail@gmail.com',
      );
    });

    test('User Model from entity', () {
      final sut = UserModel.fromEntity(userEntity);
      expect(sut, isA<UserModel>());
      expect(
        sut,
        UserModel(
          uid: 'testUid',
          emailVerified: false,
          email: 'testemail@gmail.com',
        ),
      );
    });

    test('User Model to entity', () {
      final sut = UserModel(
        uid: 'testUid',
        emailVerified: false,
        email: 'testemail@gmail.com',
      );
      expect(sut.toEntity(), isA<UserEntity>());
      expect(
        sut.toEntity(),
        userEntity,
      );
    });
  });
}
