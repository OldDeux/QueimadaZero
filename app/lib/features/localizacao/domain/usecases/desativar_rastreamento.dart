import '../../../../core/result.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/localizacao_repository.dart';

/// Desliga a localização. Vale na hora, inclusive para os alertas.
class DesativarRastreamento implements UseCase<void, NoParams> {
  const DesativarRastreamento(this._repository);

  final LocalizacaoRepository _repository;

  @override
  Future<Result<void>> call(NoParams params) =>
      _repository.salvarRastreamento(false);
}
