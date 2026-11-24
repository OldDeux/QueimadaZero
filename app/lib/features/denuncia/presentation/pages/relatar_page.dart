import 'package:flutter/material.dart';

import '../../../../core/presentation/em_construcao.dart';

/// Relato de fumaça: foto, localização e descrição em uma tela só.
class RelatarPage extends StatelessWidget {
  const RelatarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Estou vendo fumaça')),
      body: const EmConstrucao(
        descricao: 'Foto, localização e descrição do relato',
        issue: 12,
      ),
    );
  }
}
