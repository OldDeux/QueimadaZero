import '../../../../core/error/exceptions.dart';
import '../models/dica_model.dart';

/// Fonte local das dicas. Fica disponível mesmo sem internet.
abstract interface class DicasLocalDataSource {
  /// Lança [CacheException] se não conseguir carregar as dicas.
  Future<List<DicaModel>> carregar();
}

class DicasLocalDataSourceImpl implements DicasLocalDataSource {
  const DicasLocalDataSourceImpl();

  static const _dicas = <Map<String, dynamic>>[
    {
      'titulo': 'Feche janelas e portas',
      'descricao': 'Evite que a fumaça entre em casa enquanto houver queimada por perto.',
    },
    {
      'titulo': 'Use máscara',
      'descricao': 'Máscaras PFF2 ou N95 filtram melhor as partículas finas (MP2.5) da fumaça.',
    },
    {
      'titulo': 'Evite exercícios ao ar livre',
      'descricao': 'Com a qualidade do ar ruim, o esforço físico aumenta a quantidade de fumaça inalada.',
    },
    {
      'titulo': 'Beba água',
      'descricao': 'Manter-se hidratado ajuda as vias respiratórias a eliminar as partículas.',
    },
    {
      'titulo': 'Tenha a medicação por perto',
      'descricao': 'Quem tem asma ou DPOC deve manter a bombinha e os remédios à mão e seguir o plano do médico.',
      'grupoDeRisco': true,
    },
    {
      'titulo': 'Procure atendimento',
      'descricao': 'Falta de ar, chiado ou dor no peito que não melhoram são sinais para buscar um serviço de saúde.',
      'grupoDeRisco': true,
    },
  ];

  @override
  Future<List<DicaModel>> carregar() async {
    try {
      return _dicas.map(DicaModel.fromJson).toList(growable: false);
    } catch (e) {
      throw CacheException('Não foi possível carregar as dicas: $e');
    }
  }
}
