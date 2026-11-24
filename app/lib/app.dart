import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';

class QueimadaZeroApp extends ConsumerWidget {
  const QueimadaZeroApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'QueimadaZero',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.claro,
      // O app usa só o tema claro: é o de maior contraste sob o sol.
      themeMode: ThemeMode.light,
      routerConfig: ref.watch(routerProvider),
    );
  }
}
