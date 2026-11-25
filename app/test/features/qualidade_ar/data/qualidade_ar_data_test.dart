import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:queimada_zero/core/error/exceptions.dart';
import 'package:queimada_zero/core/error/failures.dart';
import 'package:queimada_zero/core/result.dart';
import 'package:queimada_zero/features/qualidade_ar/data/datasources/qualidade_ar_remote_datasource.dart';
import 'package:queimada_zero/features/qualidade_ar/data/models/qualidade_ar_model.dart';
import 'package:queimada_zero/features/qualidade_ar/data/repositories/qualidade_ar_repository_impl.dart';
import 'package:queimada_zero/features/qualidade_ar/domain/entities/localizacao.dart';
import 'package:queimada_zero/features/qualidade_ar/domain/entities/qualidade_ar.dart';

const _aracaju = Localizacao(
  cidade: 'Aracaju',
  latitude: -10.9472,
  longitude: -37.0731,
);

const _respostaOk = '''
{
  "latitude": -10.9,
  "longitude": -37.1,
  "current": {"time": "2026-11-24T17:00", "interval": 3600, "us_aqi": 78, "pm2_5": 24.5}
}
''';

QualidadeArRemoteDataSourceImpl _fonte(MockClientHandler handler) =>
    QualidadeArRemoteDataSourceImpl(
      MockClient(handler),
      timeout: const Duration(milliseconds: 50),
    );

class _FonteComErro implements QualidadeArRemoteDataSource {
  _FonteComErro(this.erro);

  final Object erro;

  @override
  Future<QualidadeArModel> buscar(Localizacao localizacao) async => throw erro;
}

void main() {
  group('QualidadeArRemoteDataSource', () {
    test('lê o índice, o MP2.5 e o horário em UTC da Open-Meteo', () async {
      Uri? chamada;
      final fonte = _fonte((request) async {
        chamada = request.url;
        return http.Response(_respostaOk, 200);
      });

      final qualidade = await fonte.buscar(_aracaju);

      expect(qualidade.indice, 78);
      expect(qualidade.pm25, 24.5);
      expect(qualidade.atualizadoEm, DateTime.utc(2026, 11, 24, 17));
      expect(chamada!.host, 'air-quality-api.open-meteo.com');
      expect(chamada!.queryParameters['latitude'], '-10.9472');
      expect(chamada!.queryParameters['current'], 'us_aqi,pm2_5');
    });

    test('erro HTTP vira ServerException', () async {
      final fonte = _fonte((_) async => http.Response('erro', 503));

      expect(
        () => fonte.buscar(_aracaju),
        throwsA(
          isA<ServerException>().having((e) => e.statusCode, 'status', 503),
        ),
      );
    });

    test('resposta em formato inesperado vira ServerException', () async {
      final fonte = _fonte((_) async => http.Response('{"current": {}}', 200));

      expect(() => fonte.buscar(_aracaju), throwsA(isA<ServerException>()));
    });

    test('sem conexão vira NetworkException', () async {
      final fonte = _fonte((_) async => throw http.ClientException('offline'));

      expect(() => fonte.buscar(_aracaju), throwsA(isA<NetworkException>()));
    });

    test('demora acima do timeout vira NetworkException', () async {
      final fonte = _fonte((_) => Completer<http.Response>().future);

      expect(() => fonte.buscar(_aracaju), throwsA(isA<NetworkException>()));
    });
  });

  group('QualidadeArRepositoryImpl', () {
    test('devolve a qualidade do ar da fonte', () async {
      final fonte = _fonte((_) async => http.Response(_respostaOk, 200));

      final resultado = await QualidadeArRepositoryImpl(
        fonte,
      ).buscarAtual(_aracaju);

      expect((resultado as Success<QualidadeAr>).value.indice, 78);
    });

    test('converte as exceções em falhas sem quebrar', () async {
      Future<Failure> falhaDe(Object erro) async {
        final resultado = await QualidadeArRepositoryImpl(
          _FonteComErro(erro),
        ).buscarAtual(_aracaju);
        return (resultado as Failed<QualidadeAr>).failure;
      }

      expect(await falhaDe(const NetworkException()), isA<NetworkFailure>());
      expect(await falhaDe(const ServerException()), isA<ServerFailure>());
      expect(await falhaDe(StateError('x')), isA<UnexpectedFailure>());
    });
  });
}
