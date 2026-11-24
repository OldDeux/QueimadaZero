import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/presentation/acoes_topo.dart';
import '../../../../core/presentation/async_value_view.dart';
import '../../domain/entities/dica.dart';
import '../providers/dicas_providers.dart';

/// Lista simples das dicas respiratórias.
///
/// Serve de exemplo de ponta a ponta da arquitetura. O visual final é da
/// issue #13.
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
          children: [for (final dica in dicas) _DicaTile(dica: dica)],
        ),
      ),
    );
  }
}

class _DicaTile extends StatelessWidget {
  const _DicaTile({required this.dica});

  final Dica dica;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(dica.grupoDeRisco ? Icons.medical_services : Icons.air),
      title: Text(dica.titulo),
      subtitle: Text(dica.descricao),
    );
  }
}
