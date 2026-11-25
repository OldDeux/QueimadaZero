/// Faixas do índice de qualidade do ar (US AQI), da melhor para a pior.
enum NivelQualidadeAr {
  boa('Boa', 'Pode fazer atividades ao ar livre normalmente.'),
  moderada(
    'Moderada',
    'Quem tem asma ou outra doença respiratória deve evitar esforço longo.',
  ),
  ruimParaSensiveis(
    'Ruim para grupos sensíveis',
    'Crianças, idosos e quem tem doença respiratória devem ficar em casa.',
  ),
  ruim('Ruim', 'Evite atividades ao ar livre e feche as janelas.'),
  muitoRuim('Muito ruim', 'Fique em casa e use máscara PFF2 se precisar sair.'),
  perigosa('Perigosa', 'Não saia de casa. Procure ajuda se tiver falta de ar.');

  const NivelQualidadeAr(this.rotulo, this.orientacao);

  final String rotulo;

  /// O que fazer nesse nível, em uma frase curta.
  final String orientacao;

  /// Faixa do índice segundo a tabela do US AQI.
  static NivelQualidadeAr doIndice(int indice) {
    if (indice <= 50) return boa;
    if (indice <= 100) return moderada;
    if (indice <= 150) return ruimParaSensiveis;
    if (indice <= 200) return ruim;
    if (indice <= 300) return muitoRuim;
    return perigosa;
  }
}

/// Qualidade do ar atual de uma cidade.
class QualidadeAr {
  const QualidadeAr({
    required this.indice,
    required this.pm25,
    required this.atualizadoEm,
  });

  /// Índice US AQI (0 a 500).
  final int indice;

  /// Concentração de partículas finas (MP2.5), em µg/m³.
  final double pm25;

  /// Horário da medição informado pela fonte.
  final DateTime atualizadoEm;

  NivelQualidadeAr get nivel => NivelQualidadeAr.doIndice(indice);
}
