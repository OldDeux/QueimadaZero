import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:queimada_zero/data/services/environment_service.dart';

const _air = {
  'current': {'time': '2026-11-22T21:00', 'us_aqi': 157, 'pm2_5': 62.4},
};
const _wind = {
  'current': {
    'time': '2026-11-22T21:00',
    'wind_speed_10m': 4.5,
    'wind_direction_10m': 90,
  },
};

http.Response _json(Object body, [int status = 200]) => http.Response(
  jsonEncode(body),
  status,
  headers: {'content-type': 'application/json'},
);

void main() {
  test('junta qualidade do ar e vento em um EnvironmentalData', () async {
    final client = MockClient((request) async {
      return request.url.host.startsWith('air-quality')
          ? _json(_air)
          : _json(_wind);
    });
    final service = EnvironmentService(client: client);

    final data = await service.getEnvironmentalData(
      latitude: -10.9,
      longitude: -37.0,
    );

    expect(data.aqi, 157);
    expect(data.pm25, 62.4);
    expect(data.windSpeed, 4.5);
    expect(data.windDirection, 90);
    expect(data.updatedAt, DateTime.utc(2026, 11, 22, 21));
    expect(data.airQualityLabel, 'Insalubre');
  });

  test('erro 500 vira EnvironmentServiceException (app não quebra)', () async {
    final client = MockClient((request) async => http.Response('erro', 500));
    final service = EnvironmentService(client: client);

    expect(
      service.getEnvironmentalData(latitude: 0, longitude: 0),
      throwsA(isA<EnvironmentServiceException>()),
    );
  });

  test('timeout vira EnvironmentServiceException', () async {
    final client = MockClient((request) async {
      await Future<void>.delayed(const Duration(milliseconds: 300));
      return _json(_air);
    });
    final service = EnvironmentService(
      client: client,
      timeout: const Duration(milliseconds: 20),
    );

    expect(
      service.getEnvironmentalData(latitude: 0, longitude: 0),
      throwsA(isA<EnvironmentServiceException>()),
    );
  });

  test(
    'resposta sem os campos esperados vira EnvironmentServiceException',
    () async {
      final client = MockClient((request) async => _json({'current': {}}));
      final service = EnvironmentService(client: client);

      expect(
        service.getEnvironmentalData(latitude: 0, longitude: 0),
        throwsA(isA<EnvironmentServiceException>()),
      );
    },
  );
}
