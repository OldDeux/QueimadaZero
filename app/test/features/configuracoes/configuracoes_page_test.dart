import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:queimada_zero/app.dart';
import 'package:queimada_zero/features/localizacao/domain/entities/permissao_localizacao.dart';
import 'package:queimada_zero/features/localizacao/presentation/providers/localizacao_providers.dart';
import 'package:queimada_zero/main.dart';

import '../localizacao/fakes.dart';

late GpsFake _gps;
late PreferenciasFake _preferencias;

Future<void> _abrirConfiguracoes(WidgetTester tester) async {
  // Tela de celular, como no protótipo.
  tester.view.physicalSize = const Size(375 * 3, 812 * 3);
  tester.view.devicePixelRatio = 3;
  addTearDown(tester.view.reset);

  await tester.pumpWidget(
    ProviderScope(
      retry: semNovaTentativa,
      overrides: [
        gpsDataSourceProvider.overrideWithValue(_gps),
        preferenciasLocalizacaoDataSourceProvider.overrideWithValue(
          _preferencias,
        ),
      ],
      child: const QueimadaZeroApp(),
    ),
  );
  await tester.pumpAndSettle();
  await tester.tap(find.byTooltip('Configurações'));
  await tester.pumpAndSettle();
}

Finder get _interruptor => find.byType(Switch);

Future<void> _tocar(WidgetTester tester, String texto) async {
  await tester.ensureVisible(find.text(texto));
  await tester.tap(find.text(texto));
  await tester.pumpAndSettle();
}

bool _ligado(WidgetTester tester) => tester.widget<Switch>(_interruptor).value;

void main() {
  setUp(() {
    _gps = GpsFake();
    _preferencias = PreferenciasFake();
  });

  testWidgets('ligar explica antes de pedir e mostra a precisão do GPS', (
    tester,
  ) async {
    await _abrirConfiguracoes(tester);
    expect(_ligado(tester), isFalse);

    await tester.tap(_interruptor);
    await tester.pumpAndSettle();
    expect(find.text('Ative sua localização para receber alertas'), findsOne);
    expect(_gps.pedidosDePermissao, 0);

    await _tocar(tester, 'Permitir localização');
    expect(_ligado(tester), isTrue);
    expect(_preferencias.ativado, isTrue);
    expect(find.text('Procurando o sinal do GPS…'), findsOne);

    _gps.controlador.add(posicaoDeTeste);
    await tester.pumpAndSettle();
    expect(find.text('Localização ativa · precisão de 12 m'), findsOne);
  });

  testWidgets('desligar para o GPS na hora e salva a escolha', (tester) async {
    _preferencias.ativado = true;
    await _abrirConfiguracoes(tester);
    expect(_gps.ligado, isTrue);

    await tester.tap(_interruptor);
    await tester.pumpAndSettle();

    expect(_ligado(tester), isFalse);
    expect(_gps.ligado, isFalse);
    expect(_preferencias.ativado, isFalse);
  });

  testWidgets('"Agora não" mantém desligada sem pedir permissão', (
    tester,
  ) async {
    await _abrirConfiguracoes(tester);

    await tester.tap(_interruptor);
    await tester.pumpAndSettle();
    await _tocar(tester, 'Agora não');

    expect(_ligado(tester), isFalse);
    expect(_gps.pedidosDePermissao, 0);
  });

  testWidgets('permissão bloqueada explica e abre os ajustes do celular', (
    tester,
  ) async {
    _gps.resposta = PermissaoLocalizacao.negadaParaSempre;
    await _abrirConfiguracoes(tester);

    await tester.tap(_interruptor);
    await tester.pumpAndSettle();
    await _tocar(tester, 'Permitir localização');

    expect(find.textContaining('bloqueou a localização'), findsOne);
    await _tocar(tester, 'Abrir ajustes do celular');
    expect(_gps.ajustesAbertos, ['app']);
    expect(_preferencias.ativado, isFalse);
  });
}
