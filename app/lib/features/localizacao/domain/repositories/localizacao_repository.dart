import '../../../../core/result.dart';
import '../entities/permissao_localizacao.dart';
import '../entities/posicao.dart';

/// Contrato de acesso ao GPS e à escolha da pessoa sobre a localização.
abstract interface class LocalizacaoRepository {
  /// Se a pessoa deixou a localização ligada no app. Começa desligada.
  Future<Result<bool>> rastreamentoAtivado();

  Future<Result<void>> salvarRastreamento(bool ativado);

  /// Pede a permissão ao celular, se ainda não foi dada.
  Future<Result<PermissaoLocalizacao>> pedirPermissao();

  /// Posições do GPS enquanto houver alguém escutando.
  Stream<Result<Posicao>> acompanharPosicao();

  /// Abre os ajustes do celular para resolver o [motivo]: o GPS desligado
  /// ou a permissão negada de vez. Devolve `false` se não conseguir abrir.
  Future<bool> abrirAjustes(PermissaoLocalizacao motivo);
}
