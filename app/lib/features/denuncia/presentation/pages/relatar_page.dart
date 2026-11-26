import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

/// Primeira etapa do fluxo de relato, antes da integração com câmera e GPS.
class RelatarPage extends StatelessWidget {
  const RelatarPage({super.key});

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Estou vendo fumaça')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Relatar uma ocorrência',
                    style: tema.textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'O relato terá uma foto, a localização e uma descrição opcional.',
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFE4D6),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: AppColors.laranjaEscuro,
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Este formulário é uma prévia. Foto, GPS e envio ainda estão em desenvolvimento.',
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  _PassoCard(
                    titulo: '1. Foto da ocorrência',
                    icone: Icons.camera_alt_outlined,
                    conteudo: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          'A foto ajudará a identificar a fumaça ou a queimada.',
                        ),
                        const SizedBox(height: 12),
                        Container(
                          height: 116,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFF3ED),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add_a_photo_outlined,
                                size: 32,
                                color: AppColors.laranjaEscuro,
                              ),
                              SizedBox(height: 8),
                              Text('Nenhuma foto adicionada'),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        OutlinedButton.icon(
                          onPressed: null,
                          icon: const Icon(Icons.add_a_photo_outlined),
                          label: const Text('Adicionar foto (em breve)'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  const _PassoCard(
                    titulo: '2. Localização',
                    icone: Icons.location_on_outlined,
                    conteudo: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Localização ainda não capturada',
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                        SizedBox(height: 6),
                        Text(
                          'Quando o GPS estiver disponível, você poderá confirmar o local antes do envio.',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  const _PassoCard(
                    titulo: '3. Descrição (opcional)',
                    icone: Icons.edit_note_outlined,
                    conteudo: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          maxLines: 3,
                          maxLength: 200,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Ex.: muita fumaça perto da estrada',
                          ),
                        ),
                        Text(
                          'O texto preenchido aqui ainda não é salvo.',
                          style: TextStyle(color: AppColors.cinza),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),
                  FilledButton.icon(
                    onPressed: null,
                    icon: const Icon(Icons.send_outlined),
                    label: const Text('Enviar relato (em breve)'),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'O envio real e a fila para uso sem internet ainda serão implementados.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: AppColors.cinza),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PassoCard extends StatelessWidget {
  const _PassoCard({
    required this.titulo,
    required this.icone,
    required this.conteudo,
  });

  final String titulo;
  final IconData icone;
  final Widget conteudo;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Icon(icone, color: AppColors.laranjaEscuro),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    titulo,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            conteudo,
          ],
        ),
      ),
    );
  }
}
