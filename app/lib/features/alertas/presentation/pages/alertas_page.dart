import 'package:flutter/material.dart';

import '../../../../core/presentation/em_construcao.dart';

/// Alertas de proximidade recebidos.
class AlertasPage extends StatelessWidget {
  const AlertasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Alertas')),
      body: const EmConstrucao(
        descricao: 'Alertas de proximidade recebidos',
        issue: 14,
      ),
    );
  }
}
