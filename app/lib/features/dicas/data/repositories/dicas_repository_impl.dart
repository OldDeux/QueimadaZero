import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/result.dart';
import '../../domain/entities/dica.dart';
import '../../domain/repositories/dicas_repository.dart';
import '../datasources/dicas_local_datasource.dart';

/// Implementação do [DicasRepository] que converte exceções em falhas.
class DicasRepositoryImpl implements DicasRepository {
  const DicasRepositoryImpl(this._local);

  final DicasLocalDataSource _local;

  @override
  Future<Result<List<Dica>>> listarDicas() async {
    try {
      return Success(await _local.carregar());
    } on CacheException catch (e) {
      return Failed(CacheFailure(e.message));
    } catch (_) {
      return const Failed(UnexpectedFailure());
    }
  }
}
