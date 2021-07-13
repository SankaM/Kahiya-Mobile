class Drug {
  final String id;

  final String? name;

  final String? description;

  final String? type;

  final double? measurement;

  final String? measurementUnit;

  final String? imageUrl;

  Drug({
    required this.id,
    this.name,
    this.description,
    this.type,
    this.measurement,
    this.measurementUnit,
    this.imageUrl,
  });

  factory Drug.buildDetail(Map<String, dynamic> json) => Drug(
    id: json['id'],
    name: json['name'],
    description: json['description'],
    type: json['type'],
    measurement: json['measurement'],
    measurementUnit: json['measurementUnit'],
    imageUrl: json['imageUrl'],
  );
}
