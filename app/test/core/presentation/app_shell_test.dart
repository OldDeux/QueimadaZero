import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:queimada_zero/app.dart';
import 'package:queimada_zero/core/theme/app_theme.dart';
import 'package:queimada_zero/main.dart';

import '../../helpers/qualidade_ar_falsa.dart';

const _rotulos = ['Mapa', 'Meus relatos', 'Qualidade do ar', 'Orientações'];

/// Carrega a Manrope de verdade: por padrão, os testes usam uma fonte
/// genérica, e a largura do texto não seria a mesma do app.
Future<void> _carregarManrope() async {
  final loader = FontLoader(AppTheme.fonte);
  for (final peso in ['Regular', 'Medium', 'SemiBold', 'Bold', 'ExtraBold']) {
    loader.addFont(rootBundle.load('assets/fonts/Manrope-$peso.ttf'));
  }
  await loader.load();
}

void main() {
  setUpAll(_carregarManrope);

  testWidgets('os rótulos do menu cabem em uma linha num celular de 375px', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(375 * 3, 812 * 3);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      ProviderScope(
        retry: semNovaTentativa,
        overrides: [qualidadeArFalsa],
        child: const QueimadaZeroApp(),
      ),
    );
    await tester.pumpAndSettle();

    // Seleciona cada aba, porque o rótulo selecionado fica mais largo.
    for (final selecionado in _rotulos) {
      await tester.tap(
        find.descendant(
          of: find.byType(NavigationBar),
          matching: find.text(selecionado),
        ),
      );
      await tester.pumpAndSettle();

      for (final rotulo in _rotulos) {
        final paragrafo = tester.renderObject<RenderParagraph>(
          find.descendant(
            of: find.byType(NavigationBar),
            matching: find.text(rotulo),
          ),
        );
        final linhas = paragrafo
            .getBoxesForSelection(
              TextSelection(baseOffset: 0, extentOffset: rotulo.length),
            )
            .map((caixa) => caixa.top)
            .toSet();
        expect(
          linhas.length,
          1,
          reason: '"$rotulo" quebrou de linha com "$selecionado" selecionado',
        );
      }
    }
  });
}
