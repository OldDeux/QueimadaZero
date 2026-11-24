import 'package:flutter/material.dart';

/// Paleta do QueimadaZero, definida em `docs/justificativas.md` (seção Cores).
abstract final class AppColors {
  /// Logo, ícones e destaques.
  static const laranja = Color(0xFFF05A28);

  /// Botões principais, como "Estou vendo fumaça". Mais escuro que o laranja
  /// para o texto branco ter contraste suficiente.
  static const laranjaEscuro = Color(0xFFC2410C);

  /// Risco crítico, alertas e ações destrutivas.
  static const vermelho = Color(0xFFD92D20);

  /// Textos e botões secundários.
  static const preto = Color(0xFF141414);

  /// Textos de apoio (horário, fonte, legenda).
  static const cinza = Color(0xFF5C5C5C);

  /// Só para "deu certo" e ar de boa qualidade.
  static const verde = Color(0xFF2F7D59);

  static const branco = Color(0xFFFFFFFF);

  /// Fundo das telas: branco levemente quente, para não ofuscar no sol.
  static const fundo = Color(0xFFFFFBF8);

  /// Gradiente obrigatório do mapa de calor: quanto mais vermelho, maior a
  /// concentração de focos.
  static const mapaDeCalor = [
    Color(0xFFFDBA74),
    laranja,
    laranjaEscuro,
    vermelho,
  ];
}
