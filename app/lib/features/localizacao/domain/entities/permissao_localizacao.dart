/// Resposta do celular ao pedido de localização.
enum PermissaoLocalizacao {
  concedida,

  /// A pessoa recusou, mas o app pode pedir de novo.
  negada,

  /// A pessoa recusou de vez. Só dá para liberar nos ajustes do celular.
  negadaParaSempre,

  /// O GPS do celular está desligado.
  gpsDesligado;

  bool get permitida => this == concedida;
}
