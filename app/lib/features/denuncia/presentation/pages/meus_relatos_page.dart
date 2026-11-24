import 'package:flutter/material.dart';

import '../../../../core/presentation/acoes_topo.dart';
import '../../../../core/presentation/em_construcao.dart';

/// Relatos enviados pela pessoa e o status de cada um.
class MeusRelatosPage extends StatelessWidget {
  const MeusRelatosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus relatos'),
        actions: const [AcoesTopo()],
      ),
      body: const EmConstrucao(
        descricao: 'Relatos enviados e o status de cada um',
        issue: 14,
      ),
    );
  }
}
