import 'package:flutter_test/flutter_test.dart';
import 'package:queimada_zero/core/result.dart';
import 'package:queimada_zero/core/usecase/usecase.dart';
import 'package:queimada_zero/features/localizacao/data/repositories/localizacao_repository_impl.dart';
import 'package:queimada_zero/features/localizacao/domain/entities/permissao_localizacao.dart';
import 'package:queimada_zero/features/localizacao/domain/usecases/acompanhar_posicao.dart';
import 'package:queimada_zero/features/localizacao/domain/usecases/ativar_rastreamento.dart';

import '../fakes.dart';

void main() {
  late GpsFake gps;
  late PreferenciasFake preferencias;
  late LocalizacaoRepositoryImpl repository;

  setUp(() {
    gps = GpsFake();
    preferencias = PreferenciasFake();
    repository = LocalizacaoRepositoryImpl(gps, preferencias);
  });

  group('AtivarRastreamento', () {
    test('liga a localização quando o celular permite', () async {
      final resultado = await AtivarRastreamento(repository)(const NoParams());

      expect(
        resultado,
        isA<Success<PermissaoLocalizacao>>().having(
          (s) => s.value,
          'value',
          PermissaoLocalizacao.concedida,
        ),
      );
      expect(preferencias.ativado, isTrue);
    });

    test('continua desligada quando a permissão é negada', () async {
      gps.resposta = PermissaoLocalizacao.negadaParaSempre;

      final resultado = await AtivarRastreamento(repository)(const NoParams());

      expect(
        (resultado as Success<PermissaoLocalizacao>).value,
        PermissaoLocalizacao.negadaParaSempre,
      );
      expect(preferencias.ativado, isFalse);
    });
  });

  group('AcompanharPosicao', () {
    test('com a localização desligada, não liga o GPS', () async {
      final posicoes = await AcompanharPosicao(repository)().toList();

      expect(posicoes, isEmpty);
      expect(gps.ligado, isFalse);
    });

    test('com a localização ligada, emite as posições do GPS', () async {
      preferencias.ativado = true;

      final primeira = AcompanharPosicao(repository)().first;
      await pumpEventQueue();
      expect(gps.ligado, isTrue);
      gps.controlador.add(posicaoDeTeste);

      expect((await primeira as Success).value, same(posicaoDeTeste));
    });
  });
}
