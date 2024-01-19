import 'package:flutter_test/flutter_test.dart';
import 'package:instagram_copy/src/features/authentication/data/entities/user_entity.dart';

void main() {
  group(
    'User Entity Tests',
    () {
      test(
        'ToJson method',
        () async {
          final user = UserEntity(
            uid: 'test',
            emailVerified: true,
            email: 'testmail@gmail.com',
          );
          expect(
            user.toJson(),
            {
              'uid': 'test',
              'emailVerified': true,
              'displayName': null,
              'email': 'testmail@gmail.com',
              'phoneNumber': null,
            },
          );
        },
      );

      test(
        'FromJson method',
        () async {
          final user = UserEntity(
            uid: 'test',
            emailVerified: true,
            email: 'testmail@gmail.com',
          );
          expect(
            UserEntity.fromJson(
              {
                'uid': 'test',
                'emailVerified': true,
                'displayName': null,
                'email': 'testmail@gmail.com',
                'phoneNumber': null,
              },
            ),
            user,
          );
        },
      );
    },
  );
}
