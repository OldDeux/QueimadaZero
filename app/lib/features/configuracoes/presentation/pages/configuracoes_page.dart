import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/result.dart';
import '../../../../core/router/rotas.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../localizacao/domain/entities/posicao.dart';
import '../../../localizacao/presentation/providers/localizacao_providers.dart';

/// Configurações de localização e privacidade.
///
/// As seções de alertas (som e vibração) e do mapa offline entram com as
/// issues #22 e #19.
class ConfiguracoesPage extends StatelessWidget {
  const ConfiguracoesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Configurações')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _Secao('Localização'),
          _CartaoLocalizacao(),
          SizedBox(height: 24),
          _Secao('Privacidade'),
          Text(
            'Seu nome nunca aparece nos relatos. Com a localização desligada, '
            'o app não usa o GPS, nem com o app fechado.',
            style: TextStyle(fontSize: 15),
          ),
        ],
      ),
    );
  }
}

class _Secao extends StatelessWidget {
  const _Secao(this.titulo);

  final String titulo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 8),
      child: Semantics(
        header: true,
        child: Text(
          titulo.toUpperCase(),
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.8,
            color: AppColors.cinza,
          ),
        ),
      ),
    );
  }
}

class _CartaoLocalizacao extends ConsumerWidget {
  const _CartaoLocalizacao();

  Future<void> _alternar(
    BuildContext context,
    WidgetRef ref,
    bool ligar,
  ) async {
    if (ligar) {
      // A explicação vem antes do pedido do celular.
      await context.push<bool>(Rotas.permissaoLocalizacao);
      return;
    }
    final resultado = await ref.read(rastreamentoProvider.notifier).desativar();
    if (resultado case Failed(:final failure) when context.mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(failure.message)));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rastreamento = ref.watch(rastreamentoProvider);
    final ativado = rastreamento.value ?? false;

    return Card(
      margin: EdgeInsets.zero,
      child: Column(
        children: [
          SwitchListTile(
            value: ativado,
            onChanged: rastreamento.isLoading
                ? null
                : (ligar) => _alternar(context, ref, ligar),
            contentPadding: const EdgeInsets.fromLTRB(12, 8, 8, 8),
            horizontalTitleGap: 12,
            secondary: const _Icone(Icons.location_on_outlined),
            title: const Text(
              'Usar minha localização',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
            subtitle: const Text(
              'Só para os alertas e para marcar o local do relato',
            ),
          ),
          if (rastreamento.hasError)
            _Situacao(
              icone: Icons.error_outline,
              cor: AppColors.vermelho,
              texto: _mensagem(rastreamento.error),
            )
          else if (ativado)
            const _PosicaoAtual(),
        ],
      ),
    );
  }
}

/// Mostra que o GPS está funcionando, com a precisão da posição.
class _PosicaoAtual extends ConsumerWidget {
  const _PosicaoAtual();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return switch (ref.watch(posicaoProvider)) {
      AsyncData(value: final Posicao posicao) => _Situacao(
        icone: Icons.my_location,
        cor: AppColors.verde,
        texto:
            'Localização ativa · precisão de '
            '${posicao.precisaoMetros.round()} m',
        detalhe:
            '${_grau(posicao.latitude)}, ${_grau(posicao.longitude)} · '
            'atualizada às ${_hora(posicao.horario)}',
      ),
      AsyncError(:final error) => _Situacao(
        icone: Icons.location_off_outlined,
        cor: AppColors.vermelho,
        texto: _mensagem(error),
      ),
      _ => const _Situacao(
        icone: Icons.gps_not_fixed,
        cor: AppColors.cinza,
        texto: 'Procurando o sinal do GPS…',
      ),
    };
  }

  static String _grau(double valor) =>
      valor.toStringAsFixed(5).replaceAll('.', ',');

  static String _hora(DateTime horario) {
    final local = horario.toLocal();
    String doisDigitos(int n) => n.toString().padLeft(2, '0');
    return '${doisDigitos(local.hour)}:${doisDigitos(local.minute)}';
  }
}

String _mensagem(Object? erro) =>
    erro is Failure ? erro.message : const UnexpectedFailure().message;

class _Situacao extends StatelessWidget {
  const _Situacao({
    required this.icone,
    required this.cor,
    required this.texto,
    this.detalhe,
  });

  final IconData icone;
  final Color cor;
  final String texto;
  final String? detalhe;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: Color(0xFFD6D3D1))),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icone, color: cor, size: 22),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  texto,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (detalhe != null)
                  Text(
                    detalhe!,
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.cinza,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Icone extends StatelessWidget {
  const _Icone(this.icone);

  final IconData icone;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: const Color(0xFFF3F1EF),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(icone, color: AppColors.preto),
    );
  }
}
