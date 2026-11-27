import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:queimada_zero/features/denuncia/presentation/pages/meus_relatos_page.dart';

void main() {
  testWidgets('mostra estado vazio e explica os status', (tester) async {
    await tester.binding.setSurfaceSize(const Size(400, 950));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(const MaterialApp(home: MeusRelatosPage()));

    expect(find.text('Nenhum relato cadastrado'), findsOneWidget);
    expect(find.text('Enviado'), findsOneWidget);
    expect(find.text('Na fila'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('tela de relatos funciona em largura de celular', (tester) async {
    await tester.binding.setSurfaceSize(const Size(320, 640));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(const MaterialApp(home: MeusRelatosPage()));
    await tester.drag(find.byType(ListView), const Offset(0, -500));
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
  });
}
