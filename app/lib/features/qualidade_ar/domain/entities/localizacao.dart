/// Ponto usado para consultar os dados ambientais.
class Localizacao {
  const Localizacao({
    required this.cidade,
    required this.latitude,
    required this.longitude,
  });

  final String cidade;
  final double latitude;
  final double longitude;
}
