import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/result.dart';
import '../../domain/entities/localizacao.dart';
import '../../domain/entities/qualidade_ar.dart';
import '../../domain/repositories/qualidade_ar_repository.dart';
import '../datasources/qualidade_ar_remote_datasource.dart';

/// Implementação do [QualidadeArRepository] que converte exceções em falhas.
class QualidadeArRepositoryImpl implements QualidadeArRepository {
  const QualidadeArRepositoryImpl(this._remoto);

  final QualidadeArRemoteDataSource _remoto;

  @override
  Future<Result<QualidadeAr>> buscarAtual(Localizacao localizacao) async {
    try {
      return Success(await _remoto.buscar(localizacao));
    } on NetworkException catch (e) {
      return Failed(NetworkFailure(e.message));
    } on ServerException catch (e) {
      return Failed(ServerFailure(e.message));
    } catch (_) {
      return const Failed(UnexpectedFailure());
    }
  }
}
