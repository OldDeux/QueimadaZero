import 'package:flutter/material.dart';

import '../../../../core/presentation/em_construcao.dart';

/// Configurações de localização e alertas.
class ConfiguracoesPage extends StatelessWidget {
  const ConfiguracoesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Configurações')),
      body: const EmConstrucao(
        descricao: 'Ligar e desligar a localização, o som e a vibração',
        issue: 20,
      ),
    );
  }
}
