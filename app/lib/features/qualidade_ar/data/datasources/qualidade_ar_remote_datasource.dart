import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../core/error/exceptions.dart';
import '../../domain/entities/localizacao.dart';
import '../models/qualidade_ar_model.dart';

/// Busca a qualidade do ar na API da Open-Meteo (dados do CAMS).
///
/// Atribuição obrigatória da fonte: Open-Meteo e CAMS ENSEMBLE.
abstract interface class QualidadeArRemoteDataSource {
  /// Lança [NetworkException] sem conexão ou por timeout, e
  /// [ServerException] quando a API responde com erro ou formato inesperado.
  Future<QualidadeArModel> buscar(Localizacao localizacao);
}

class QualidadeArRemoteDataSourceImpl implements QualidadeArRemoteDataSource {
  QualidadeArRemoteDataSourceImpl(
    this._client, {
    this.timeout = const Duration(seconds: 10),
  });

  final http.Client _client;
  final Duration timeout;

  @override
  Future<QualidadeArModel> buscar(Localizacao localizacao) async {
    final uri = Uri.https('air-quality-api.open-meteo.com', '/v1/air-quality', {
      'latitude': '${localizacao.latitude}',
      'longitude': '${localizacao.longitude}',
      'current': 'us_aqi,pm2_5',
    });

    final http.Response resposta;
    try {
      resposta = await _client.get(uri).timeout(timeout);
    } on TimeoutException {
      throw const NetworkException('A API demorou demais para responder.');
    } catch (_) {
      throw const NetworkException();
    }

    if (resposta.statusCode != 200) {
      throw ServerException(
        'A API de qualidade do ar respondeu com erro ${resposta.statusCode}.',
        resposta.statusCode,
      );
    }

    try {
      final json = jsonDecode(resposta.body) as Map<String, dynamic>;
      return QualidadeArModel.fromOpenMeteo(json);
    } catch (_) {
      throw const ServerException('A resposta da API veio em formato inesperado.');
    }
  }
}
