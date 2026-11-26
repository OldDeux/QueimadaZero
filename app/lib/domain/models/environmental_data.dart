class EnvironmentalData {
  final double aqi;
  final double pm25;
  final double windSpeed;
  final double windDirection;
  final DateTime updatedAt;

  const EnvironmentalData({
    required this.aqi,
    required this.pm25,
    required this.windSpeed,
    required this.windDirection,
    required this.updatedAt,
  });

  String get airQualityLabel {
    if (aqi <= 50) return 'Boa';
    if (aqi <= 100) return 'Moderada';
    if (aqi <= 150) return 'Insalubre para grupos sensíveis';
    if (aqi <= 200) return 'Insalubre';
    if (aqi <= 300) return 'Muito insalubre';
    return 'Perigosa';
  }
}
