/// Falhas que a camada de domínio entende.
///
/// A camada de dados converte as exceções técnicas (ver `exceptions.dart`)
/// nestas falhas, para que a interface mostre um estado de erro amigável
/// em vez de quebrar.
sealed class Failure {
  const Failure(this.message);

  final String message;

  @override
  String toString() => '$runtimeType: $message';
}

/// Sem internet, timeout ou falha de conexão.
final class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'Sem conexão com a internet.']);
}

/// A API externa respondeu com erro (ex.: INPE retornando 500).
final class ServerFailure extends Failure {
  const ServerFailure([super.message = 'O serviço está indisponível.']);
}

/// Erro ao ler ou gravar dados locais.
final class CacheFailure extends Failure {
  const CacheFailure([super.message = 'Não foi possível ler os dados salvos.']);
}

/// Qualquer erro não previsto.
final class UnexpectedFailure extends Failure {
  const UnexpectedFailure([super.message = 'Ocorreu um erro inesperado.']);
}
