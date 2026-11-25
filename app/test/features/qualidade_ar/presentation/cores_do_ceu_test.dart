import 'package:flutter_test/flutter_test.dart';
import 'package:queimada_zero/features/qualidade_ar/domain/entities/qualidade_ar.dart';
import 'package:queimada_zero/features/qualidade_ar/presentation/widgets/cores_do_ceu.dart';

import '../../../core/theme/app_theme_test.dart' show contraste;

void main() {
  // O card fica na Home e é lido no sol: o texto de todo nível precisa de
  // contraste AA (4,5:1) com as duas pontas do gradiente.
  for (final nivel in NivelQualidadeAr.values) {
    test('texto do nível "${nivel.rotulo}" tem contraste AA com o céu', () {
      for (final cor in nivel.ceu) {
        expect(contraste(nivel.texto, cor), greaterThanOrEqualTo(4.5));
      }
    });
  }
}
