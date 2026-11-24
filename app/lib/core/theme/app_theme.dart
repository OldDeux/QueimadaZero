import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Tema claro de alto contraste, para uso sob sol e fumaça.
///
/// Decisões (ver `docs/justificativas.md`):
/// * texto preto sobre fundo claro e botões em laranja escuro com texto branco;
/// * informação principal em negrito e tamanhos mínimos de 12px;
/// * áreas de toque grandes (botões com 56px de altura).
abstract final class AppTheme {
  /// Altura mínima dos botões principais.
  static const alturaBotao = 56.0;

  /// Fonte do app, incluída em `assets/fonts/` para funcionar offline.
  static const fonte = 'Manrope';

  static ThemeData get claro {
    const esquema = ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.laranjaEscuro,
      onPrimary: AppColors.branco,
      primaryContainer: Color(0xFFFFE4D6),
      onPrimaryContainer: AppColors.preto,
      secondary: AppColors.preto,
      onSecondary: AppColors.branco,
      tertiary: AppColors.verde,
      onTertiary: AppColors.branco,
      error: AppColors.vermelho,
      onError: AppColors.branco,
      surface: AppColors.fundo,
      onSurface: AppColors.preto,
      onSurfaceVariant: AppColors.cinza,
      outline: AppColors.cinza,
      outlineVariant: Color(0xFFD6D3D1),
    );

    const textos = TextTheme(
      headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
      titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
      titleMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
      bodyLarge: TextStyle(fontSize: 16),
      bodyMedium: TextStyle(fontSize: 15),
      labelLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
      labelMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
      bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
    );

    final base = ThemeData(
      useMaterial3: true,
      fontFamily: fonte,
      colorScheme: esquema,
      scaffoldBackgroundColor: AppColors.fundo,
      textTheme: textos,
    );

    final formaBotao = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    );

    return base.copyWith(
      textTheme: base.textTheme.apply(
        bodyColor: AppColors.preto,
        displayColor: AppColors.preto,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.branco,
        foregroundColor: AppColors.preto,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 1,
        centerTitle: false,
        titleTextStyle: TextStyle(
          fontFamily: fonte,
          color: AppColors.preto,
          fontSize: 20,
          fontWeight: FontWeight.w800,
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size.fromHeight(alturaBotao),
          shape: formaBotao,
          textStyle: textos.labelLarge,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size.fromHeight(alturaBotao),
          foregroundColor: AppColors.preto,
          side: const BorderSide(color: AppColors.preto, width: 2),
          shape: formaBotao,
          textStyle: textos.labelLarge,
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppColors.branco,
        indicatorColor: const Color(0xFFFFE4D6),
        surfaceTintColor: Colors.transparent,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        iconTheme: WidgetStateProperty.resolveWith(
          (estados) => IconThemeData(
            color: estados.contains(WidgetState.selected)
                ? AppColors.laranjaEscuro
                : AppColors.preto,
          ),
        ),
        labelTextStyle: WidgetStateProperty.resolveWith(
          (estados) => TextStyle(
            fontFamily: fonte,
            fontSize: 12,
            color: AppColors.preto,
            // Com 700 ou mais, "Qualidade do ar" quebra de linha em celulares
            // de 375px (ver app_shell_test.dart). A aba selecionada também
            // se destaca pelo ícone laranja e pelo fundo do indicador.
            fontWeight: estados.contains(WidgetState.selected)
                ? FontWeight.w600
                : FontWeight.w500,
          ),
        ),
      ),
      cardTheme: const CardThemeData(
        color: AppColors.branco,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Color(0xFFD6D3D1)),
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
      listTileTheme: const ListTileThemeData(
        iconColor: AppColors.laranjaEscuro,
        subtitleTextStyle: TextStyle(
          fontFamily: fonte,
          fontSize: 15,
          color: AppColors.cinza,
        ),
      ),
    );
  }
}
