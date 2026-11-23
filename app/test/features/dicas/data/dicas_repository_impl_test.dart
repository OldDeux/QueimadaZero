import 'package:flutter_test/flutter_test.dart';
import 'package:queimada_zero/core/error/exceptions.dart';
import 'package:queimada_zero/core/error/failures.dart';
import 'package:queimada_zero/core/result.dart';
import 'package:queimada_zero/features/dicas/data/datasources/dicas_local_datasource.dart';
import 'package:queimada_zero/features/dicas/data/models/dica_model.dart';
import 'package:queimada_zero/features/dicas/data/repositories/dicas_repository_impl.dart';
import 'package:queimada_zero/features/dicas/domain/entities/dica.dart';

class _FonteComErro implements DicasLocalDataSource {
  @override
  Future<List<DicaModel>> carregar() async =>
      throw const CacheException('arquivo corrompido');
}

void main() {
  test(
    'carrega as dicas da fonte local, incluindo as de grupo de risco',
    () async {
      const repositorio = DicasRepositoryImpl(DicasLocalDataSourceImpl());

      final resultado = await repositorio.listarDicas();

      final dicas = (resultado as Success<List<Dica>>).value;
      expect(dicas, isNotEmpty);
      expect(dicas.where((d) => d.grupoDeRisco), isNotEmpty);
    },
  );

  test('converte CacheException em CacheFailure sem quebrar', () async {
    final repositorio = DicasRepositoryImpl(_FonteComErro());

    final resultado = await repositorio.listarDicas();

    final failure = (resultado as Failed<List<Dica>>).failure;
    expect(failure, isA<CacheFailure>());
    expect(failure.message, 'arquivo corrompido');
  });

  test('DicaModel lê e grava JSON', () {
    final model = DicaModel.fromJson(const {'titulo': 'A', 'descricao': 'B'});

    expect(model.grupoDeRisco, isFalse);
    expect(model.toJson(), {
      'titulo': 'A',
      'descricao': 'B',
      'grupoDeRisco': false,
    });
  });
}
