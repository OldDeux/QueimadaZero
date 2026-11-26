import 'package:flutter_test/flutter_test.dart';
import 'package:queimada_zero/core/error/exceptions.dart';
import 'package:queimada_zero/core/error/failures.dart';
import 'package:queimada_zero/core/result.dart';
import 'package:queimada_zero/features/localizacao/data/datasources/preferencias_localizacao_datasource.dart';
import 'package:queimada_zero/features/localizacao/data/repositories/localizacao_repository_impl.dart';

import '../fakes.dart';

class _PreferenciasQuebradas implements PreferenciasLocalizacaoDataSource {
  @override
  Future<bool> rastreamentoAtivado() =>
      throw const CacheException('Não foi possível ler sua escolha.');

  @override
  Future<void> salvarRastreamento(bool ativado) => throw const CacheException();
}

void main() {
  test('o GPS desligado no meio do caminho vira LocalizacaoFailure', () async {
    final gps = GpsFake();
    final repository = LocalizacaoRepositoryImpl(gps, PreferenciasFake());

    final primeiro = repository.acompanharPosicao().first;
    await pumpEventQueue();
    gps.controlador.addError(
      const LocalizacaoException('O GPS do celular está desligado.'),
    );

    final resultado = await primeiro;
    expect(
      (resultado as Failed).failure,
      isA<LocalizacaoFailure>().having(
        (f) => f.message,
        'message',
        'O GPS do celular está desligado.',
      ),
    );
  });

  test('erro ao ler a escolha salva vira CacheFailure', () async {
    final repository = LocalizacaoRepositoryImpl(
      GpsFake(),
      _PreferenciasQuebradas(),
    );

    final resultado = await repository.rastreamentoAtivado();

    expect((resultado as Failed).failure, isA<CacheFailure>());
  });
}
