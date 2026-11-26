import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:queimada_zero/core/theme/app_theme.dart';
import 'package:queimada_zero/features/denuncia/presentation/pages/relatar_page.dart';

Future<void> _abrir(WidgetTester tester) async {
  await tester.pumpWidget(
    MaterialApp(theme: AppTheme.claro, home: const RelatarPage()),
  );
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('mostra as etapas do relato de fumaça', (tester) async {
    await _abrir(tester);

    expect(find.text('1. Foto da ocorrência'), findsOneWidget);
    expect(find.text('2. Localização'), findsOneWidget);
    expect(find.text('3. Descrição (opcional)'), findsOneWidget);
  });

  testWidgets('não permite tirar foto nem enviar antes da integração', (
    tester,
  ) async {
    await _abrir(tester);

    expect(find.text('Adicionar foto (em breve)'), findsOneWidget);
    expect(find.text('Enviar relato (em breve)'), findsOneWidget);

    final botaoFoto = tester.widget<OutlinedButton>(
      find.byWidgetPredicate((widget) => widget is OutlinedButton),
    );
    final botaoEnviar = tester.widget<FilledButton>(
      find.byWidgetPredicate((widget) => widget is FilledButton),
    );
    expect(botaoFoto.onPressed, isNull);
    expect(botaoEnviar.onPressed, isNull);
  });

  testWidgets('permite preencher a descrição opcional localmente', (
    tester,
  ) async {
    await _abrir(tester);

    await tester.ensureVisible(find.byType(TextField));
    await tester.enterText(find.byType(TextField), 'Fumaça perto de casa');

    expect(find.text('Fumaça perto de casa'), findsOneWidget);
  });

  testWidgets('tela funciona em um celular de 320px', (tester) async {
    tester.view.physicalSize = const Size(320 * 3, 640 * 3);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);

    await _abrir(tester);
    await tester.drag(find.byType(ListView), const Offset(0, -1000));
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
  });
}
