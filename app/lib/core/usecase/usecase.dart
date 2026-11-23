import '../result.dart';

/// Contrato de todo caso de uso: recebe [Params] e devolve um [Result].
///
/// Cada caso de uso faz uma única coisa (ex.: listar dicas, enviar denúncia)
/// e depende apenas de contratos da camada de domínio.
abstract interface class UseCase<T, Params> {
  Future<Result<T>> call(Params params);
}

/// Usado pelos casos de uso que não recebem parâmetros.
final class NoParams {
  const NoParams();
}
