import '../../../../core/result.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/dica.dart';
import '../repositories/dicas_repository.dart';

/// Lista as dicas de proteção respiratória.
class ListarDicas implements UseCase<List<Dica>, NoParams> {
  const ListarDicas(this._repository);

  final DicasRepository _repository;

  @override
  Future<Result<List<Dica>>> call(NoParams params) => _repository.listarDicas();
}
