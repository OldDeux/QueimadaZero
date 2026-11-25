import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:queimada_zero/core/error/failures.dart';
import 'package:queimada_zero/core/result.dart';
import 'package:queimada_zero/core/theme/app_theme.dart';
import 'package:queimada_zero/features/qualidade_ar/domain/entities/localizacao.dart';
import 'package:queimada_zero/features/qualidade_ar/domain/entities/qualidade_ar.dart';
import 'package:queimada_zero/features/qualidade_ar/domain/repositories/qualidade_ar_repository.dart';
import 'package:queimada_zero/features/qualidade_ar/presentation/providers/qualidade_ar_providers.dart';
import 'package:queimada_zero/features/qualidade_ar/presentation/widgets/card_qualidade_ar.dart';
import 'package:queimada_zero/main.dart';

final _medicao = DateTime.utc(2026, 11, 24, 17, 32);

/// Hora que o card mostra para a medição, no fuso do computador do teste.
String get _horaMedicao {
  final local = _medicao.toLocal();
  return '${local.hour.toString().padLeft(2, '0')}:'
      '${local.minute.toString().padLeft(2, '0')}';
}

final _moderada = QualidadeAr(indice: 78, pm25: 24.5, atualizadoEm: _medicao);

/// Repositório falso que devolve as respostas na ordem, uma por chamada.
class _RepositorioFalso implements QualidadeArRepository {
  _RepositorioFalso(this.respostas);

  final List<Future<Result<QualidadeAr>>> respostas;
  int chamadas = 0;

  @override
  Future<Result<QualidadeAr>> buscarAtual(Localizacao localizacao) =>
      respostas[chamadas++];
}

Future<void> _abrir(WidgetTester tester, QualidadeArRepository repo) async {
  await tester.pumpWidget(
    ProviderScope(
      retry: semNovaTentativa,
      overrides: [qualidadeArRepositoryProvider.overrideWithValue(repo)],
      child: MaterialApp(
        theme: AppTheme.claro,
        home: const Scaffold(body: CardQualidadeAr()),
      ),
    ),
  );
}

void main() {
  testWidgets('mostra o carregamento e depois o índice com o horário', (
    tester,
  ) async {
    final resposta = Completer<Result<QualidadeAr>>();
    await _abrir(tester, _RepositorioFalso([resposta.future]));

    expect(find.text('Carregando a qualidade do ar...'), findsOneWidget);

    resposta.complete(Success(_moderada));
    await tester.pumpAndSettle();

    expect(find.text('78'), findsOneWidget);
    expect(find.text('Moderada'), findsOneWidget);
    expect(find.text('QUALIDADE DO AR · ARACAJU'), findsOneWidget);
    expect(
      find.text('Atualizado às $_horaMedicao · Fonte: Open-Meteo (CAMS)'),
      findsOneWidget,
    );
  });

  testWidgets('sem dado salvo, mostra o erro amigável e tenta de novo', (
    tester,
  ) async {
    final repo = _RepositorioFalso([
      Future.value(const Failed(NetworkFailure())),
      Future.value(Success(_moderada)),
    ]);
    await _abrir(tester, repo);
    await tester.pumpAndSettle();

    expect(find.text('Você está offline'), findsOneWidget);

    await tester.tap(find.text('Tentar novamente'));
    await tester.pumpAndSettle();

    expect(find.text('78'), findsOneWidget);
    expect(repo.chamadas, 2);
  });

  testWidgets('se a atualização falha, mantém o dado salvo com o horário', (
    tester,
  ) async {
    final repo = _RepositorioFalso([
      Future.value(Success(_moderada)),
      Future.value(const Failed(NetworkFailure())),
    ]);
    await _abrir(tester, repo);
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Atualizar qualidade do ar'));
    await tester.pumpAndSettle();

    expect(find.text('78'), findsOneWidget);
    expect(
      find.text('Sem conexão. Mostrando o dado das $_horaMedicao.'),
      findsOneWidget,
    );
    expect(repo.chamadas, 2);
  });
}
