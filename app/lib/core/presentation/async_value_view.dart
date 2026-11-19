import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../error/failures.dart';

/// Mostra os estados padrão de um dado assíncrono: carregando, sucesso,
/// erro e offline.
///
/// Todas as telas devem usar este widget, para o app ter o mesmo
/// comportamento de erro em toda parte e nunca quebrar quando uma API falha.
class AsyncValueView<T> extends StatelessWidget {
  const AsyncValueView({
    super.key,
    required this.value,
    required this.data,
    this.onRetry,
  });

  final AsyncValue<T> value;
  final Widget Function(T data) data;

  /// Ação do botão "Tentar novamente". Sem ela, o botão não aparece.
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return switch (value) {
      AsyncData(:final value) => data(value),
      AsyncError(:final error) => _Erro(
        offline: error is NetworkFailure,
        mensagem: error is Failure
            ? error.message
            : const UnexpectedFailure().message,
        onRetry: onRetry,
      ),
      _ => const Center(child: CircularProgressIndicator()),
    };
  }
}

class _Erro extends StatelessWidget {
  const _Erro({required this.offline, required this.mensagem, this.onRetry});

  final bool offline;
  final String mensagem;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(offline ? Icons.wifi_off : Icons.error_outline, size: 48),
            const SizedBox(height: 12),
            Text(
              offline ? 'Você está offline' : 'Algo deu errado',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 4),
            Text(mensagem, textAlign: TextAlign.center),
            if (onRetry != null) ...[
              const SizedBox(height: 16),
              FilledButton(
                onPressed: onRetry,
                child: const Text('Tentar novamente'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
