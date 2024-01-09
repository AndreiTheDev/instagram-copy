import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'routing/app_router.dart';

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    return MaterialApp.router(
      theme: ThemeData(useMaterial3: false),
      routerConfig: ref.watch(routerProvider),
    );
  }
}
