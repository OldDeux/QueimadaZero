import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';

/// Desliga a nova tentativa automática do Riverpod.
///
/// As falhas do app já viram um estado de erro com o botão "Tentar
/// novamente", e a atualização periódica (ex.: AQI a cada 5 minutos) é
/// feita por cada provider. Sem isso, uma API fora do ar seria chamada de
/// novo em segundo plano sem o usuário saber.
Duration? semNovaTentativa(int tentativa, Object erro) => null;

void main() {
  runApp(
    const ProviderScope(retry: semNovaTentativa, child: QueimadaZeroApp()),
  );
}
