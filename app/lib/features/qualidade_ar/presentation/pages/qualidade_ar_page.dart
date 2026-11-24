import 'package:flutter/material.dart';

import '../../../../core/presentation/acoes_topo.dart';
import '../../../../core/presentation/em_construcao.dart';

/// Índice de qualidade do ar da região.
class QualidadeArPage extends StatelessWidget {
  const QualidadeArPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Qualidade do ar'),
        actions: const [AcoesTopo()],
      ),
      body: const EmConstrucao(
        descricao: 'Índice de qualidade do ar da sua cidade',
        issue: 17,
      ),
    );
  }
}
