import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/presentation/acoes_topo.dart';
import '../../../../core/presentation/em_construcao.dart';
import '../../../../core/router/rotas.dart';

/// Tela inicial: mapa de focos e o botão "Estou vendo fumaça".
class MapaPage extends StatelessWidget {
  const MapaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QueimadaZero'),
        actions: const [AcoesTopo()],
      ),
      body: SafeArea(
        child: Column(
          children: [
            const Expanded(
              child: EmConstrucao(
                descricao: 'Mapa de focos e risco na sua região',
                issue: 11,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: FilledButton.icon(
                onPressed: () => context.push(Rotas.relatar),
                icon: const Icon(Icons.local_fire_department),
                label: const Text('Estou vendo fumaça'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
