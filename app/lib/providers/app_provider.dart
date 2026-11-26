import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/services/environment_service.dart';
import '../domain/models/environmental_data.dart';

final environmentServiceProvider = Provider<EnvironmentService>((ref) {
  final service = EnvironmentService();
  ref.onDispose(service.dispose);
  return service;
});

/// Intervalo de atualização automática (polling) dos dados ambientais.
const Duration intervaloAtualizacaoAmbiental = Duration(minutes: 5);

/// Dados ambientais com atualização a cada 5 minutos.
///
/// Uma falha vira um estado de erro na interface, mas **não encerra** a
/// atualização: a próxima tentativa acontece normalmente no ciclo seguinte.
final environmentProvider = StreamProvider<EnvironmentalData>((ref) {
  final service = ref.watch(environmentServiceProvider);
  final controller = StreamController<EnvironmentalData>();

  Future<void> atualizar() async {
    try {
      final data = await service.getEnvironmentalData(
        latitude: -10.9472,
        longitude: -37.0731,
      );
      if (!controller.isClosed) controller.add(data);
    } on Object {
      if (!controller.isClosed) {
        controller.addError(
          Exception('Não foi possível atualizar os dados ambientais.'),
        );
      }
    }
  }

  unawaited(atualizar());
  final timer = Timer.periodic(
    intervaloAtualizacaoAmbiental,
    (_) => unawaited(atualizar()),
  );

  ref.onDispose(() {
    timer.cancel();
    unawaited(controller.close());
  });
  return controller.stream;
});
