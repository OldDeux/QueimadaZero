import 'dart:async';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/result.dart';
import '../../domain/entities/permissao_localizacao.dart';
import '../../domain/entities/posicao.dart';
import '../../domain/repositories/localizacao_repository.dart';
import '../datasources/gps_datasource.dart';
import '../datasources/preferencias_localizacao_datasource.dart';

/// Implementação do [LocalizacaoRepository] que converte exceções em falhas.
class LocalizacaoRepositoryImpl implements LocalizacaoRepository {
  const LocalizacaoRepositoryImpl(this._gps, this._preferencias);

  final GpsDataSource _gps;
  final PreferenciasLocalizacaoDataSource _preferencias;

  @override
  Future<Result<bool>> rastreamentoAtivado() =>
      _tentar(_preferencias.rastreamentoAtivado);

  @override
  Future<Result<void>> salvarRastreamento(bool ativado) =>
      _tentar(() => _preferencias.salvarRastreamento(ativado));

  @override
  Future<Result<PermissaoLocalizacao>> pedirPermissao() =>
      _tentar(_gps.pedirPermissao);

  @override
  Stream<Result<Posicao>> acompanharPosicao() {
    return _gps
        .acompanharPosicao()
        .map<Result<Posicao>>(Success.new)
        .transform(
          StreamTransformer.fromHandlers(
            handleError: (erro, _, saida) => saida.add(Failed(_falha(erro))),
          ),
        );
  }

  @override
  Future<bool> abrirAjustes(PermissaoLocalizacao motivo) async {
    try {
      return motivo == PermissaoLocalizacao.gpsDesligado
          ? await _gps.abrirAjustesDoGps()
          : await _gps.abrirAjustesDoApp();
    } catch (_) {
      return false;
    }
  }

  Future<Result<T>> _tentar<T>(Future<T> Function() acao) async {
    try {
      return Success(await acao());
    } catch (erro) {
      return Failed(_falha(erro));
    }
  }

  static Failure _falha(Object erro) => switch (erro) {
    LocalizacaoException(:final message) => LocalizacaoFailure(message),
    CacheException(:final message) => CacheFailure(message),
    _ => const UnexpectedFailure(),
  };
}
