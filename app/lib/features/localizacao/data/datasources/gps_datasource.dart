import 'dart:async';

import 'package:geolocator/geolocator.dart';

import '../../../../core/error/exceptions.dart';
import '../../domain/entities/permissao_localizacao.dart';
import '../../domain/entities/posicao.dart';

/// Acesso ao GPS do celular.
abstract interface class GpsDataSource {
  Future<PermissaoLocalizacao> pedirPermissao();

  /// Lança [LocalizacaoException] no fluxo se o GPS for desligado ou a
  /// permissão for retirada enquanto o app acompanha a posição.
  Stream<Posicao> acompanharPosicao();

  Future<bool> abrirAjustesDoApp();

  Future<bool> abrirAjustesDoGps();
}

/// [GpsDataSource] com o pacote `geolocator`.
class GeolocatorDataSource implements GpsDataSource {
  const GeolocatorDataSource();

  /// Só avisa de novo quando a pessoa anda pelo menos 10 metros, para
  /// economizar bateria.
  static const _configuracao = LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 10,
  );

  @override
  Future<PermissaoLocalizacao> pedirPermissao() async {
    if (!await Geolocator.isLocationServiceEnabled()) {
      return PermissaoLocalizacao.gpsDesligado;
    }
    var permissao = await Geolocator.checkPermission();
    if (permissao == LocationPermission.denied) {
      permissao = await Geolocator.requestPermission();
    }
    return switch (permissao) {
      LocationPermission.whileInUse ||
      LocationPermission.always => PermissaoLocalizacao.concedida,
      LocationPermission.deniedForever => PermissaoLocalizacao.negadaParaSempre,
      _ => PermissaoLocalizacao.negada,
    };
  }

  @override
  Stream<Posicao> acompanharPosicao() {
    return Geolocator.getPositionStream(locationSettings: _configuracao)
        .map(
          (posicao) => Posicao(
            latitude: posicao.latitude,
            longitude: posicao.longitude,
            precisaoMetros: posicao.accuracy,
            horario: posicao.timestamp,
          ),
        )
        .transform(
          StreamTransformer.fromHandlers(
            handleError: (erro, pilha, saida) =>
                saida.addError(_converter(erro), pilha),
          ),
        );
  }

  static AppException _converter(Object erro) => switch (erro) {
    LocationServiceDisabledException() => const LocalizacaoException(
      'O GPS do celular está desligado.',
    ),
    PermissionDeniedException() => const LocalizacaoException(
      'O app está sem permissão para usar a localização.',
    ),
    _ => const LocalizacaoException(),
  };

  @override
  Future<bool> abrirAjustesDoApp() => Geolocator.openAppSettings();

  @override
  Future<bool> abrirAjustesDoGps() => Geolocator.openLocationSettings();
}
