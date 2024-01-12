import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../constants/exports.dart';
import '../../../domain/controllers/auth_controller.dart';
import '../../../domain/models/user.dart';

class PersistedUsersLayout extends ConsumerWidget {
  const PersistedUsersLayout({required this.usersList, super.key});

  final List<UserModel> usersList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (usersList.length == 1) {
      return Column(
        children: [
          GestureDetector(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white,
                  width: 4,
                ),
                boxShadow: const <BoxShadow>[
                  BoxShadow(
                    color: Color(0xffe0e0e1),
                    spreadRadius: 8,
                    blurRadius: 8,
                  ),
                ],
                shape: BoxShape.circle,
              ),
              child: const CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage: AssetImage(
                  'assets/images/my_photo.jpg',
                ),
                radius: 80,
              ),
            ),
            onTap: () async {
              await ref
                  .read(authControllerProvider)
                  .signInWithToken(usersList[0]);
            },
          ),
          xsSeparator,
          Text(
            usersList[0].email!,
            style: const TextStyle(
              fontSize: mediumText,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      );
    } else {
      return SizedBox(
        height: 200,
        child: ListView.separated(
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) {
            return GestureDetector(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: xsSize,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const <BoxShadow>[
                    BoxShadow(
                      color: Color(0xffe0e0e1),
                      blurRadius: 10,
                    ),
                  ],
                ),
                height: 90,
                width: double.infinity,
                child: Row(
                  children: [
                    const CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage: AssetImage(
                        'assets/images/my_photo.jpg',
                      ),
                      radius: 32,
                    ),
                    const SizedBox(
                      width: xsSize,
                    ),
                    Text(
                      usersList[index].email!,
                      style: const TextStyle(
                        fontSize: xsSize,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              onTap: () async {
                await ref
                    .read(authControllerProvider)
                    .signInWithToken(usersList[index]);
              },
            );
          },
          separatorBuilder: (context, index) {
            return xsSeparator;
          },
          itemCount: usersList.length,
        ),
      );
    }
  }
}
