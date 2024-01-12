import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../common_widgets/custom_back_button.dart';
import '../../../../../constants/exports.dart';
import '../../../../../routing/app_routes/auth_routes.dart';
import '../../../domain/models/user.dart';
import '../custom_app_bar.dart';
import '../gradient_decoration.dart';

class DeletePersistedList extends ConsumerWidget {
  const DeletePersistedList({required this.usersList, super.key});

  final List<UserModel> usersList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(xsSize),
        child: GradientDecoration(
          child: Column(
            children: [
              CustomAppBar(
                buttonLeft: CustomBackButton(onPressed: context.pop),
                widgetMiddle: const Text(
                  'Manage profiles',
                  style: TextStyle(
                    fontSize: smallText,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              xsSeparator,
              Expanded(
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
                        await PersistedSingleSettingsRoute(
                          $extra: usersList[index],
                        ).push(context);
                      },
                    );
                  },
                  separatorBuilder: (context, index) {
                    return xsSeparator;
                  },
                  itemCount: usersList.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
