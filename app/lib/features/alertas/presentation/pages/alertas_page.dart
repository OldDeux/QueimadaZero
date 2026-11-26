import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

/// Primeira etapa do histórico de alertas. A integração com os alertas
/// reais será feita quando o serviço de notificações estiver disponível.
class AlertasPage extends StatelessWidget {
  const AlertasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Alertas')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(
              'Alertas da sua região',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            const Text(
              'Acompanhe aqui os avisos sobre queimadas e fumaça perto de você.',
            ),
            const SizedBox(height: 20),
            Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 28,
                ),
                child: Column(
                  children: [
                    const Icon(
                      Icons.notifications_none_outlined,
                      size: 48,
                      color: AppColors.laranjaEscuro,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Nenhum alerta recebido',
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Quando houver alertas disponíveis, o histórico aparecerá aqui.',
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFFFE4D6),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Row(
                children: [
                  Icon(Icons.info_outline, color: AppColors.laranjaEscuro),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Os alertas automáticos ainda estão em desenvolvimento.',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
