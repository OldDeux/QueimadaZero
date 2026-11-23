import '../../../../core/result.dart';
import '../entities/dica.dart';

/// Contrato do repositório de dicas.
///
/// O domínio só conhece esta interface; a implementação fica em `data/`.
abstract interface class DicasRepository {
  Future<Result<List<Dica>>> listarDicas();
}
