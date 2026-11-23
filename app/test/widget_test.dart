import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:queimada_zero/app.dart';
import 'package:queimada_zero/main.dart';

void main() {
  testWidgets('o app abre e mostra as dicas respiratórias', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(retry: semNovaTentativa, child: QueimadaZeroApp()),
    );
    await tester.pumpAndSettle();

    expect(find.text('Dicas respiratórias'), findsOneWidget);
    expect(find.text('Use máscara'), findsOneWidget);
  });
}
