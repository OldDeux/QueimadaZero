import '../../domain/entities/qualidade_ar.dart';

/// Versão da [QualidadeAr] que sabe ler a resposta da Open-Meteo.
class QualidadeArModel extends QualidadeAr {
  const QualidadeArModel({
    required super.indice,
    required super.pm25,
    required super.atualizadoEm,
  });

  /// Lê o bloco `current` da API de qualidade do ar da Open-Meteo.
  factory QualidadeArModel.fromOpenMeteo(Map<String, dynamic> json) {
    final atual = json['current'] as Map<String, dynamic>;
    return QualidadeArModel(
      indice: (atual['us_aqi'] as num).round(),
      pm25: (atual['pm2_5'] as num).toDouble(),
      atualizadoEm: _lerHoraUtc(atual['time'] as String),
    );
  }

  /// A Open-Meteo devolve a hora em UTC sem o "Z" no final.
  static DateTime _lerHoraUtc(String texto) =>
      DateTime.parse(texto.endsWith('Z') ? texto : '${texto}Z');
}
