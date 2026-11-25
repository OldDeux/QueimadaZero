import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/presentation/acoes_topo.dart';
import '../../../../core/presentation/async_value_view.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/dica.dart';
import '../providers/dicas_providers.dart';

/// Dicas de proteção respiratória, disponíveis mesmo sem internet.
class DicasPage extends ConsumerWidget {
  const DicasPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dicas respiratórias'),
        actions: const [AcoesTopo()],
      ),
      body: AsyncValueView(
        value: ref.watch(dicasProvider),
        onRetry: () => ref.invalidate(dicasProvider),
        data: (dicas) => ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(
              'Proteja sua respiração',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            const Text('Veja como reduzir a exposição à fumaça das queimadas.'),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFFFE4D6),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Row(
                children: [
                  Icon(Icons.offline_pin, color: AppColors.laranjaEscuro),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'As dicas ficam disponíveis mesmo sem internet.',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Cuidados do dia a dia',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            for (final dica in dicas)
              if (!dica.grupoDeRisco) _DicaCard(dica: dica),
            if (dicas.any((dica) => dica.grupoDeRisco)) ...[
              const SizedBox(height: 20),
              Text(
                'Atenção para quem tem asma ou DPOC',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              const Text(
                'Quem tem problemas respiratórios precisa de cuidados extras.',
              ),
              const SizedBox(height: 12),
              for (final dica in dicas)
                if (dica.grupoDeRisco) _DicaCard(dica: dica),
            ],
          ],
        ),
      ),
    );
  }
}

class _DicaCard extends StatelessWidget {
  const _DicaCard({required this.dica});

  final Dica dica;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      color: dica.grupoDeRisco ? const Color(0xFFFFF1EC) : AppColors.branco,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              dica.grupoDeRisco
                  ? Icons.medical_services_outlined
                  : Icons.check_circle_outline,
              color: dica.grupoDeRisco
                  ? AppColors.vermelho
                  : AppColors.laranjaEscuro,
              size: 28,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    dica.titulo,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.preto,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    dica.descricao,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.cinza,
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
