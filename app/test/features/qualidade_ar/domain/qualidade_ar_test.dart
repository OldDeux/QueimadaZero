import 'package:flutter_test/flutter_test.dart';
import 'package:queimada_zero/core/error/failures.dart';
import 'package:queimada_zero/core/result.dart';
import 'package:queimada_zero/features/qualidade_ar/domain/entities/localizacao.dart';
import 'package:queimada_zero/features/qualidade_ar/domain/entities/qualidade_ar.dart';
import 'package:queimada_zero/features/qualidade_ar/domain/repositories/qualidade_ar_repository.dart';
import 'package:queimada_zero/features/qualidade_ar/domain/usecases/buscar_qualidade_ar.dart';

const _aracaju = Localizacao(cidade: 'Aracaju', latitude: -10.9, longitude: -37);

class _RepositorioFalso implements QualidadeArRepository {
  _RepositorioFalso(this.resposta);

  final Result<QualidadeAr> resposta;
  Localizacao? consultada;

  @override
  Future<Result<QualidadeAr>> buscarAtual(Localizacao localizacao) async {
    consultada = localizacao;
    return resposta;
  }
}

void main() {
  test('o nível segue as faixas do US AQI', () {
    expect(NivelQualidadeAr.doIndice(0), NivelQualidadeAr.boa);
    expect(NivelQualidadeAr.doIndice(50), NivelQualidadeAr.boa);
    expect(NivelQualidadeAr.doIndice(51), NivelQualidadeAr.moderada);
    expect(NivelQualidadeAr.doIndice(100), NivelQualidadeAr.moderada);
    expect(NivelQualidadeAr.doIndice(150), NivelQualidadeAr.ruimParaSensiveis);
    expect(NivelQualidadeAr.doIndice(200), NivelQualidadeAr.ruim);
    expect(NivelQualidadeAr.doIndice(300), NivelQualidadeAr.muitoRuim);
    expect(NivelQualidadeAr.doIndice(301), NivelQualidadeAr.perigosa);
  });

  test('busca a qualidade do ar da localização informada', () async {
    final qualidade = QualidadeAr(
      indice: 78,
      pm25: 24.5,
      atualizadoEm: DateTime.utc(2026, 11, 24, 17),
    );
    final repositorio = _RepositorioFalso(Success(qualidade));

    final resultado = await BuscarQualidadeAr(repositorio)(_aracaju);

    expect((resultado as Success<QualidadeAr>).value, qualidade);
    expect(repositorio.consultada, _aracaju);
  });

  test('repassa a falha do repositório', () async {
    final buscar = BuscarQualidadeAr(
      _RepositorioFalso(const Failed(NetworkFailure())),
    );

    final resultado = await buscar(_aracaju);

    expect((resultado as Failed<QualidadeAr>).failure, isA<NetworkFailure>());
  });
}
