import 'features/dicas/data/datasources/dicas_local_datasource.dart';
import 'features/dicas/data/repositories/dicas_repository_impl.dart';
import 'features/dicas/domain/usecases/listar_dicas.dart';

/// Ponto único onde as camadas são ligadas (composition root).
///
/// Cada feature monta aqui: fonte de dados -> repositório -> casos de uso.
/// As telas recebem só os casos de uso. Nos testes, basta criar as classes
/// com versões falsas das dependências.
///
/// A injeção é manual por enquanto; a issue #7 decide entre Riverpod e Bloc.
class AppDependencies {
  AppDependencies()
    : listarDicas = ListarDicas(
        DicasRepositoryImpl(const DicasLocalDataSourceImpl()),
      );

  final ListarDicas listarDicas;
}
