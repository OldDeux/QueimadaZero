import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../router/rotas.dart';

/// Sino (alertas) e ajustes (configurações), no topo das abas.
class AcoesTopo extends StatelessWidget {
  const AcoesTopo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          tooltip: 'Alertas',
          icon: const Icon(Icons.notifications_outlined),
          onPressed: () => context.push(Rotas.alertas),
        ),
        IconButton(
          tooltip: 'Configurações',
          icon: const Icon(Icons.settings_outlined),
          onPressed: () => context.push(Rotas.configuracoes),
        ),
      ],
    );
  }
}
