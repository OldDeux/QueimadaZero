import '../../domain/entities/dica.dart';

/// Versão da [Dica] que sabe ler e gravar o formato da fonte de dados.
class DicaModel extends Dica {
  const DicaModel({
    required super.titulo,
    required super.descricao,
    super.grupoDeRisco,
  });

  factory DicaModel.fromJson(Map<String, dynamic> json) {
    return DicaModel(
      titulo: json['titulo'] as String,
      descricao: json['descricao'] as String,
      grupoDeRisco: json['grupoDeRisco'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
    'titulo': titulo,
    'descricao': descricao,
    'grupoDeRisco': grupoDeRisco,
  };
}
