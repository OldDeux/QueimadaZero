import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/qualidade_ar.dart';

/// "Cor do céu" de cada nível de qualidade do ar, usada no card da Home.
///
/// Segue a paleta de `docs/justificativas.md`: o verde só aparece para o ar
/// bom, e quanto pior o ar, mais o céu vai do laranja para o vermelho e o
/// escuro. O texto de cada nível tem contraste AA (4,5:1) com as duas cores
/// do gradiente (ver `cores_do_ceu_test.dart`).
extension CoresDoCeu on NivelQualidadeAr {
  /// Gradiente do fundo do card, de cima para baixo.
  List<Color> get ceu => switch (this) {
    NivelQualidadeAr.boa => const [Color(0xFFE3F2EA), Color(0xFFC9E7D6)],
    NivelQualidadeAr.moderada => const [Color(0xFFFFF4D1), Color(0xFFFFE5A3)],
    NivelQualidadeAr.ruimParaSensiveis => const [
      Color(0xFFFFE4D6),
      Color(0xFFFDBA74),
    ],
    NivelQualidadeAr.ruim => const [Color(0xFFFB923C), AppColors.laranja],
    NivelQualidadeAr.muitoRuim => const [
      AppColors.vermelho,
      Color(0xFFAD1F17),
    ],
    NivelQualidadeAr.perigosa => const [Color(0xFF7A1410), AppColors.preto],
  };

  /// Cor dos textos e ícones sobre o céu desse nível.
  Color get texto => switch (this) {
    NivelQualidadeAr.muitoRuim ||
    NivelQualidadeAr.perigosa => AppColors.branco,
    _ => AppColors.preto,
  };
}
