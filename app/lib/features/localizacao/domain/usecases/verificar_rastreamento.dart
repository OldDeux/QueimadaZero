import '../../../../core/result.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/localizacao_repository.dart';

/// Diz se a pessoa deixou a localização ligada.
///
/// Todo código que usa a posição deve chamar este caso de uso antes,
/// inclusive os alertas em segundo plano (#21 e #22). A escolha fica salva
/// no celular e vale mesmo com o app fechado.
class VerificarRastreamento implements UseCase<bool, NoParams> {
  const VerificarRastreamento(this._repository);

  final LocalizacaoRepository _repository;

  @override
  Future<Result<bool>> call(NoParams params) =>
      _repository.rastreamentoAtivado();
}
