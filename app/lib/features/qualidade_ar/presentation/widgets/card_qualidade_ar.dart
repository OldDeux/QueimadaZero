import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/qualidade_ar.dart';
import '../providers/qualidade_ar_providers.dart';
import 'cores_do_ceu.dart';

/// Card da Home com a qualidade do ar da cidade, na "cor do céu" do índice.
///
/// Estados (issue #10):
/// * carregando a primeira vez;
/// * dado atual, com o horário da medição;
/// * dado salvo: a atualização falhou, então mostra o último dado recebido
///   com o horário dele;
/// * erro amigável, com "Tentar novamente", quando ainda não há dado salvo.
class CardQualidadeAr extends ConsumerWidget {
  const CardQualidadeAr({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final estado = ref.watch(qualidadeArAtualProvider);
    final cidade = ref.watch(localizacaoProvider).cidade;
    void atualizar() => ref.invalidate(qualidadeArAtualProvider);

    // Com dado (atual ou salvo), o card continua visível mesmo se a
    // atualização falhar.
    if (estado.hasValue) {
      return _CardComDado(
        qualidade: estado.requireValue,
        cidade: cidade,
        atualizando: estado.isLoading,
        falhaAoAtualizar: estado.hasError ? estado.error : null,
        onAtualizar: atualizar,
      );
    }
    if (estado.hasError) {
      return _CardErro(erro: estado.error!, onTentarNovamente: atualizar);
    }
    return const _CardCarregando();
  }
}

class _CardComDado extends StatelessWidget {
  const _CardComDado({
    required this.qualidade,
    required this.cidade,
    required this.atualizando,
    required this.falhaAoAtualizar,
    required this.onAtualizar,
  });

  final QualidadeAr qualidade;
  final String cidade;
  final bool atualizando;
  final Object? falhaAoAtualizar;
  final VoidCallback onAtualizar;

  @override
  Widget build(BuildContext context) {
    final nivel = qualidade.nivel;
    final cor = nivel.texto;
    final textos = Theme.of(context).textTheme;
    final hora = _hora(qualidade.atualizadoEm);

    return Semantics(
      container: true,
      label:
          'Qualidade do ar em $cidade: ${nivel.rotulo}, '
          'índice ${qualidade.indice}',
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: nivel.ceu,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 8, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'QUALIDADE DO AR · $cidade'.toUpperCase(),
                      style: textos.labelMedium?.copyWith(
                        color: cor,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ),
                  if (atualizando)
                    Padding(
                      padding: const EdgeInsets.all(14),
                      child: SizedBox.square(
                        dimension: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: cor,
                        ),
                      ),
                    )
                  else
                    IconButton(
                      tooltip: 'Atualizar qualidade do ar',
                      icon: Icon(Icons.refresh, color: cor),
                      onPressed: onAtualizar,
                    ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '${qualidade.indice}',
                      style: textos.headlineSmall?.copyWith(
                        color: cor,
                        fontSize: 48,
                        height: 1,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            nivel.rotulo,
                            style: textos.titleMedium?.copyWith(color: cor),
                          ),
                          Text(
                            'Índice AQI',
                            style: textos.bodySmall?.copyWith(color: cor),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Text(
                  nivel.orientacao,
                  style: textos.bodyMedium?.copyWith(color: cor),
                ),
              ),
              const SizedBox(height: 8),
              if (falhaAoAtualizar != null)
                Row(
                  children: [
                    Icon(Icons.history, size: 16, color: cor),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        falhaAoAtualizar is NetworkFailure
                            ? 'Sem conexão. Mostrando o dado das $hora.'
                            : 'Não deu para atualizar. Mostrando o dado das $hora.',
                        style: textos.bodySmall?.copyWith(color: cor),
                      ),
                    ),
                  ],
                )
              else
                Text(
                  'Atualizado às $hora · Fonte: Open-Meteo (CAMS)',
                  style: textos.bodySmall?.copyWith(color: cor),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CardCarregando extends StatelessWidget {
  const _CardCarregando();

  @override
  Widget build(BuildContext context) {
    return const Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            SizedBox.square(
              dimension: 24,
              child: CircularProgressIndicator(strokeWidth: 3),
            ),
            SizedBox(width: 16),
            Expanded(child: Text('Carregando a qualidade do ar...')),
          ],
        ),
      ),
    );
  }
}

class _CardErro extends StatelessWidget {
  const _CardErro({required this.erro, required this.onTentarNovamente});

  final Object erro;
  final VoidCallback onTentarNovamente;

  @override
  Widget build(BuildContext context) {
    final textos = Theme.of(context).textTheme;
    final offline = erro is NetworkFailure;
    final mensagem = erro is Failure
        ? (erro as Failure).message
        : const UnexpectedFailure().message;

    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(offline ? Icons.wifi_off : Icons.cloud_off),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    offline
                        ? 'Você está offline'
                        : 'Qualidade do ar indisponível',
                    style: textos.titleMedium,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(mensagem),
            const SizedBox(height: 12),
            OutlinedButton(
              onPressed: onTentarNovamente,
              child: const Text('Tentar novamente'),
            ),
          ],
        ),
      ),
    );
  }
}

/// Hora local no formato 14:32.
String _hora(DateTime data) {
  final local = data.toLocal();
  String dois(int n) => n.toString().padLeft(2, '0');
  return '${dois(local.hour)}:${dois(local.minute)}';
}
