import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/services/environmentService.dart';
import '../domain/models/environmentalData.dart';

final environmentServiceProvider =
    Provider((ref) => EnvironmentService());

final environmentProvider =
    StreamProvider<EnvironmentalData>((ref) async* {
  final service = ref.watch(environmentServiceProvider);

  while (true) {
    try {
      final data = await service.getEnvironmentalData(
        latitude: -10.9472,
        longitude: -37.0731,
      );

      yield data;
    } catch (error) {
      throw Exception('Não foi possível atualizar os dados ambientais.');
    }

    await Future.delayed(const Duration(minutes: 5));
  }
});
