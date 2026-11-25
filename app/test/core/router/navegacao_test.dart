import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:queimada_zero/app.dart';
import 'package:queimada_zero/main.dart';

import '../../helpers/qualidade_ar_falsa.dart';

Future<void> _abrirApp(WidgetTester tester) async {
  await tester.pumpWidget(
    ProviderScope(
      retry: semNovaTentativa,
      overrides: [qualidadeArFalsa],
      child: const QueimadaZeroApp(),
    ),
  );
  await tester.pumpAndSettle();
}

Finder _titulo(String texto) => find.widgetWithText(AppBar, texto);

void main() {
  testWidgets('o app abre na Home com qualidade do ar e botão de relato', (
    tester,
  ) async {
    await _abrirApp(tester);

    expect(_titulo('QueimadaZero'), findsOneWidget);
    expect(find.text('QUALIDADE DO AR · ARACAJU'), findsOneWidget);
    expect(find.text('Estou vendo fumaça'), findsOneWidget);
  });

  testWidgets('o atalho da Home abre os alertas de proximidade', (
    tester,
  ) async {
    await _abrirApp(tester);

    await tester.tap(find.text('Alertas de proximidade'));
    await tester.pumpAndSettle();
    expect(_titulo('Alertas'), findsOneWidget);
  });

  testWidgets('o menu inferior troca entre as 4 abas', (tester) async {
    await _abrirApp(tester);

    await tester.tap(find.text('Meus relatos'));
    await tester.pumpAndSettle();
    expect(_titulo('Meus relatos'), findsOneWidget);

    await tester.tap(find.text('Qualidade do ar'));
    await tester.pumpAndSettle();
    expect(_titulo('Qualidade do ar'), findsOneWidget);

    await tester.tap(find.text('Orientações'));
    await tester.pumpAndSettle();
    expect(_titulo('Dicas respiratórias'), findsOneWidget);

    await tester.tap(find.text('Mapa'));
    await tester.pumpAndSettle();
    expect(_titulo('QueimadaZero'), findsOneWidget);
  });

  testWidgets('"Estou vendo fumaça" abre o relato e volta ao mapa', (
    tester,
  ) async {
    await _abrirApp(tester);

    await tester.tap(find.text('Estou vendo fumaça'));
    await tester.pumpAndSettle();
    expect(_titulo('Estou vendo fumaça'), findsOneWidget);
    expect(find.byType(NavigationBar), findsNothing);

    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();
    expect(_titulo('QueimadaZero'), findsOneWidget);
  });

  testWidgets('o sino abre os alertas e o ajuste abre as configurações', (
    tester,
  ) async {
    await _abrirApp(tester);

    await tester.tap(find.byTooltip('Alertas'));
    await tester.pumpAndSettle();
    expect(_titulo('Alertas'), findsOneWidget);

    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Configurações'));
    await tester.pumpAndSettle();
    expect(_titulo('Configurações'), findsOneWidget);
  });
}
