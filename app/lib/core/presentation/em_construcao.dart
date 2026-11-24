import 'package:flutter/material.dart';

/// Conteúdo provisório de uma tela que ainda vai ser feita.
///
/// Mostra qual issue implementa a tela, para o grupo saber onde continuar.
class EmConstrucao extends StatelessWidget {
  const EmConstrucao({super.key, required this.descricao, required this.issue});

  final String descricao;

  /// Número da issue que implementa a tela.
  final int issue;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.construction,
              size: 48,
              color: tema.colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 12),
            Text(
              descricao,
              textAlign: TextAlign.center,
              style: tema.textTheme.titleMedium,
            ),
            const SizedBox(height: 4),
            Text(
              'Em construção (issue #$issue)',
              style: tema.textTheme.bodySmall?.copyWith(
                color: tema.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
