import '../../../../core/result.dart';
import '../entities/posicao.dart';
import '../repositories/localizacao_repository.dart';

/// Posição em tempo real, só se a localização estiver ligada.
///
/// Com a localização desligada, o GPS nem é acionado e nada é emitido.
/// Não segue o contrato `UseCase` porque devolve um fluxo, e não um valor.
class AcompanharPosicao {
  const AcompanharPosicao(this._repository);

  final LocalizacaoRepository _repository;

  Stream<Result<Posicao>> call() async* {
    final ativado = await _repository.rastreamentoAtivado();
    switch (ativado) {
      case Success(value: true):
        yield* _repository.acompanharPosicao();
      case Success():
        return;
      case Failed(:final failure):
        yield Failed(failure);
    }
  }
}
