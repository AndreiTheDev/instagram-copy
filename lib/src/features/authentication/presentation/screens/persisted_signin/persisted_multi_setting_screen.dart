import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/controllers/persisted_users_controller.dart';
import '../../widgets/persisted_widgets/delete_persisted_list.dart';
import '../splash_screen.dart';

class PersistedMultiSettingsScreen extends ConsumerStatefulWidget {
  const PersistedMultiSettingsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PersistedMultiSettingsScreenState();
}

class _PersistedMultiSettingsScreenState
    extends ConsumerState<PersistedMultiSettingsScreen> {
  late final TapGestureRecognizer _tapRecognizer;

  @override
  void initState() {
    super.initState();
    _tapRecognizer = TapGestureRecognizer();
  }

  @override
  void dispose() {
    _tapRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final persistedUsers = ref.watch(persistedUsersControllerProvider);
    return switch (persistedUsers) {
      AsyncData(:final value) => DeletePersistedList(usersList: value),
      _ => const SplashScreen(),
    };
  }
}
