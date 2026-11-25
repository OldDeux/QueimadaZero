import 'package:flutter/material.dart';

import '../../../../core/presentation/acoes_topo.dart';
import '../../../../core/theme/app_colors.dart';

/// Histórico dos relatos. Os registros reais serão exibidos aqui quando
/// as funcionalidades de envio e armazenamento estiverem prontas.
class MeusRelatosPage extends StatelessWidget {
  const MeusRelatosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus relatos'),
        actions: const [AcoesTopo()],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(
              'Seus relatos de fumaça',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            const Text(
              'Aqui você poderá acompanhar os relatos enviados e o status de cada um.',
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
                      Icons.receipt_long_outlined,
                      size: 48,
                      color: AppColors.laranjaEscuro,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Nenhum relato cadastrado',
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Seus relatos aparecerão aqui quando a função de envio estiver disponível.',
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Como funcionam os status',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            const _StatusRelato(
              icone: Icons.check_circle_outline,
              titulo: 'Enviado',
              descricao: 'O relato foi transmitido com sucesso.',
              cor: AppColors.verde,
            ),
            const _StatusRelato(
              icone: Icons.schedule_outlined,
              titulo: 'Na fila',
              descricao: 'O relato aguarda conexão para ser enviado.',
              cor: AppColors.laranjaEscuro,
            ),
            const SizedBox(height: 12),
            const Text(
              'O envio de relatos e a fila offline ainda estão em desenvolvimento.',
              style: TextStyle(color: AppColors.cinza),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusRelato extends StatelessWidget {
  const _StatusRelato({
    required this.icone,
    required this.titulo,
    required this.descricao,
    required this.cor,
  });

  final IconData icone;
  final String titulo;
  final String descricao;
  final Color cor;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(icone, color: cor, size: 28),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    titulo,
                    style: Theme.of(context).textTheme.titleSmall
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 4),
                  Text(descricao),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
