import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:queimada_zero/core/theme/app_theme.dart';

/// Contraste entre duas cores pela fórmula da WCAG.
double contraste(Color a, Color b) {
  final la = a.computeLuminance();
  final lb = b.computeLuminance();
  return (max(la, lb) + 0.05) / (min(la, lb) + 0.05);
}

void main() {
  final cores = AppTheme.claro.colorScheme;

  // WCAG AA pede 4,5:1 para texto normal. O app é usado no sol, então os
  // pares principais precisam passar disso.
  test('texto dos botões principais tem contraste AA', () {
    expect(
      contraste(cores.primary, cores.onPrimary),
      greaterThanOrEqualTo(4.5),
    );
  });

  test('texto principal tem contraste AAA (7:1)', () {
    expect(contraste(cores.onSurface, cores.surface), greaterThanOrEqualTo(7));
  });

  test('textos de apoio e alertas têm contraste AA', () {
    expect(
      contraste(cores.onSurfaceVariant, cores.surface),
      greaterThanOrEqualTo(4.5),
    );
    expect(contraste(cores.error, cores.onError), greaterThanOrEqualTo(4.5));
  });

  test('textos usam a fonte Manrope do protótipo', () {
    final textos = AppTheme.claro.textTheme;
    expect(textos.bodyMedium!.fontFamily, AppTheme.fonte);
    expect(textos.headlineSmall!.fontFamily, AppTheme.fonte);
    expect(
      AppTheme.claro.appBarTheme.titleTextStyle!.fontFamily,
      AppTheme.fonte,
    );
  });

  test('botões principais têm área de toque grande', () {
    final estilo = AppTheme.claro.filledButtonTheme.style!;
    final tamanho = estilo.minimumSize!.resolve({})!;
    expect(tamanho.height, greaterThanOrEqualTo(48));
  });
}
