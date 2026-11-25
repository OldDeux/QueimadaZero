import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/presentation/acoes_topo.dart';
import '../../../../core/presentation/em_construcao.dart';
import '../../../../core/router/rotas.dart';
import '../../../qualidade_ar/presentation/widgets/card_qualidade_ar.dart';

/// Tela inicial (Home): qualidade do ar da cidade, atalho para os alertas,
/// mapa de focos e o botão "Estou vendo fumaça".
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
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  const CardQualidadeAr(),
                  const SizedBox(height: 12),
                  // Alerta de proximidade em até 2 toques: este botão abre
                  // os alertas, e tocar no alerta abre o mapa.
                  OutlinedButton.icon(
                    onPressed: () => context.push(Rotas.alertas),
                    icon: const Icon(Icons.notifications_active_outlined),
                    label: const Text('Alertas de proximidade'),
                  ),
                  const SizedBox(height: 12),
                  const SizedBox(
                    height: 280,
                    child: EmConstrucao(
                      descricao: 'Mapa de focos e risco na sua região',
                      issue: 11,
                    ),
                  ),
                ],
              ),
            ),
            // Fica fora da rolagem para estar sempre ao alcance do polegar.
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: FilledButton.icon(
                onPressed: () => context.push(Rotas.relatar),
                icon: const Icon(Icons.local_fire_department, size: 28),
                label: const Text('Estou vendo fumaça'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
