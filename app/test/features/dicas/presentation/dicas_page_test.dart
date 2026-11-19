import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:queimada_zero/core/error/failures.dart';
import 'package:queimada_zero/core/result.dart';
import 'package:queimada_zero/features/dicas/domain/entities/dica.dart';
import 'package:queimada_zero/features/dicas/domain/repositories/dicas_repository.dart';
import 'package:queimada_zero/features/dicas/presentation/pages/dicas_page.dart';
import 'package:queimada_zero/features/dicas/presentation/providers/dicas_providers.dart';
import 'package:queimada_zero/main.dart';

/// Repositório falso que devolve as respostas na ordem, uma por chamada.
class _RepositorioFalso implements DicasRepository {
  _RepositorioFalso(this.respostas);

  final List<Result<List<Dica>>> respostas;
  int chamadas = 0;

  @override
  Future<Result<List<Dica>>> listarDicas() async => respostas[chamadas++];
}

Future<void> _abrir(WidgetTester tester, DicasRepository repositorio) async {
  await tester.pumpWidget(
    ProviderScope(
      retry: semNovaTentativa,
      overrides: [dicasRepositoryProvider.overrideWithValue(repositorio)],
      child: const MaterialApp(home: DicasPage()),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('mostra o estado offline quando falta conexão', (tester) async {
    await _abrir(tester, _RepositorioFalso([const Failed(NetworkFailure())]));

    expect(find.text('Você está offline'), findsOneWidget);
    expect(find.text('Tentar novamente'), findsOneWidget);
  });

  testWidgets('tentar novamente recarrega e mostra as dicas', (tester) async {
    final repositorio = _RepositorioFalso([
      const Failed(ServerFailure()),
      const Success([Dica(titulo: 'Beba água', descricao: 'Hidrate-se')]),
    ]);
    await _abrir(tester, repositorio);

    expect(find.text('Algo deu errado'), findsOneWidget);

    await tester.tap(find.text('Tentar novamente'));
    await tester.pumpAndSettle();

    expect(find.text('Beba água'), findsOneWidget);
    expect(repositorio.chamadas, 2);
  });
}
