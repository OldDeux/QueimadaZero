import 'dart:async';

import 'package:queimada_zero/features/localizacao/data/datasources/gps_datasource.dart';
import 'package:queimada_zero/features/localizacao/data/datasources/preferencias_localizacao_datasource.dart';
import 'package:queimada_zero/features/localizacao/domain/entities/permissao_localizacao.dart';
import 'package:queimada_zero/features/localizacao/domain/entities/posicao.dart';

final posicaoDeTeste = Posicao(
  latitude: -12.97111,
  longitude: -38.51083,
  precisaoMetros: 12,
  horario: DateTime(2026, 11, 26, 14, 32),
);

/// GPS de mentira: responde [resposta] ao pedido de permissão e emite as
/// posições pelo [controlador].
class GpsFake implements GpsDataSource {
  GpsFake({this.resposta = PermissaoLocalizacao.concedida}) {
    controlador = StreamController<Posicao>.broadcast(
      onListen: () => ligado = true,
      onCancel: () => ligado = false,
    );
  }

  PermissaoLocalizacao resposta;
  late final StreamController<Posicao> controlador;

  /// Se tem alguém escutando o GPS agora.
  bool ligado = false;
  int pedidosDePermissao = 0;
  final ajustesAbertos = <String>[];

  @override
  Future<PermissaoLocalizacao> pedirPermissao() async {
    pedidosDePermissao++;
    return resposta;
  }

  @override
  Stream<Posicao> acompanharPosicao() => controlador.stream;

  @override
  Future<bool> abrirAjustesDoApp() async {
    ajustesAbertos.add('app');
    return true;
  }

  @override
  Future<bool> abrirAjustesDoGps() async {
    ajustesAbertos.add('gps');
    return true;
  }
}

/// Preferências guardadas em memória.
class PreferenciasFake implements PreferenciasLocalizacaoDataSource {
  PreferenciasFake({this.ativado = false});

  bool ativado;

  @override
  Future<bool> rastreamentoAtivado() async => ativado;

  @override
  Future<void> salvarRastreamento(bool ativado) async {
    this.ativado = ativado;
  }
}
