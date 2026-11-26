import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../domain/models/environmental_data.dart';

/// Falha ao obter os dados ambientais (rede, timeout, erro HTTP ou resposta
/// inesperada). A interface mostra um estado de erro amigável em vez de quebrar.
class EnvironmentServiceException implements Exception {
  const EnvironmentServiceException(this.message, {this.statusCode});

  final String message;
  final int? statusCode;

  @override
  String toString() => 'EnvironmentServiceException: $message';
}

/// Busca qualidade do ar (US AQI e MP2.5) e vento na Open-Meteo.
///
/// - Qualidade do ar: air-quality-api.open-meteo.com (dados CAMS).
/// - Vento: api.open-meteo.com. A direção é meteorológica, ou seja, de ONDE o
///   vento sopra (0° = vem do norte), a velocidade vem em m/s.
///
/// Atribuição obrigatória da fonte: Open-Meteo e CAMS ENSEMBLE.
class EnvironmentService {
  EnvironmentService({
    http.Client? client,
    this.timeout = const Duration(seconds: 10),
  }) : _client = client ?? http.Client();

  final http.Client _client;
  final Duration timeout;

  Future<EnvironmentalData> getEnvironmentalData({
    required double latitude,
    required double longitude,
  }) async {
    final airUri = Uri.https(
      'air-quality-api.open-meteo.com',
      '/v1/air-quality',
      {
        'latitude': '$latitude',
        'longitude': '$longitude',
        'current': 'us_aqi,pm2_5',
      },
    );
    final windUri = Uri.https('api.open-meteo.com', '/v1/forecast', {
      'latitude': '$latitude',
      'longitude': '$longitude',
      'current': 'wind_speed_10m,wind_direction_10m',
      'wind_speed_unit': 'ms',
    });

    final results = await Future.wait([_getJson(airUri), _getJson(windUri)]);

    try {
      final air = results[0]['current'] as Map<String, dynamic>;
      final wind = results[1]['current'] as Map<String, dynamic>;

      return EnvironmentalData(
        aqi: (air['us_aqi'] as num).toDouble(),
        pm25: (air['pm2_5'] as num).toDouble(),
        windSpeed: (wind['wind_speed_10m'] as num).toDouble(),
        windDirection: (wind['wind_direction_10m'] as num).toDouble(),
        updatedAt: _parseUtc(air['time'] as String),
      );
    } on Object {
      throw const EnvironmentServiceException(
        'A resposta da API veio em formato inesperado.',
      );
    }
  }

  Future<Map<String, dynamic>> _getJson(Uri uri) async {
    try {
      final response = await _client.get(uri).timeout(timeout);
      if (response.statusCode != 200) {
        throw EnvironmentServiceException(
          'O servidor respondeu com erro ${response.statusCode}.',
          statusCode: response.statusCode,
        );
      }
      final decoded = jsonDecode(response.body);
      if (decoded is! Map<String, dynamic>) {
        throw const EnvironmentServiceException('Resposta inválida da API.');
      }
      return decoded;
    } on EnvironmentServiceException {
      rethrow;
    } on TimeoutException {
      throw const EnvironmentServiceException(
        'A API demorou demais para responder.',
      );
    } on Object {
      throw const EnvironmentServiceException(
        'Sem conexão ou resposta inválida da API.',
      );
    }
  }

  /// A Open-Meteo devolve a hora em UTC, sem sufixo "Z", por padrão.
  DateTime _parseUtc(String raw) =>
      DateTime.parse(raw.endsWith('Z') ? raw : '${raw}Z');

  void dispose() => _client.close();
}
