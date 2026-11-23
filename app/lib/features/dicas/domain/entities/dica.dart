/// Dica de proteção respiratória exibida ao usuário.
class Dica {
  const Dica({
    required this.titulo,
    required this.descricao,
    this.grupoDeRisco = false,
  });

  final String titulo;
  final String descricao;

  /// Indica dicas voltadas a quem tem asma, DPOC ou outra doença respiratória.
  final bool grupoDeRisco;
}
