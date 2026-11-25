import '../../../../core/result.dart';
import '../entities/localizacao.dart';
import '../entities/qualidade_ar.dart';

/// Contrato do repositório de qualidade do ar.
abstract interface class QualidadeArRepository {
  Future<Result<QualidadeAr>> buscarAtual(Localizacao localizacao);
}
