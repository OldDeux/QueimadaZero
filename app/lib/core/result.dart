import 'error/failures.dart';

/// Resultado de uma operação que pode falhar.
///
/// Os repositórios e casos de uso retornam [Result] em vez de lançar
/// exceções, obrigando quem chama a tratar o caso de erro.
sealed class Result<T> {
  const Result();

  /// Executa [onSuccess] ou [onFailure] conforme o resultado.
  R fold<R>(
    R Function(Failure failure) onFailure,
    R Function(T value) onSuccess,
  ) {
    return switch (this) {
      Success<T>(:final value) => onSuccess(value),
      Failed<T>(:final failure) => onFailure(failure),
    };
  }
}

final class Success<T> extends Result<T> {
  const Success(this.value);

  final T value;
}

final class Failed<T> extends Result<T> {
  const Failed(this.failure);

  final Failure failure;
}
