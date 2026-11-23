import 'package:flutter_test/flutter_test.dart';
import 'package:queimada_zero/core/error/failures.dart';
import 'package:queimada_zero/core/result.dart';
import 'package:queimada_zero/core/usecase/usecase.dart';
import 'package:queimada_zero/features/dicas/domain/entities/dica.dart';
import 'package:queimada_zero/features/dicas/domain/repositories/dicas_repository.dart';
import 'package:queimada_zero/features/dicas/domain/usecases/listar_dicas.dart';

class _RepositorioFalso implements DicasRepository {
  _RepositorioFalso(this.resposta);

  final Result<List<Dica>> resposta;

  @override
  Future<Result<List<Dica>>> listarDicas() async => resposta;
}

void main() {
  test('devolve as dicas do repositório', () async {
    const dicas = [Dica(titulo: 'Use máscara', descricao: 'PFF2')];
    final listar = ListarDicas(_RepositorioFalso(const Success(dicas)));

    final resultado = await listar(const NoParams());

    expect(resultado, isA<Success<List<Dica>>>());
    expect((resultado as Success<List<Dica>>).value, dicas);
  });

  test('repassa a falha do repositório', () async {
    final listar = ListarDicas(_RepositorioFalso(const Failed(CacheFailure())));

    final resultado = await listar(const NoParams());

    expect((resultado as Failed<List<Dica>>).failure, isA<CacheFailure>());
  });
}
