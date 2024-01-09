// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';

// import '../dialogs.dart';

// part 'dialog_provider.g.dart';

// @riverpod
// class DialogState extends _$DialogState {
//   @override
//   Dialog build() {
//     return Dialog.incorectPass();
//   }

//   void setNewState(final Dialog dialog) {
//     state = dialog;
//   }
// }

// void watchDialog(final BuildContext context, final WidgetRef ref) async {
//   ref.listen(dialogStateProvider, (final previous, final next) {
//     showDialog(
//       context: context,
//       builder: (final BuildContext context) {
//         return next;
//       },
//     );
//   });
// }
