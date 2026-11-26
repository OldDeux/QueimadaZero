import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/result.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/permissao_localizacao.dart';
import '../providers/localizacao_providers.dart';

/// Explica para que o app usa a localização antes de pedir a permissão.
///
/// Fecha com `true` se a localização foi ligada.
class PermissaoLocalizacaoPage extends ConsumerStatefulWidget {
  const PermissaoLocalizacaoPage({super.key});

  @override
  ConsumerState<PermissaoLocalizacaoPage> createState() =>
      _PermissaoLocalizacaoPageState();
}

class _PermissaoLocalizacaoPageState
    extends ConsumerState<PermissaoLocalizacaoPage> {
  bool _pedindo = false;
  PermissaoLocalizacao? _resposta;
  String? _erro;

  Future<void> _permitir() async {
    setState(() => _pedindo = true);
    final resultado = await ref.read(rastreamentoProvider.notifier).ativar();
    if (!mounted) return;
    if (resultado case Success(value: PermissaoLocalizacao.concedida)) {
      context.pop(true);
      return;
    }
    setState(() {
      _pedindo = false;
      _resposta = resultado.fold((_) => null, (resposta) => resposta);
      _erro = resultado.fold((falha) => falha.message, (_) => null);
    });
  }

  @override
  Widget build(BuildContext context) {
    final textos = Theme.of(context).textTheme;
    final aviso = _erro ?? _avisos[_resposta];
    // O navegador não deixa o site abrir os ajustes, só o celular.
    final podeAbrirAjustes =
        !kIsWeb &&
        (_resposta == PermissaoLocalizacao.negadaParaSempre ||
            _resposta == PermissaoLocalizacao.gpsDesligado);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const _Ilustracao(),
              const SizedBox(height: 28),
              Text(
                'Ative sua localização para receber alertas',
                style: textos.headlineSmall,
              ),
              const SizedBox(height: 12),
              Text(
                'Assim o QueimadaZero consegue avisar quando existir um foco de '
                'queimada perto de você, mesmo com o app fechado.',
                style: textos.bodyLarge?.copyWith(color: AppColors.cinza),
              ),
              const SizedBox(height: 24),
              const _Item(
                icone: Icons.notifications_none,
                texto: 'Usada só para alertas e para o seu relato',
              ),
              const _Item(
                icone: Icons.visibility_outlined,
                texto: 'Seu nome não aparece para outras pessoas',
              ),
              const _Item(
                icone: Icons.tune,
                texto: 'Você pode desligar quando quiser nas configurações',
              ),
              if (aviso != null) ...[
                const SizedBox(height: 8),
                _Aviso(
                  texto: aviso,
                  onAbrirAjustes: podeAbrirAjustes
                      ? () => ref
                            .read(rastreamentoProvider.notifier)
                            .abrirAjustes(_resposta!)
                      : null,
                ),
              ],
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: _pedindo ? null : _permitir,
                icon: const Icon(Icons.location_on_outlined),
                label: Text(
                  _resposta == null ? 'Permitir localização' : 'Tentar de novo',
                ),
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: _pedindo ? null : () => context.pop(false),
                style: TextButton.styleFrom(
                  minimumSize: const Size.fromHeight(48),
                  textStyle: textos.labelLarge,
                ),
                child: const Text('Agora não'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

const _avisos = {
  PermissaoLocalizacao.negada:
      'Sem a permissão, a localização continua desligada. Você pode tentar '
      'de novo quando quiser.',
  PermissaoLocalizacao.negadaParaSempre:
      'O celular bloqueou a localização para o QueimadaZero. Libere nos '
      'ajustes do celular e tente de novo.',
  PermissaoLocalizacao.gpsDesligado:
      'O GPS do celular está desligado. Ligue o GPS e tente de novo.',
};

class _Ilustracao extends StatelessWidget {
  const _Ilustracao();

  @override
  Widget build(BuildContext context) {
    return ExcludeSemantics(
      child: Container(
        height: 180,
        decoration: BoxDecoration(
          color: const Color(0xFFFFE9DF),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Center(
          child: Container(
            width: 112,
            height: 112,
            decoration: const BoxDecoration(
              color: Color(0xFFFBCDB8),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.location_on_outlined,
              size: 56,
              color: AppColors.laranjaEscuro,
            ),
          ),
        ),
      ),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({required this.icone, required this.texto});

  final IconData icone;
  final String texto;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: const Color(0xFFF3F1EF),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icone, color: AppColors.laranjaEscuro),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(texto, style: Theme.of(context).textTheme.bodyLarge),
          ),
        ],
      ),
    );
  }
}

class _Aviso extends StatelessWidget {
  const _Aviso({required this.texto, this.onAbrirAjustes});

  final String texto;
  final VoidCallback? onAbrirAjustes;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF1EC),
        border: Border.all(color: AppColors.vermelho),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.location_off_outlined,
                color: AppColors.vermelho,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(texto, style: const TextStyle(fontSize: 15)),
              ),
            ],
          ),
          if (onAbrirAjustes != null) ...[
            const SizedBox(height: 12),
            OutlinedButton(
              onPressed: onAbrirAjustes,
              child: const Text('Abrir ajustes do celular'),
            ),
          ],
        ],
      ),
    );
  }
}
