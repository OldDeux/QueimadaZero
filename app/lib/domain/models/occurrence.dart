class Occurrence {
  final String id;
  final String description;
  final double latitude;
  final double longitude;
  final DateTime timestamp;
  final String? photoPath;
  final String securityHash;
  final String status;

  const Occurrence({
    required this.id,
    required this.description,
    required this.latitude,
    required this.longitude,
    required this.timestamp,
    required this.securityHash,
    this.photoPath,
    this.status = 'pendente',
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
      'latitude': latitude,
      'longitude': longitude,
      'timestamp': timestamp.toIso8601String(),
      'photoPath': photoPath,
      'securityHash': securityHash,
      'status': status,
    };
  }

  factory Occurrence.fromJson(Map<String, dynamic> json) {
    return Occurrence(
      id: json['id'],
      description: json['description'],
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      timestamp: DateTime.parse(json['timestamp']),
      photoPath: json['photoPath'],
      securityHash: json['securityHash'],
      status: json['status'] ?? 'pendente',
    );
  }
}
