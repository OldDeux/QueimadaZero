import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exceptions.dart';

/// Guarda no celular se a pessoa deixou a localização ligada.
abstract interface class PreferenciasLocalizacaoDataSource {
  Future<bool> rastreamentoAtivado();

  Future<void> salvarRastreamento(bool ativado);
}

/// [PreferenciasLocalizacaoDataSource] com o `shared_preferences`.
///
/// Usa a versão assíncrona, que lê sempre o valor gravado no celular. Assim,
/// os alertas em segundo plano enxergam a escolha mais recente, mesmo
/// rodando fora da tela.
class SharedPreferencesLocalizacaoDataSource
    implements PreferenciasLocalizacaoDataSource {
  const SharedPreferencesLocalizacaoDataSource();

  static const chave = 'localizacao.rastreamento_ativado';

  @override
  Future<bool> rastreamentoAtivado() async {
    try {
      return await SharedPreferencesAsync().getBool(chave) ?? false;
    } catch (_) {
      throw const CacheException('Não foi possível ler sua escolha.');
    }
  }

  @override
  Future<void> salvarRastreamento(bool ativado) async {
    try {
      await SharedPreferencesAsync().setBool(chave, ativado);
    } catch (_) {
      throw const CacheException('Não foi possível salvar sua escolha.');
    }
  }
}
