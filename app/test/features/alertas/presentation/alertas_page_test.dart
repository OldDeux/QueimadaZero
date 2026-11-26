import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:queimada_zero/features/alertas/presentation/pages/alertas_page.dart';

void main() {
  testWidgets('mostra o estado vazio dos alertas', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: AlertasPage()));

    expect(find.text('Nenhum alerta recebido'), findsOneWidget);
    expect(
      find.text('Os alertas automáticos ainda estão em desenvolvimento.'),
      findsOneWidget,
    );
  });

  testWidgets('tela de alertas funciona em largura de celular', (tester) async {
    await tester.binding.setSurfaceSize(const Size(320, 640));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(const MaterialApp(home: AlertasPage()));
    expect(find.text('Nenhum alerta recebido'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
