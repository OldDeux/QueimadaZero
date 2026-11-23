/// Exceções lançadas pelas fontes de dados (camada `data`).
///
/// Elas nunca chegam à interface: os repositórios as convertem em
/// [Failure](failures.dart).
sealed class AppException implements Exception {
  const AppException(this.message);

  final String message;

  @override
  String toString() => '$runtimeType: $message';
}

final class NetworkException extends AppException {
  const NetworkException([super.message = 'Falha de rede.']);
}

final class ServerException extends AppException {
  const ServerException([super.message = 'Erro no servidor.', this.statusCode]);

  final int? statusCode;
}

final class CacheException extends AppException {
  const CacheException([super.message = 'Falha no armazenamento local.']);
}
