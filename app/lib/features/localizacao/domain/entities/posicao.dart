/// Posição do celular informada pelo GPS.
final class Posicao {
  const Posicao({
    required this.latitude,
    required this.longitude,
    required this.precisaoMetros,
    required this.horario,
  });

  final double latitude;
  final double longitude;

  /// Raio, em metros, em que a posição real deve estar.
  final double precisaoMetros;

  /// Quando o GPS mediu esta posição.
  final DateTime horario;
}
