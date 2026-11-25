import '../../../../core/result.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/localizacao.dart';
import '../entities/qualidade_ar.dart';
import '../repositories/qualidade_ar_repository.dart';

/// Busca a qualidade do ar atual de uma localização.
class BuscarQualidadeAr implements UseCase<QualidadeAr, Localizacao> {
  const BuscarQualidadeAr(this._repository);

  final QualidadeArRepository _repository;

  @override
  Future<Result<QualidadeAr>> call(Localizacao localizacao) =>
      _repository.buscarAtual(localizacao);
}
