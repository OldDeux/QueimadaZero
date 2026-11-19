import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/usecase/usecase.dart';
import '../../data/datasources/dicas_local_datasource.dart';
import '../../data/repositories/dicas_repository_impl.dart';
import '../../domain/entities/dica.dart';
import '../../domain/repositories/dicas_repository.dart';
import '../../domain/usecases/listar_dicas.dart';

// Injeção de dependências: fonte de dados -> repositório -> caso de uso.
// Nos testes, troque qualquer elo com `overrideWithValue`.

final dicasLocalDataSourceProvider = Provider<DicasLocalDataSource>(
  (ref) => const DicasLocalDataSourceImpl(),
);

final dicasRepositoryProvider = Provider<DicasRepository>(
  (ref) => DicasRepositoryImpl(ref.watch(dicasLocalDataSourceProvider)),
);

final listarDicasProvider = Provider<ListarDicas>(
  (ref) => ListarDicas(ref.watch(dicasRepositoryProvider)),
);

// Estado da tela.

/// Lista de dicas. Em caso de falha, a tela recebe `AsyncError` com a
/// [Failure](../../../../core/error/failures.dart).
final dicasProvider = FutureProvider<List<Dica>>((ref) async {
  final resultado = await ref.watch(listarDicasProvider)(const NoParams());
  return resultado.getOrThrow();
});
