import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:queimada_zero/core/result.dart';
import 'package:queimada_zero/features/qualidade_ar/domain/entities/localizacao.dart';
import 'package:queimada_zero/features/qualidade_ar/domain/entities/qualidade_ar.dart';
import 'package:queimada_zero/features/qualidade_ar/domain/repositories/qualidade_ar_repository.dart';
import 'package:queimada_zero/features/qualidade_ar/presentation/providers/qualidade_ar_providers.dart';

class _QualidadeArFalsa implements QualidadeArRepository {
  const _QualidadeArFalsa();

  @override
  Future<Result<QualidadeAr>> buscarAtual(Localizacao localizacao) async =>
      Success(
        QualidadeAr(
          indice: 42,
          pm25: 10,
          atualizadoEm: DateTime.utc(2026, 11, 24, 12),
        ),
      );
}

/// Troca a API de qualidade do ar por um dado fixo, para os testes que
/// abrem o app inteiro não dependerem da internet.
final Override qualidadeArFalsa = qualidadeArRepositoryProvider
    .overrideWithValue(const _QualidadeArFalsa());
