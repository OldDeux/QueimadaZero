import '../../../../core/result.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/permissao_localizacao.dart';
import '../repositories/localizacao_repository.dart';

/// Pede a permissão e só liga a localização se o celular permitir.
///
/// Devolve a resposta do celular, para a tela explicar o que fazer quando a
/// permissão for negada ou o GPS estiver desligado.
class AtivarRastreamento implements UseCase<PermissaoLocalizacao, NoParams> {
  const AtivarRastreamento(this._repository);

  final LocalizacaoRepository _repository;

  @override
  Future<Result<PermissaoLocalizacao>> call(NoParams params) async {
    final resposta = await _repository.pedirPermissao();
    if (resposta case Success(value: PermissaoLocalizacao.concedida)) {
      final salvo = await _repository.salvarRastreamento(true);
      if (salvo case Failed(:final failure)) return Failed(failure);
    }
    return resposta;
  }
}
